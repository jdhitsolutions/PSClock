---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://jdhitsolutions.com/yourls/8c3b22
schema: 2.0.0
---

# Stop-ConsoleClock

## SYNOPSIS

Stop a running console clock.

## SYNTAX

```yaml
Stop-ConsoleClock [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to stop a running console clock. The clock will be displayed, but not updated, until you clear the host or it rolls out of view.

## EXAMPLES

### Example 1

```powershell
PS C:\> Stop-ConsoleClock
```

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### none

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Start-ConsoleClock](Start-ConsoleClock.md)
