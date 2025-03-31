#Turn on additional verbose messaging when importing the module
if ($MyInvocation.line -match '-verbose') {
    $VerbosePreference = 'Continue'
    $manifest = Import-PowerShellDataFile $PSScriptRoot\PSClock.psd1
    Write-Verbose "Importing module version $($manifest.ModuleVersion)"
}

Write-Verbose 'Defining string data'
if ((Get-Culture).Name -match '\w+') {
    Import-LocalizedData -BindingVariable strings
}
else {
    #force using En-US if no culture found, which might happen on non-Windows systems.
    Import-LocalizedData -BindingVariable strings -FileName PSClock.psd1 -BaseDirectory $PSScriptRoot\en-us
}

Write-Verbose 'Sourcing functions: '
Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object {
    Write-Verbose $_.FullName
    . $_.FullName
}

#define module-scoped variables the path for Save-PSClock
$SavePath = Join-Path -Path $home -ChildPath PSClockSettings.xml
$FlagPath = Join-Path -Path $env:temp -ChildPath psclock-flag.txt

Write-Verbose "Using save path $SavePath"
Write-Verbose "Using flag file path $FlagPath"

Write-Verbose 'Registering argument completer for FontFamily'
Register-ArgumentCompleter -CommandName 'Start-PSClock', 'Set-PSClock' -ParameterName 'FontFamily' -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    [System.Drawing.Text.InstalledFontCollection]::new().Families.Name |
    Where-Object { $_ -like "$($WordToComplete)*" } |
    ForEach-Object {
        # completion text,listItem text,result type,Tooltip
        [System.Management.Automation.CompletionResult]::new("'$($_)'", $_, 'ParameterValue', $_)
    }
}

Write-Verbose 'Registering argument completer for Color'
Register-ArgumentCompleter -CommandName 'Start-PSClock', 'Set-PSClock' -ParameterName 'Color' -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    #skipping Transparent as a font color
    [System.Drawing.Brushes].GetProperties().name |
    Select-Object -Skip 1 |
    Where-Object { $_ -Like "$($WordToComplete)*" } |
    ForEach-Object {
        #show the color name using the color
        $ansi = Get-RGB $_ | Convert-RGBtoAnsi
        [String]$show = "$ansi$($_)$([char]27)[0m"
        # completion text,listItem text,result type,Tooltip
        [System.Management.Automation.CompletionResult]::new("'$($_)'", $show, 'ParameterValue', $_)
    }
}


if ($VerbosePreference -eq 'Continue') {
    $VerbosePreference = 'SilentlyContinue'
}
