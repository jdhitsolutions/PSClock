Function Start-PSClock {
    [CmdletBinding()]
    [alias('psclock')]
    [OutputType('None', 'PSClock')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Specify a .NET format string value like F, or G.',
            ValueFromPipelineByPropertyName
        )]
        [alias('format')]
        [ValidateNotNullOrEmpty()]
        [String]$DateFormat = 'F',

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ -gt 8 })]
        [alias('Size')]
        [Int]$FontSize = 18,

        [Parameter(
            HelpMessage = 'Specify a font style.',
            ValueFromPipelineByPropertyName
        )]
        [ValidateSet('Normal', 'Italic', 'Oblique')]
        [alias('Style')]
        [String]$FontStyle = 'Normal',

        [Parameter(
            HelpMessage = 'Specify a font weight.',
            ValueFromPipelineByPropertyName
        )]
        [ValidateSet('Normal', 'Bold', 'Light', 'Medium', 'SemiBold')]
        [alias('Weight')]
        [String]$FontWeight = 'Normal',

        [Parameter(
            HelpMessage = "Specify a font color like Green or an HTML code like '#FF1257EA'",
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Color = 'White',

        [Parameter(
            HelpMessage = 'Specify a font family.',
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [alias('Family')]
        [String]$FontFamily = 'Segoi UI',

        [Parameter(
            HelpMessage = 'Do you want the clock to always be on top?',
            ValueFromPipelineByPropertyName
        )]
        [Switch]$OnTop,

        [Parameter(
            HelpMessage = 'Specify the clock position as an array of left and top values.',
            ValueFromPipelineByPropertyName
        )]
        [ValidateCount(2, 2)]
        [Int32[]]$Position,

        [Parameter(HelpMessage = 'Force a new PSClock, ignoring any previously saved settings. The saved settings file will remain.')]
        [Switch]$Force,

        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell $($PSVersionTable.PSVersion)"
    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Validating"
        if ($IsLinux -OR $isMacOS) {
            Write-Warning 'This command requires a Windows platform.'
            return
        }

        if ($PSClockSettings.Running) {
            Write-Warning 'You already have a clock running. You can only have one clock running at a time.'
            Return
        }

        if (Test-Path $env:temp\psclock-flag.txt) {
            $msg = @"

A running clock has been detected from another PowerShell session:

$(Get-Content $env:temp\psclock-flag.txt)

If this is incorrect, delete $env:temp\psclock-flag.txt and try again.

"@
            Write-Warning $msg
            $r = Read-Host 'Do you want to remove the flag file? Y/N'
            if ($r -eq 'Y') {
                Remove-Item $env:temp\psclock-flag.txt
            }
            else {
                #bail out
                Return
            }
        }

        #verify the DateTime format
        Try {
            [void](Get-Date -Format $DateFormat -ErrorAction Stop)
        }
        Catch {
            Write-Warning "The DateFormat value $DateFormat is not a valid format string. Try something like F,G, or U which are case-sensitive."
            Return
        }

        #Test if there is a saved settings file and no other parameters have been called
        # $SavePath is a module-scoped variable set in the psm1 file
        # $SavePath = Join-Path -Path $home -ChildPath PSClockSettings.xml
        if ((Test-Path $SavePath) -AND (-not $Force)) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using saved settings"
            $import = Import-Clixml -Path $SavePath
            foreach ($prop in $import.PSObject.properties) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using imported value for $($prop.name)"
                Set-Variable -Name $prop.name -Value $prop.Value
            }
        }

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Building a synchronized hashtable"
        $global:PSClockSettings = [hashtable]::Synchronized(@{
                DateFormat       = $DateFormat
                FontSize         = $FontSize
                FontStyle        = $FontStyle
                FontWeight       = $FontWeight
                Color            = $Color
                FontFamily       = $FontFamily
                OnTop            = $OnTop
                StartingPosition = $Position
                CurrentPosition  = $Null
                CommandPath      = $PSScriptRoot
            })
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($global:PSClockSettings | Out-String)"
        #Run the clock in a runspace
        $rs = [RunspaceFactory]::CreateRunspace()
        $rs.ApartmentState = 'STA'
        $rs.ThreadOptions = 'ReuseThread'
        $rs.Open()

        $global:PSClockSettings.add('Runspace', $rs)

        $rs.SessionStateProxy.SetVariable('PSClockSettings', $global:PSClockSettings)

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Defining the runspace command"
        $PSCmd = [PowerShell]::Create().AddScript({
            Add-Type -AssemblyName PresentationFramework -ErrorAction Stop
            Add-Type -AssemblyName PresentationCore -ErrorAction Stop

            #dot source the private settings preview function
            $previewFunction = Join-Path -Path "$($global:PSClockSettings.CommandPath)" -childPath ClockSettingsPreview.ps1
            . $previewFunction
            # a private function to stop the clock and clean up
            Function _QuitClock {
                $timer.stop()
                $timer.IsEnabled = $False
                $form.close()
                $PSClockSettings.Running = $False

                #define a thread job to clean up the runspace
                $cmd = {
                    Param([Int]$ID)
                    $r = Get-Runspace -Id $id
                    $r.close()
                    $r.dispose()
                }
                Start-ThreadJob -ScriptBlock $cmd -ArgumentList $PSClockSettings.runspace.id

                #delete the flag file
                if (Test-Path $env:temp\psclock-flag.txt) {
                    Remove-Item $env:temp\psclock-flag.txt
                }
            }

            $form = New-Object System.Windows.Window

            <#
            Some of the form settings are irrelevant because the form is transparent,
            but leaving them in the event I need to turn off transparency
            to debug or troubleshoot.
            #>

            $form.Title = 'PSClock'
            $form.Height = 200
            $form.Width = 400
            $form.SizeToContent = 'WidthAndHeight'
            $form.AllowsTransparency = $True
            $form.Topmost = $PSClockSettings.OnTop

            $form.Background = 'Transparent'
            $form.BorderThickness = '1,1,1,1'
            $form.VerticalAlignment = 'top'

            if ($PSClockSettings.StartingPosition) {
                $form.left = $PSClockSettings.StartingPosition[0]
                $form.top = $PSClockSettings.StartingPosition[1]
            }
            else {
                $form.WindowStartupLocation = 'CenterScreen'
            }
            $form.WindowStyle = 'None'
            $form.ShowInTaskbar = $False

            #define events
            #call the private function to stop the clock and clean up
            $form.Add_MouseRightButtonUp({ _QuitClock })

            $form.Add_MouseLeftButtonDown({
                #temporarily stop the timer while moving the clock
                $timer.stop()
                $form.DragMove()
                #update the positions
                $PSClockSettings.CurrentPosition = $form.left, $form.top
                #restart the timer
                $timer.start()
            })

            #press + to increase the size and - to decrease
            #the clock needs to refresh to see the result
            $form.Add_KeyDown({
                switch ($_.key) {
                    { 'Add', 'OemPlus' -contains $_ } {
                        If ( $PSClockSettings.fontSize -ge 8) {
                            $PSClockSettings.fontSize++
                            $form.UpdateLayout()
                        }
                    }
                    { 'Subtract', 'OemMinus' -contains $_ } {
                        If ($PSClockSettings.FontSize -ge 8) {
                            $PSClockSettings.FontSize--
                            $form.UpdateLayout()
                        }
                    }
                    { 'P' -contains $_ } {
                        #show the preview settings form
                        Show-PSClockSettingPreview
                    }
                }
            })

            #fail safe to remove flag file
            $form.Add_Unloaded({
                if (Test-Path $env:temp\psclock-flag.txt) {
                    Remove-Item $env:temp\psclock-flag.txt
                }
            })

            $stack = New-Object System.Windows.Controls.StackPanel

            $label = New-Object System.Windows.Controls.label
            $label.Content = Get-Date -Format $PSClockSettings.DateFormat

            $label.HorizontalContentAlignment = 'Center'
            $label.Foreground = $PSClockSettings.Color
            $label.FontStyle = $PSClockSettings.FontStyle
            $label.FontWeight = $PSClockSettings.FontWeight
            $label.FontSize = $PSClockSettings.FontSize
            $label.FontFamily = $PSClockSettings.FontFamily

            $label.VerticalAlignment = 'Top'

            $stack.AddChild($label)
            $form.AddChild($stack)

            $timer = New-Object System.Windows.Threading.DispatcherTimer
            $timer.Interval = [TimeSpan]'0:0:1.00'
            $timer.Add_Tick({
                if ($PSClockSettings.Running) {
                    $label.Foreground = $PSClockSettings.Color
                    $label.FontStyle = $PSClockSettings.FontStyle
                    $label.FontWeight = $PSClockSettings.FontWeight
                    $label.FontSize = $PSClockSettings.FontSize
                    $label.FontFamily = $PSClockSettings.FontFamily
                    $label.Content = Get-Date -Format $PSClockSettings.DateFormat

                    $form.TopMost = $PSClockSettings.OnTop
                    $form.left = $PSClockSettings.CurrentPosition[0]
                    $form.top = $PSClockSettings.CurrentPosition[1]
                    $form.UpdateLayout()

                    $PSClockSettings.CurrentPosition = $form.left, $form.top
                }
                else {
                    _QuitClock
                }
            })
            $timer.Start()

            $PSClockSettings.Running = $True
            $PSClockSettings.Started = Get-Date
            #Show the clock form
            [void]$form.ShowDialog()
        })

        $PSCmd.runspace = $rs
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Launching the runspace"
        [void]$PSCmd.BeginInvoke()

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating the flag file $env:temp\psclock-flag.txt"
        "[{0}] PSClock started by {1} under PowerShell process id $pid" -f (Get-Date), $env:USERNAME |
        Out-File -FilePath $env:temp\psclock-flag.txt

        if ($PassThru) {
            Start-Sleep -Seconds 1
            Get-PSClock
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close function
