Function Get-PSClock {
    [CmdletBinding()]
    [OutputType('PSClock')]
    [Alias('gpc')]
    Param()

    _verbose ($strings.Starting -f $MyInvocation.MyCommand)
    if ($MyInvocation.CommandOrigin -eq 'Runspace') {
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $Host.Name)
    }

    #test if there is a settings hashtable
    if ($global:PSClockSettings) {
        #remove runspace setting if not running
        if ( -not ($global:PSClockSettings.running)) {
            $global:PSClockSettings.remove('Runspace')
        }

        [PSCustomObject]@{
            PSTypeName      = 'PSClock'
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
        Write-Warning $strings.CantFind
    }

    _verbose ($strings.Ending -f $MyInvocation.MyCommand)
}
