Function Stop-PSClock {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("none")]
    Param()

    _verbose ($strings.Starting -f $MyInvocation.MyCommand)
    _verbose ($strings.Running -f $PSVersionTable.PSVersion)
    _verbose ($strings.Detected -f $Host.Name)

    if ($PSClockSettings -And $PSClockSettings.Running) {
        if ($PSCmdlet.ShouldProcess("PSClock [runspace id $($PSClockSettings.runspace.id)]")) {
            $PSClockSettings.Running = $False
        }
    }
    else {
        Write-Warning $strings.CantFind
    }
    _verbose ($strings.Ending -f $MyInvocation.MyCommand)
}
