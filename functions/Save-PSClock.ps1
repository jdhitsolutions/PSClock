Function Save-PSClock {
    [CmdletBinding(SupportsShouldProcess)]
    Param()

    Write-Verbose "Starting $($myinvocation.MyCommand)"
    if ($IsLinux -OR $isMacOS) {
        Write-Warning "This command requires a Windows platform"
        return
    }

    $props = "DateFormat","Color","FontSize","FontWeight","FontFamily",
    "FontStyle","OnTop",@{Name="Position";Expression = {$_.CurrentPosition}}

    if ($global:PSClockSettings) {
        Write-Verbose "Saving PSClock settings to $SavePath"
        $global:PSClockSettings | Select-Object -property $props | Export-Clixml -Path $SavePath
    }
    else {
        Write-Warning "Can't find a PSClock. Do you need to start one?"
    }

    Write-Verbose "Ending $($myinvocation.MyCommand)"
}