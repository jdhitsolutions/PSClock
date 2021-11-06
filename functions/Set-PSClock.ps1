
Function Set-PSClock {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("none")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Specify a .NET format string value like F, or G.",ValueFromPipelineByPropertyName)]
        [alias("format")]
        [ValidateNotNullOrEmpty()]
        [string]$DateFormat,

        [Parameter(HelpMessage = "How large do you want the font size?",ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ -gt 8 })]
        [alias("size")]
        [int]$FontSize,

        [Parameter(HelpMessage = "Specify a font style.",ValueFromPipelineByPropertyName)]
        [ValidateSet("Normal", "Italic", "Oblique")]
        [alias("style")]
        [string]$FontStyle,

        [Parameter(HelpMessage = "Specify a font weight.",ValueFromPipelineByPropertyName)]
        [ValidateSet("Normal", "Bold", "Light")]
        [alias("weight")]
        [string]$FontWeight,

        [Parameter(HelpMessage = "Specify a font family.",ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [alias("family")]
        [string]$FontFamily,

        [Parameter(HelpMessage = "Specify a font color like Green or an HTML code like '#FF1257EA'",ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$Color,

        [Parameter(HelpMessage = "Should the clock be on top of other applications?",ValueFromPipelineByPropertyName)]
        [switch]$OnTop,

        [switch]$Passthru
    )

    Write-Verbose "Starting ($myinvocation.mycommand)"
    if ($IsLinux -OR $isMacOS) {
        Write-Warning "This command requires a Windows platform"
        return
    }

    $settings = "FontSize", "FontStyle", "FontWeight", "Color", "OnTop", "DateFormat", "FontFamily"
    if ($PSClockSettings -And $PSClockSettings.Running) {
        Foreach ($setting in $settings) {
            if ($PSBoundParameters.ContainsKey($setting)) {
                $value = $PSBoundParameters[$setting]
                $action = "Setting value to $value"
                Write-Verbose "Setting $setting to $value"
                if ($PSCmdlet.ShouldProcess($setting, $action)) {
                    $Global:PSClockSettings[$setting] = $Value
                }
            }
        } #foreach setting

        if ($Passthru) {
            Start-Sleep -Seconds 1
            Get-PSClock
        }
    } #if running clock found
    else {
        Write-Warning "Can't find a running clock. Do you need to start one?"
    }

    Write-Verbose "Ending ($myinvocation.mycommand)"
}

