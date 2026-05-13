#insert a clock and arbitrary data into the session title

function Start-TitleClock {
    [cmdletbinding(SupportsShouldProcess)]
    [Alias('stc')]
    [OutputType('None')]
    param (
        [Parameter(
            Position = 0,
            HelpMessage = 'Specify the date time formatting. This is required.'
        )]
        [PSDefaultValue(Help = 'T')]
        [ValidateNotNullOrEmpty()]
        [string]$Format = 'T',

        [Parameter(HelpMessage = 'Display a static text message')]
        [ValidateNotNullOrEmpty()]
        [string]$Text,

        [Parameter(HelpMessage = 'Display a variable value. Enter the variable name without the $.')]
        [ValidateNotNullOrEmpty()]
        [string]$Variable,

        [Parameter(HelpMessage = 'Show the PowerShell Version number')]
        [switch]$PSVersion,

        [Parameter(HelpMessage = 'Show the current location')]
        [switch]$Location,

        [Parameter(HelpMessage = "Specify the separator character.")]
        [PSDefaultValue(Help = "|")]
        [ValidateNotNullOrEmpty()]
        [char]$Separator = "|"
    )

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            _verbose ($strings.Running -f $PSVersionTable.PSVersion)
            _verbose ($strings.UsingModule -f $modVersion)
            _verbose ($strings.Detected -f $Host.Name)
        }
        Write-Information $PSBoundParameters -Tags runtime
        #save the current window title
        $script:savedTitle = $Host.UI.RawUI.WindowTitle
    } #begin

    process {
        if ($host.Name -ne 'ConsoleHost') {
            Write-Warning $strings.RequiresConsole
            return
        }
        _verbose ($strings.UsingDateFormat -f $Format)

        $svParams = @{
            Name        = 'titleClockSettings'
            Scope       = 'global'
            Description = 'This is used by the PSClock module. Do not manually remove.'
            Value       = [ordered]@{
                Format    = $Format
                PSVersion = $PSVersion
                Text      = $Text
                Variable  = $Variable
                Location  = $Location
                Separator = $Separator
                Note      = 'This is used by the PSClock module. Do not manually remove.'
            }
        }
        Set-Variable @svParams
        Write-Information $global:titleClockSettings -Tags runtime

        if ($script:titleClockEvent) {
            Write-Warning $strings.ExistingTitleClock
        }
        else {
            $action = {
                #if the global settings hashtable is removed, do not run and stop the clock
                if ($global:titleClockSettings.Format) {
                    [string]$display = Get-Date -Format $global:titleClockSettings.Format
                    $Separator = $global:titleClockSettings.Separator
                    if ($global:titleClockSettings.PSVersion) {
                        $display += " $Separator PS$($PSVersionTable.PSVersion)"
                    }
                    if ($global:titleClockSettings.Text) {
                        $display += " $Separator $($titleClockSettings.Text)"
                    }
                    if ($global:titleClockSettings.Variable) {
                        $display += " $Separator $((Get-Variable -Name $global:titleClockSettings.Variable).Value)"
                    }
                    if ($global:titleClockSettings.Location) {
                        $display += " $Separator $pwd"
                    }

                    #update Window title
                    $Host.UI.RawUI.WindowTitle = $display
                    Start-Sleep -Milliseconds 100
                } #if settings found
                else {
                    Stop-TitleClock
                }
            } #close Action

            Write-Information $action
            _verbose $strings.RegisterTitleClock
            #Register-EngineEvent doesn't natively support -WhatIf so I have to do it.
            if ($PSCmdlet.ShouldProcess('session title clock')) {
                #hide the subscription
                Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -Action $action -SupportEvent
                $script:titleClockEvent = Get-EventSubscriber -Force | Sort-Object SubscriptionId | Select-Object -Last 1
                _verbose ($strings.UsingSubscription -f $script:clockEvent.SubscriptionID)
            } #WhatIf
        }
    } #process
    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end
}

function Stop-TitleClock {
    [cmdletbinding(SupportsShouldProcess)]
    [Alias('sttc')]
    [OutputType('None')]
    param()

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            _verbose ($strings.Running -f $PSVersionTable.PSVersion)
            _verbose ($strings.UsingModule -f $modVersion)
            _verbose ($strings.Detected -f $Host.Name)
        }
    } #begin

    process {
        _verbose $strings.StoppingTitle
        if ($script:titleClockEvent) {
            _verbose ($strings.Unregister -f $($script:titleClockEvent.SubscriptionId))
            Unregister-Event -SubscriptionId $script:titleClockEvent.SubscriptionId -Force
            Remove-Variable -Name titleClockEvent -Scope Script -Force -ErrorAction SilentlyContinue
            Remove-Variable -Name titleClockSettings -Scope Global -Force -ErrorAction SilentlyContinue
            _verbose $strings.Restoring
            $Host.UI.RawUI.WindowTitle = $script:savedTitle
        }
        else {
            Write-Warning $strings.NoTitleClock
        }
    } #process

    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end
}