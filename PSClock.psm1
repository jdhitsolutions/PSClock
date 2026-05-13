if ((Get-Culture).Name -match '\w+') {
    Import-LocalizedData -BindingVariable strings
}
else {
    #force using En-US if no culture found, which might happen on non-Windows systems.
    Import-LocalizedData -BindingVariable strings -FileName PSClock.psd1 -BaseDirectory $PSScriptRoot\en-us
}

#Turn on additional verbose messaging when importing the module
if ($MyInvocation.line -match '-verbose') {
    $VerbosePreference = 'Continue'
    $manifest = Import-PowerShellDataFile $PSScriptRoot\PSClock.psd1
    Write-Verbose ($strings.Importing -f $manifest.ModuleVersion)
}

Write-Verbose $strings.DotSource
Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object {
    Write-Verbose $_.FullName
    . $_.FullName
}

#define module-scoped variables to the path for Save-PSClock
$SavePath = Join-Path -Path $home -ChildPath PSClockSettings.xml
$FlagPath = Join-Path -Path $env:temp -ChildPath psclock-flag.txt

Write-Verbose ($strings.UsingPath -f $SavePath)
Write-Verbose ($strings.UsingFlag -f $FlagPath)

Write-Verbose $strings.RegisterFontCompleter
Register-ArgumentCompleter -CommandName 'Start-PSClock', 'Set-PSClock' -ParameterName 'FontFamily' -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    [System.Drawing.Text.InstalledFontCollection]::new().Families.Name |
    Where-Object { $_ -like "$($WordToComplete)*" } |
    ForEach-Object {
        # completion text,listItem text,result type,Tooltip
        [System.Management.Automation.CompletionResult]::new("'$($_)'", $_, 'ParameterValue', $_)
    }
}

Write-Verbose $strings.RegisterColorCompleter
Register-ArgumentCompleter -CommandName 'Start-PSClock', 'Set-PSClock' -ParameterName 'Color' -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    #skipping Transparent as a font color
    [System.Drawing.Brushes].GetProperties().name |
    Select-Object -Skip 1 |
    Where-Object { $_ -like "$($WordToComplete)*" } |
    ForEach-Object {
        #show the color name using the color
        $ansi = Get-RGB $_ | Convert-RGBtoAnsi
        [String]$show = "$ansi$($_)$([char]27)[0m"
        # completion text,listItem text,result type,Tooltip
        [System.Management.Automation.CompletionResult]::new("'$($_)'", $show, 'ParameterValue', $_)
    }
}

#register on module exit event to clean up
#this will only be run when using Remove-Module
$OnRemoveScript = {
    #stop clocks if they are running
    if ($global:consoleClockSettings) {
        Stop-ConsoleClock
    }
    If ($global:titleClockSettings) {
        Stop-TitleClock
    }
    If ($global:psClockSettings.Running) {
        Stop-PSClock
    }
    #the following code is "just-in-case"
    try {
        Unregister-Event -SubscriptionId $script:titleClockEvent.SubscriptionId -Force -ErrorAction Stop
    }
    catch {
        #ignore any errors
    }
    try {
        Unregister-Event -SubscriptionId $script:clockEvent.SubscriptionId -Force -ErrorAction Stop
    }
    catch {
        #ignore any errors
    }
    Remove-Variable -Name clockEvent -Scope Script -ErrorAction Ignore
    Remove-Variable -Name titleClockEvent -Scope Script -ErrorAction Ignore
    Remove-Variable -Name consoleClockSettings -Scope Global -ErrorAction Ignore
    Remove-Variable -Name titleClockSettings -Scope Global -ErrorAction Ignore
    Remove-Variable -Name PSClockSettings -Scope Global -ErrorAction Ignore
}
$ExecutionContext.SessionState.Module.OnRemove += $OnRemoveScript

#get module version for verbose messaging
$modVersion = (Test-ModuleManifest -Path $PSScriptRoot\PSClock.psd1).Version

#reset verbose preference
if ($VerbosePreference -eq 'Continue') {
    $VerbosePreference = 'SilentlyContinue'
}