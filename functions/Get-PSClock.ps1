Function Get-PSClock {
    [cmdletbinding()]
    [Outputtype("psclock")]
    Param()

    if ($IsLinux -OR $isMacOS) {
        Write-Warning "This command requires a Windows platform"
        return
    }

    if ($PSClockSettings) {
        #remove runspace if not running
        if ( -not ($Global:PSClockSettings.running)) {
            $global:PSClockSettings.remove("Runspace")
        }

        [psCustomObject]@{
            PSTypeName = "PSClock"
            Started    = $Global:PSClockSettings.Started
            Format     = $Global:PSClockSettings.DateFormat
            Output     = (Get-Date -Format $Global:PSClockSettings.DateFormat)
            Running    = $Global:PSClockSettings.Running
            FontFamily = $Global:PSClockSettings.FontFamily
            Size       = $global:PSClockSettings.fontSize
            Weight     = $global:PSClockSettings.FontWeight
            Color      = $global:PSClockSettings.Color
            Style      = $global:PSClockSettings.FontStyle
            OnTop      = $Global:PSClockSettings.OnTop
            RunspaceID = $Global:PSClockSettings.Runspace.id
        }
    }
    Else {
        Write-Warning "Can't find a PSClock. Do you need to start one?"
    }
}