#
# Module manifest for module 'PSClock'

@{
    RootModule           = 'PSClock.psm1'
    ModuleVersion        = '1.6.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID                 = '668afa48-5176-4fd0-bd0f-e414155c6da3'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2021-2026 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands for creating and managing a WPF-based clock that runs on your Windows desktop.'
    PowerShellVersion    = '5.1'
    RequiredModules      = @('Microsoft.PowerShell.ThreadJob')
    RequiredAssemblies   = @('PresentationFramework', 'PresentationCore', 'System.Drawing')
    FormatsToProcess     = @('formats\psclock.format.ps1xml')
    FunctionsToExport    = @(
                            'Start-PSClock',
                            'Set-PSClock',
                            'Get-PSClock',
                            'Stop-PSClock',
                            'Save-PSClock',
                            'Show-FontPreview',
                            'Show-PSClockSettingPreview',
                            'Get-PrimaryDisplaySize',
                            'Start-ConsoleClock',
                            'Stop-ConsoleClock',
                            'Start-TitleClock',
                            'Stop-TitleClock'
                            )
    VariablesToExport    = 'PSClockSettings'
    AliasesToExport      = @('psclock','gpc','spc','scc','stcc','stc','sttc')
    PrivateData          = @{
        PSData = @{
            Tags                     = @("clock", "wpf", "windows","time","terminal")
            LicenseUri               = 'https://github.com/jdhitsolutions/PSClock/blob/main/LICENSE.txt'
            ProjectUri               = 'https://github.com/jdhitsolutions/PSClock'
            IconUri                  = 'https://raw.githubusercontent.com/jdhitsolutions/PSClock/master/images/psclock.png'
            RequireLicenseAcceptance = $false
            ReleaseNotes             = @"
# PSClock v1.6.0

### Added

- Added commands `Start-ConsoleClock` and `Stop-ConsoleClock` to display a clock in the upper right corner of a PowerShell console or terminal.
- Added commands `Start-TitleClock` and `Stop-TitleClock` to display a clock and other information in the session title bar.
- Added command aliases `scc`, `stcc`, `stc`, and `sttc`.
- Added a verbose message to show the module version.

### Changed

- Added an event subscription to clean up on module exit, i.e. running `Remove-Module`.
- Updated `Show-FontPreview` to accept sample text from the pipeline.
- Updated the README file.
- Updated localized strings for verbose output on module loading.
- Updated help examples.
- Minor code reformatting.
"@
        }
    }
}

