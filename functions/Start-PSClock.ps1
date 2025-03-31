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
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $Host.Name)
    } #begin
    Process {
        _verbose $strings.Validating

        if ($PSClockSettings.Running) {
            Write-Warning $strings.RunningClock
            Return
        }

        #FlagPath is a module-scoped variable set in the psm1 file
        if (Test-Path $FlagPath) {
            Write-Warning ($strings.FlagFound -f (Get-Content -path $FlagPath),$FlagPath)

            $r = Read-Host $strings.RemovePrompt
            if ($r -eq 'Y') {
                Remove-Item $FlagPath
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
            Write-Warning ($strings.WarnDateFormat -f $DateFormat)
            Return
        }

        #Test if there is a saved settings file and no other parameters have been called
        # $SavePath is a module-scoped variable set in the psm1 file
        # $SavePath = Join-Path -Path $home -ChildPath PSClockSettings.xml
        if ((Test-Path $SavePath) -AND (-not $Force)) {
            _verbose $strings.UsingSaved
            $import = Import-Clixml -Path $SavePath
            foreach ($prop in $import.PSObject.properties) {
                _verbose ($strings.UsingImported -f $prop.name)
                Set-Variable -Name $prop.name -Value $prop.Value
            }
        }

        _verbose $strings.SynchHash
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
        Write-Debug $global:PSClockSettings
        #Run the clock in a runspace
        $rs = [RunspaceFactory]::CreateRunspace()
        $rs.ApartmentState = 'STA'
        $rs.ThreadOptions = 'ReuseThread'
        $rs.Open()

        $global:PSClockSettings.add('Runspace', $rs)

        #pass variable values to the runspace
        $rs.SessionStateProxy.SetVariable('PSClockSettings', $global:PSClockSettings)
        $rs.SessionStateProxy.SetVariable('FlagPath', $script:FlagPath)

        _verbose $strings.DefiningRunspace
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
                if (Test-Path $FlagPath) {
                    Remove-Item $FlagPath
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
                if (Test-Path $FlagPath) {
                    Remove-Item $FlagPath
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
        _verbose $strings.Launching
        [void]$PSCmd.BeginInvoke()
        Write-Information -MessageData $PSCmd -Tags raw

        _verbose ($strings.CreatingFlag -f "$FlagPath")
        "[{0}] PSClock started by {1} under PowerShell process id $pid" -f (Get-Date), $env:USERNAME |
        Out-File -FilePath $FlagPath

        if ($PassThru) {
            Start-Sleep -Seconds 1
            Get-PSClock
        }
    } #process
    End {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

} #close function
