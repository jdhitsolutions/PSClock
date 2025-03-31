Function Save-PSClock {
    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(HelpMessage = "Display the file with saved settings.")]
        [switch]$Passthru
    )
    _verbose ($strings.Starting -f $MyInvocation.MyCommand)
    _verbose ($strings.Running -f $PSVersionTable.PSVersion)
    _verbose ($strings.Detected -f $Host.Name)

    #define a list of properties to export
    $props = @{Name="DateFormat";Expression={$_.Format}},"Color",
    @{Name="FontSize";Expression={$_.Size}},
    @{Name="FontWeight";Expression={$_.weight}},"FontFamily",
    @{Name="FontStyle";Expression={$_.Style}},"OnTop",
    @{Name="Position";Expression = {$_.CurrentPosition}}

    if ($global:PSClockSettings) {
        _verbose ($strings.Saving -f $SavePath)
        Get-PSClock | Select-Object -property $props | Export-Clixml -Path $SavePath
        If ($Passthru -AND (-Not $WhatIfPreference)) {
            Get-Item -Path $SavePath
        }
    }
    else {
        Write-Warning $strings.CantFind
    }

    _verbose ($strings.Ending -f $MyInvocation.MyCommand)
}
