Function Stop-PSClock {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("none")]
    Param()

    if ($IsLinux -OR $isMacOS) {
        Write-Warning "This command requires a Windows platform"
        return
    }

    if ($PSClockSettings -And $PSClockSettings.Running) {
        if ($PSCmdlet.ShouldProcess("PSClock [runspace id $($PSClockSettings.runspace.id)]")) {
            $PSClockSettings.Running = $False
        }
    }
    else {
        Write-Warning "Can't find a running clock."
    }
}
