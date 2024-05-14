#Turn on additional verbose messaging when importing the module
if ($MyInvocation.line -match "-verbose") {
    $VerbosePreference = "Continue"
    $manifest = Import-PowerShellDataFile $PSScriptRoot\PSClock.psd1
    Write-Verbose "Importing module version $($manifest.ModuleVersion)"
}

Write-Verbose "Sourcing functions: "
Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object {
    Write-Verbose $_.FullName
    . $_.FullName
}

#the path for Save-PSClock
$SavePath = Join-Path -Path $home -ChildPath PSClockSettings.xml

Write-Verbose "Using save path $SavePath"

#this module should never even run on a non-Windows platform.
#This code is a failsafe.
if ($IsWindows -OR ($PSEdition -eq 'desktop')) {

    Write-Verbose "Registering argument completer for FontFamily"
    Register-ArgumentCompleter -CommandName 'Start-PSClock', 'Set-PSClock' -ParameterName 'FontFamily' -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        [System.Drawing.Text.InstalledFontCollection]::new().Families.Name |
        Where-Object { $_ -match "^$($WordToComplete)" } |
        ForEach-Object {
            # completion text,listItem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new("'$($_)'", $_, 'ParameterValue', $_)
        }
    }

    Write-Verbose "Registering argument completer for Color"
    Register-ArgumentCompleter -CommandName 'Start-PSClock', 'Set-PSClock' -ParameterName 'Color' -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        [System.Drawing.Brushes].GetProperties().name | Select-Object -Skip 1 |
        Where-Object { $_ -match "^$($WordToComplete)" } |
        ForEach-Object {
            #show the color name using the color
            $ansi = Get-RGB $_ | Convert-RGBtoAnsi
            [String]$show = "$ansi$($_)$([char]27)[0m"
            # completion text,listItem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new("'$($_)'", $show, 'ParameterValue', $_)
        }
    }
}

if ($VerbosePreference -eq 'Continue') {
    $VerbosePreference = 'SilentlyContinue'
}
