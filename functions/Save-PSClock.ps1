Function Save-PSClock {
    [CmdletBinding(SupportsShouldProcess)]
    Param()

    Write-Verbose "Starting $($MyInvocation.MyCommand)"
    Write-Verbose "Running under PowerShell $($PSVersionTable.PSVersion)"

    if ($IsLinux -OR $isMacOS) {
        Write-Warning "This command requires a Windows platform"
        return
    }

    #define a list of properties to export
    $props = @{Name="DateFormat";Expression={$_.Format}},"Color",
    @{Name="FontSize";Expression={$_.Size}},
    @{Name="FontWeight";Expression={$_.weight}},"FontFamily",
    @{Name="FontStyle";Expression={$_.Style}},"OnTop",
    @{Name="Position";Expression = {$_.CurrentPosition}}

    if ($global:PSClockSettings) {
        Write-Verbose "Saving PSClock settings to $SavePath"
        Get-PSClock | Select-Object -property $props | Export-Clixml -Path $SavePath
    }
    else {
        Write-Warning "Can't find a PSClock. Do you need to start one?"
    }

    Write-Verbose "Ending $($MyInvocation.MyCommand)"
}
