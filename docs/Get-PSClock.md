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

Running Format FontFamily Size Weight Color    Style  OnTop RunspaceID
------- ------ ---------- ---- ------ -----    -----  ----- ----------
True      F    Candara      50 Normal Honeydew Normal False          7
```

Get details about the currently running clock.

### Example 2

```powershell
PS C:\> Get-PSClock | Select *

Started         : 5/4/2026 10:44:48 PM
Format          : F
Output          : Thursday, May 7, 2026 3:27:40 PM
Running         : True
FontFamily      : Candara
Size            : 50
Weight          : Normal
Color           : Honeydew
Style           : Normal
OnTop           : False
CurrentPosition : {61, 62}
RunspaceID      : 7
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

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Set-PSClock](Set-PSClock.md)

[Start-PSClock](Start-PSClock.md)

[Stop-PSClock](Stop-PSClock.md)

[Save-PSClock](Save-PSClock.md)
