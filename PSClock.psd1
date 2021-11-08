#
# Module manifest for module 'PSClock'
#
# Generated by: Jeff Hicks
#


@{

    RootModule           = 'PSClock.psm1'
    ModuleVersion        = '0.9.1'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID                 = '668afa48-5176-4fd0-bd0f-e414155c6da3'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2021 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands for creating and managing a WPF-based clock that runs on your Windows desktop.'
    PowerShellVersion    = '5.1'
    RequiredModules      = @('ThreadJob')
    RequiredAssemblies   = @('PresentationFramework', 'PresentationCore', 'WindowsBase','System.Drawing')
    FormatsToProcess     = @('formats\psclock.format.ps1xml')
    FunctionsToExport    = 'Start-PSClock', 'Set-PSClock', 'Get-PSClock', 'Stop-PSClock','Save-PSClock'
    VariablesToExport    = 'PSClockSettings'
    AliasesToExport      = 'psclock'
    # TypesToProcess = @()
    PrivateData          = @{

        PSData = @{
            Tags = @("clock", "wpf","windows")
            LicenseUri = 'https://github.com/jdhitsolutions/PSClock/blob/main/LICENSE.txt'
            ProjectUri = 'https://github.com/jdhitsolutions/PSClock'
            IconUri = 'https://raw.githubusercontent.com/jdhitsolutions/PSClock/master/images/psclock.png'
            RequireLicenseAcceptance = $false

            # External dependent modules of this module
            # ExternalModuleDependencies = @()

        } # End of PSData hashtable

    } # End of PrivateData hashtable

}

