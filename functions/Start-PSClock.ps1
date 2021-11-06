Function Start-PSClock {
    [cmdletbinding()]
    [alias("psclock")]
    [OutputType("none", "PSClock")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Specify a .NET format string value like F, or G.")]
        [alias("format")]
        [ValidateNotNullOrEmpty()]
        [string]$DateFormat = "F",

        [ValidateScript({ $_ -gt 8 })]
        [alias("size")]
        [int]$FontSize = 18,

        [Parameter(HelpMessage = "Specify a font style.")]
        [ValidateSet("Normal", "Italic", "Oblique")]
        [alias("style")]
        [string]$FontStyle = "Normal",

        [Parameter(HelpMessage = "Specify a font weight.")]
        [ValidateSet("Normal", "Bold", "Light")]
        [alias("weight")]
        [string]$FontWeight = "Normal",

        [Parameter(HelpMessage = "Specify a font color like Green or an HTML code like '#FF1257EA' ")]
        [ValidateNotNullOrEmpty()]
        [string]$Color = "Black",

        [Parameter(HelpMessage = "Specify a font family.")]
        [ValidateNotNullOrEmpty()]
        [alias("family")]
        [string]$FontFamily = "Segoi UI",

        [Parameter(HelpMessage = "Do you want the clock to always be on top?")]
        [switch]$OnTop,

        [switch]$Passthru
    )

    if ($IsLinux -OR $isMacOS) {
        Write-Warning "This command requires a Windows platform."
        return
    }

    if ($global:PSClockSettings.Running) {
        Write-Warning "You already have a clock running. You can only have one clock running at a time."
        Return
    }

    if (Test-Path $env:temp\psclock-flag.txt) {
        $msg = @"

A running clock has been detected from another PowerShell session:

$(Get-Content $env:temp\psclock-flag.txt)

If this is incorrect, delete $env:temp\psclock-flag.txt and try again.

"@
        Write-Warning $msg
        Return
    }
    #validate the WPF assemblies can be loaded
    Try {
        Add-Type -AssemblyName PresentationFramework -ErrorAction Stop
        Add-Type -AssemblyName PresentationCore -ErrorAction Stop
        Add-Type -AssemblyName WindowsBase -ErrorAction Stop
    }
    Catch {
        Throw $_
    }

    #verify the datetime format
    Try {
        [void](Get-Date -Format $DateFormat -ErrorAction Stop)
    }
    Catch {
        Write-Warning "The DateFormat value $DateFormat is not a valid format string. Try something like F,G, or U which are case-sensitive."
        Return
    }

    #build a synchronized hashtable
    $global:PSClockSettings = [hashtable]::Synchronized(@{
        DateFormat = $DateFormat
        FontSize   = $FontSize
        FontStyle  = $FontStyle
        FontWeight = $FontWeight
        Color      = $Color
        FontFamily = $FontFamily
        OnTop      = $OnTop
    })

    #Run the clock in a runspace
    $rs = [RunspaceFactory]::CreateRunspace()
    $rs.ApartmentState = "STA"
    $rs.ThreadOptions = "ReuseThread"
    $rs.Open()

    $global:PSClockSettings.add("Runspace", $rs)

    $rs.SessionStateProxy.SetVariable("PSClockSettings", $global:PSClockSettings)
    $psCmd = [PowerShell]::Create().AddScript({

            Add-Type -AssemblyName PresentationFramework -ErrorAction Stop
            Add-Type -AssemblyName PresentationCore -ErrorAction Stop
            Add-Type -AssemblyName WindowsBase -ErrorAction Stop

            # a private function to stop the clock and clean up
            Function _QuitClock {
                $timer.stop()
                $timer.isenabled = $False
                $form.close()
                $PSClockSettings.Running = $False
                $cmd = {
                    Param([int]$ID)
                    $r = Get-Runspace -Id $id
                    $r.close()
                    $r.dispose()
                }
                Start-ThreadJob -ScriptBlock $cmd -ArgumentList $PSClockSettings.runspace.id
                if (Test-Path $env:temp\psclock-flag.txt) {
                    Remove-Item $env:temp\psclock-flag.txt
                }
            }

            $form = New-Object System.Windows.Window

            <#
            some of the form settings are irrelevant because it is transparent
            but leaving them in the event I need to turn off transparency
            to debug or troubleshoot
            #>dd

            $form.Title = "PSTimer"
            $form.Height = 200
            $form.Width = 400
            $form.SizeToContent = "WidthAndHeight"
            $form.AllowsTransparency = $True
            $form.Topmost = $PSClockSettings.Ontop

            $form.Background = "Transparent"
            $form.borderthickness = "1,1,1,1"
            $form.VerticalAlignment = "top"
            $form.WindowStartupLocation = "CenterScreen"
            $form.WindowStyle = "None"
            $form.ShowInTaskbar = $False

            #define events
            #call the private function to stop the clock and clean up
            $form.Add_MouseRightButtonUp({ _QuitClock })

            $form.Add_MouseLeftButtonDown({$form.DragMove()})

            #press + to increase the size and - to decrease
            #the clock needs to refresh to see the result
            $form.Add_KeyDown({
                switch ($_.key) {
                    {'Add','OemPlus' -contains $_} {
                       If ( $PSClockSettings.fontSize-ge 8) {
                           $PSClockSettings.fontSize++
                           $form.UpdateLayout()
                           }
                       }
                   {'Subtract','OemMinus' -contains $_} {
                    If ($PSClockSettings.FontSize -ge 8) {
                        $PSClockSettings.FontSize--
                        $form.UpdateLayout()
                        }
                       }
                   }
            })

            $stack = New-Object System.Windows.Controls.StackPanel

            $label = New-Object System.Windows.Controls.label
            $label.Content = Get-Date -Format $PSClockSettings.DateFormat

            $label.HorizontalContentAlignment = "Center"
            $label.Foreground = $PSClockSettings.Color
            $label.FontStyle = $PSClockSettings.FontStyle
            $label.FontWeight = $PSclockSettings.FontWeight
            $label.FontSize = $PSClockSettings.FontSize
            $label.FontFamily = $PSClockSettings.FontFamily

            $label.VerticalAlignment = "Top"

            $stack.AddChild($label)
            $form.AddChild($stack)

            $timer = New-Object System.Windows.Threading.DispatcherTimer
            $timer.Interval = [TimeSpan]"0:0:1.00"
            $timer.Add_Tick({
                    if ($PSClockSettings.Running) {
                        $label.Foreground = $PSClockSettings.Color
                        $label.FontStyle = $PSClockSettings.FontStyle
                        $label.FontWeight = $PSclockSettings.FontWeight
                        $label.FontSize = $PSClockSettings.FontSize
                        $label.FontFamily = $PSClockSettings.FontFamily
                        $label.Content = Get-Date -Format $PSClockSettings.DateFormat

                        $form.TopMost = $PSClockSettings.OnTop
                        $form.UpdateLayout()
                    }
                    else {
                        _QuitClock
                    }
                })
            $timer.Start()

            $PSClockSettings.Running = $True
            $PSClockSettings.Started = Get-Date

            [void]$form.ShowDialog()
        })


    $pscmd.runspace = $rs
    [void]$pscmd.BeginInvoke()

    "[{0}] PSClock started by {1} under PowerShell process id $pid" -f (Get-Date), $env:USERNAME |
    Out-File $env:temp\psclock-flag.txt

    if ($Passthru) {
        Start-Sleep -Seconds 1
        Get-PSClock
    }

} #close function


