---
external help file: PSClock-help.xml
Module Name: PSClock
online version:
schema: 2.0.0
---

# Get-PSClock

## SYNOPSIS

Get PSClock details

## SYNTAX

```yaml
Get-PSClock [<CommonParameters>]
```

## DESCRIPTION

This command will provide detailed information about a PSClock.

## EXAMPLES

### Example 1

```powershell
PS C:\>  Get-PSClock

Running Format FontFamily        Size Weight Color Style  OnTop RunspaceID
------- ------ ----------        ---- ------ ----- -----  ----- ----------
True      F    Bahnschrift Light   24 Normal White Normal True          10

```

Get details about the currently running clock.

### Example 2

```powershell
PS C:\> Get-PSClock | Select *

Started    : 11/6/2021 9:21:49 AM
Format     : F
Output     : Saturday, November 6, 2021 9:35:56 AM
Running    : True
FontFamily : Bahnschrift Light
Size       : 24
Weight     : Normal
Color      : White
Style      : Normal
OnTop      : True
RunspaceID : 10
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