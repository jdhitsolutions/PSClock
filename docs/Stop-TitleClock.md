---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://jdhitsolutions.com/yourls/04efbc
schema: 2.0.0
---

# Stop-TitleClock

## SYNOPSIS

Stop a running title clock.

## SYNTAX

```yaml
Stop-TitleClock [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Stop a clock running the session title or window tab. This will restore the original title
and remove the global timeClockSettings variable.

## EXAMPLES

### Example 1

```powershell
PS C:\> Stop-TitleClock
```

This will restore the original title and remove the global $timeClockSettings variable.

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

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Start-TitleClock](Start-TitleClock.md)
