---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://jdhitsolutions.com/yourls/747a96
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
PS C:\> Get-PSClock

Running Format FontFamily Size Weight Color  Style  OnTop RunspaceID
------- ------ ---------- ---- ------ -----  -----  ----- ----------
True      F    Segoi UI     30 Normal yellow Normal False         62
```

Get details about the currently running clock.

### Example 2

```powershell
PS C:\> Get-PSClock | Select *

Started         : 11/7/2024 4:18:30 PM
Format          : F
Output          : Thursday, November 7, 2024 4:26:18 PM
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

### PSClock

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Set-PSClock](Set-PSClock.md)

[Start-PSClock](Start-PSClock.md)

[Stop-PSClock](Stop-PSClock.md)

[Save-PSClock](Save-PSClock.md)
