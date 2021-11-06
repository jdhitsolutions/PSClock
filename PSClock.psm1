
Get-ChildItem -path $PSScriptroot\functions\*.ps1 |
ForEach-Object { . $_.Fullname}

if ($IsWindows -OR ($PSEdition -eq 'desktop')) {

    Register-ArgumentCompleter -CommandName Show-PSClock, Set-PSClock -ParameterName FontFamily -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        #PowerShell code to populate $wordtoComplete
        [System.Drawing.Text.InstalledFontCollection]::new().Families.Name |
        Where-Object { $_ -match "^$($WordToComplete)" } |
        ForEach-Object {
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new("'$($_)'", $_, 'ParameterValue', $_)
        }
    }

}



