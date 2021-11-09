---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://bit.ly/3bT9QyZ
schema: 2.0.0
---

# Get-PSClock

## SYNOPSIS

Get PSClock details.

## SYNTAX

```yaml
Get-PSClock [<CommonParameters>]
```

## DESCRIPTION

This command will provide detailed information about a PSClock.

## EXAMPLES

### Example 1

```powershell
PS C:\>  PS C:\> get-psclock

Running Format FontFamily Size Weight Color  Style  OnTop RunspaceID
------- ------ ---------- ---- ------ -----  -----  ----- ----------
True      F    Segoi UI     30 Normal yellow Normal False         62


```

Get details about the currently running clock.

### Example 2

```powershell
PS C:\> PS C:\> get-psclock | Select *

Started         : 11/7/2021 4:18:30 PM
Format          : F
Output          : Sunday, November 7, 2021 4:26:18 PM
Running         : True
FontFamily      : Segoi UI
Size            : 30
Weight          : Normal
Color           : yellow
Style           : Normal
OnTop           : False
CurrentPosition : {1635, 1089}
RunspaceID      : 62
```

Get all details about the current clock.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psclock

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-PSClock](Set-PSClock.md)

[Start-PSClock](Start-PSClock.md)

[Stop-PSClock](Stop-PSClock.md)

[Save-PSClock](Save-PSClock.md)
