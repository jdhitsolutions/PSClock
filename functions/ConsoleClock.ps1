#functions for displaying a clock in a PowerShell console session

#region Exported functions

function Start-ConsoleClock {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('none')]
    [alias('scc')]
    param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Specify the date time formatting.'
        )]
        [PSDefaultValue(Help = 'F')]
        [ValidateNotNullOrEmpty()]
        [string]$Format = 'F',

        [Parameter(HelpMessage = 'Specify an ANSI style or console color for the clock display.')]
        [PSDefaultValue(Help = 'Yellow')]
        [ValidateNotNullOrEmpty()]
        [string]$DisplayColor = 'Yellow',

        [Parameter(HelpMessage = 'Add a line border to the display.')]
        [switch]$Border,

        [Parameter(HelpMessage = 'Specify an ANSI or console color for the border.')]
        [ValidateNotNullOrEmpty()]
        [string]$BorderColor = 'Green'
    )

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            _verbose ($strings.Running -f $PSVersionTable.PSVersion)
            _verbose ($strings.UsingModule -f $modVersion)
            _verbose ($strings.Detected -f $Host.Name)
        }
        Write-Information $PSBoundParameters -Tags runtime
    } #begin

    process {
        if ($host.Name -ne 'ConsoleHost') {
            Write-Warning $strings.RequiresConsole
            return
        }
        _verbose ($strings.UsingDateFormat -f $Format)

        #create $global:consoleClockSettings
        $svParams = @{
            Name        = "consoleClockSettings"
            Scope       = "global"
            Description = "This is used by the PSClock module. Do not manually remove."
            Value       = [ordered]@{
                            Format       = $Format
                            DisplayColor = ConvertTo-AnsiColor $DisplayColor
                            Border       = $Border
                            BorderColor  = ConvertTo-AnsiColor $BorderColor
                            Note         = "This is used by the PSClock module. Do not manually remove."
                           }
        }
        Set-Variable @svParams
        Write-Information $global:consoleClockSettings -Tags runtime
        if ($script:clockEvent) {
            Write-Warning $strings.ExistingConsoleClock
        }
        else {
            #the action scriptblock needs to be self-contained or able to reference globally scoped items
            $action = {
                #if the global settings hashtable is removed, do not run and stop the clock
                if (-Not $global:consoleClockSettings.Format) {
                    Stop-ConsoleClock
                    return
                }

                #dot source the helper functions from the PSClock module if required
                $modPath = (Get-Module PSClock).path | Split-Path -Parent
                $funPath = Join-Path -Path $modPath -ChildPath 'functions\ConsoleClockHelpers.ps1'
                . $funPath
                if ($global:consoleClockSettings.Border) {
                    #add an offset if there is a Border
                    $offSet = 5
                }
                else {
                    $offset = 1
                }

                [string]$dt = Get-Date -Format $global:consoleClockSettings.Format
                $fmtDt = "{0}$dt{1}" -f (ConvertTo-AnsiColor $global:consoleClockSettings.DisplayColor), "$([char]27)[0m"

                #define the cursor position in console
                $here = $host.ui.RawUI.CursorPosition
                $x = $Host.UI.RawUI.WindowSize.Width - $dt.length - $offSet
                $consolePosition = [System.Management.Automation.Host.Coordinates]::new($x, 0)
                $host.ui.RawUI.CursorPosition = $consolePosition
                if ($global:consoleClockSettings.Border) {
                    Format-BorderBox -text $fmtDt -BorderColor (ConvertTo-AnsiColor $global:consoleClockSettings.BorderColor) -Position $consolePosition
                }
                else {
                    Write-Host $fmtDt -NoNewline
                }
                #reset the cursor position
                $host.ui.RawUI.CursorPosition = $here
                Start-Sleep -Milliseconds 100
            } #close action

            Write-Information $action
            _verbose $strings.RegisterConsoleClock
            #Register-EngineEvent doesn't natively support -WhatIf so I have to do it.
            if ($PSCmdlet.ShouldProcess("Get-Date -format $format")) {
                #hide the subscription
                Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -Action $action -SupportEvent
                $script:clockEvent = Get-EventSubscriber -Force | Sort-Object SubscriptionId | Select-Object -Last 1
                _verbose ($strings.UsingSubscription -f $script:clockEvent.SubscriptionID)
            } #WhatIf
        }
    } #process

    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

} #close Start-ConsoleClock

function Stop-ConsoleClock {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('none')]
    [alias('stcc')]
    param( )

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            _verbose ($strings.Running -f $PSVersionTable.PSVersion)
            _verbose ($strings.UsingModule -f $modVersion)
            _verbose ($strings.Detected -f $Host.Name)
        }
    } #begin

    process {
        _verbose $strings.StoppingConsole
        if ($script:clockEvent) {
            _verbose ($strings.Unregister -f $($script:clockEvent.SubscriptionId))
            Unregister-Event -SubscriptionId $script:clockEvent.SubscriptionId -Force
            Remove-Variable -Name clockEvent -Scope Script -Force -ErrorAction SilentlyContinue
            Remove-Variable -Name consoleClockSettings -Scope Global -Force -ErrorAction SilentlyContinue
        }
        else {
            Write-Warning $strings.NoConsoleClock
        }
    } #process

    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

} #close Stop-ConsoleClock

#endregion