Function Stop-PSClock {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("none")]
    Param()

    Write-Verbose "Starting ($MyInvocation.MyCommand)"
    Write-Verbose "Running under PowerShell $($PSVersionTable.PSVersion)"

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
