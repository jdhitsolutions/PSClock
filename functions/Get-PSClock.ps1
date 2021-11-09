Function Get-PSClock {
    [cmdletbinding()]
    [Outputtype("psclock")]
    Param()

    #verify the OS. This should never be needed. Added as a failsafe.
    if ($IsLinux -OR $isMacOS) {
        Write-Warning "This command requires a Windows platform"
        return
    }

    #gtest if there is a settings hashtable
    if ($global:PSClockSettings) {
        #remove runspace setting if not running
        if ( -not ($global:PSClockSettings.running)) {
            $global:PSClockSettings.remove("Runspace")
        }

        [pscustomobject]@{
            PSTypeName      = "PSClock"
            Started         = $global:PSClockSettings.Started
            Format          = $global:PSClockSettings.DateFormat
            Output          = (Get-Date -Format $global:PSClockSettings.DateFormat)
            Running         = $global:PSClockSettings.Running
            FontFamily      = $global:PSClockSettings.FontFamily
            Size            = $global:PSClockSettings.fontSize
            Weight          = $global:PSClockSettings.FontWeight
            Color           = $global:PSClockSettings.Color
            Style           = $global:PSClockSettings.FontStyle
            OnTop           = $global:PSClockSettings.OnTop
            CurrentPosition = $global:PSClockSettings.CurrentPosition
            RunspaceID      = $global:PSClockSettings.Runspace.id
        }
    }
    Else {
        Write-Warning "Can't find a PSClock. Do you need to start one?"
    }
}