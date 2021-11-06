
Function Set-PSClock {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("none")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Specify a .NET format string value like F, or G.")]
        [alias("format")]
        [ValidateNotNullOrEmpty()]
        [string]$DateFormat,

        [Parameter(HelpMessage = "How large do you want the font size?")]
        [ValidateScript({ $_ -gt 8 })]
        [alias("size")]
        [int]$FontSize,

        [Parameter(HelpMessage = "Specify a font style.")]
        [ValidateSet("Normal", "Italic", "Oblique")]
        [alias("style")]
        [string]$FontStyle,

        [Parameter(HelpMessage = "Specify a font weight.")]
        [ValidateSet("Normal", "Bold", "Light")]
        [alias("weight")]
        [string]$FontWeight,

        [Parameter(HelpMessage = "Specify a font family.")]
        [ValidateNotNullOrEmpty()]
        [alias("family")]
        [string]$FontFamily,

        [Parameter(HelpMessage = "Specify a font color like Green or an HTML code like '#FF1257EA' ")]
        [ValidateNotNullOrEmpty()]
        [string]$Color,

        [Parameter(HelpMessage = "Should the clock be on top of other applications?")]
        [switch]$OnTop,

        [switch]$Passthru
    )

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
}

