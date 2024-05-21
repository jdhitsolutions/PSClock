
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
        [alias("Format")]
        [ValidateNotNullOrEmpty()]
        [String]$DateFormat,

        [Parameter(
            HelpMessage = "How large do you want the font size?",
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript({ $_ -gt 8 })]
        [alias("Size")]
        [Int]$FontSize,

        [Parameter(
            HelpMessage = "Specify a font style.",
            ValueFromPipelineByPropertyName
        )]
        [ValidateSet("Normal", "Italic", "Oblique")]
        [alias("Style")]
        [String]$FontStyle,

        [Parameter(
            HelpMessage = "Specify a font weight.",
            ValueFromPipelineByPropertyName
        )]
        [ValidateSet('Normal', 'Bold', 'Light', 'Medium', 'SemiBold')]
        [alias("Weight")]
        [String]$FontWeight,

        [Parameter(
            HelpMessage = "Specify a font family.",
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [alias("Family")]
        [String]$FontFamily,

        [Parameter(
            HelpMessage = "Should the clock be on top of other applications?",
            ValueFromPipelineByPropertyName
        )]
        [Switch]$OnTop,

        [Parameter(
            HelpMessage = "Specify an array of (X,Y) coordinates for the clock position."
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(2,2)]
        [alias("Position")]
        [Double[]]$CurrentPosition,

        [Switch]$PassThru
    )

    Write-Verbose "Starting $($MyInvocation.MyCommand)"
    Write-Verbose "Running under PowerShell $($PSVersionTable.PSVersion)"

    if ($IsLinux -OR $isMacOS) {
        Write-Warning "This command requires a Windows platform"
        return
    }

    $settings = "FontSize", "FontStyle", "FontWeight", "Color", "OnTop", "DateFormat", "FontFamily","CurrentPosition"
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

    Write-Verbose "Ending $($MyInvocation.MyCommand)"
}

