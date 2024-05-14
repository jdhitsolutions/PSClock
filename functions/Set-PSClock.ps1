
Function Set-PSClock {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("none")]
    [Alias("spc")]
    Param(
        [Parameter(
            Position=0,
            HelpMessage = "Specify a font color like Green or an HTML code like '#FF1257EA'",
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Color,

        [Parameter(
            Position = 1,
            HelpMessage = "Specify a .NET format string value like F, or G.",
            ValueFromPipelineByPropertyName
        )]
        [alias("format")]
        [ValidateNotNullOrEmpty()]
        [String]$DateFormat,

        [Parameter(
            HelpMessage = "How large do you want the font size?",
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript({ $_ -gt 8 })]
        [alias("size")]
        [Int]$FontSize,

        [Parameter(
            HelpMessage = "Specify a font style.",
            ValueFromPipelineByPropertyName
        )]
        [ValidateSet("Normal", "Italic", "Oblique")]
        [alias("style")]
        [String]$FontStyle,

        [Parameter(
            HelpMessage = "Specify a font weight.",
            ValueFromPipelineByPropertyName
        )]
        [ValidateSet("Normal", "Bold", "Light")]
        [alias("weight")]
        [String]$FontWeight,

        [Parameter(
            HelpMessage = "Specify a font family.",
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [alias("family")]
        [String]$FontFamily,

        [Parameter(
            HelpMessage = "Should the clock be on top of other applications?",
            ValueFromPipelineByPropertyName
        )]
        [Switch]$OnTop,

        [Switch]$PassThru
    )

    Write-Verbose "Starting ($MyInvocation.MyCommand)"
    Write-Verbose "Running under PowerShell $($PSVersionTable.PSVersion)"

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

        if ($PassThru) {
            Start-Sleep -Seconds 1
            Get-PSClock
        }
    } #if running clock found
    else {
        Write-Warning "Can't find a running clock. Do you need to start one?"
    }

    Write-Verbose "Ending ($MyInvocation.MyCommand)"
}

