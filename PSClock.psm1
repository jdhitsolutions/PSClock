
#Turn on additional verbose messaging when importing the module
if ($MyInvocation.line -match "-verbose") {
    $VerbosePreference = "Continue"
    $manifest = Import-PowerShellDataFile $PSScriptroot\PSClock.psd1
    Write-Verbose "Importing module version $($manifest.moduleversion)"
}

Write-Verbose "Sourcing functions: "
Get-ChildItem -Path $PSScriptroot\functions\*.ps1 |
ForEach-Object {
    Write-Verbose $_.Fullname
    . $_.Fullname
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
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new("'$($_)'", $_, 'ParameterValue', $_)
        }
    }

    Write-Verbose "Registering argument completer for Color"
    Register-ArgumentCompleter -CommandName 'Start-PSClock', 'Set-PSClock' -ParameterName 'Color' -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        [System.Drawing.Brushes].GetProperties().name | Select-Object -Skip 1 |
        Where-Object { $_ -match "^$($WordToComplete)" } |
        ForEach-Object {
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new("'$($_)'", $_, 'ParameterValue', $_)
        }
    }
}

