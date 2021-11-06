
Get-ChildItem -path $PSScriptroot\functions\*.ps1 |
ForEach-Object { . $_.Fullname}

#this module should never even run on a non-Windows platform.
#This code is a failsafe.
if ($IsWindows -OR ($PSEdition -eq 'desktop')) {

    Register-ArgumentCompleter -CommandName 'Start-PSClock','Set-PSClock' -ParameterName 'FontFamily' -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        [System.Drawing.Text.InstalledFontCollection]::new().Families.Name |
        Where-Object { $_ -match "^$($WordToComplete)" } |
        ForEach-Object {
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new("'$($_)'", $_, 'ParameterValue', $_)
        }
    }

}

