---
external help file: PSClock-help.xml
Module Name: PSClock
online version:
schema: 2.0.0
---

# Stop-PSClock

## SYNOPSIS

Stop a running PSClock

## SYNTAX

```yaml
Stop-PSClock [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to stop a running PSClock from the PowerShell prompt. You can also right-click the clock to dismiss it, or close and remove the runspace it is using.

## EXAMPLES

### Example 1

```powershell
PS C:\> Stop-PSClock
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

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-PSClock](Set-PSClock.md)

[Get-PSClock](Get-PSClock.md)

[Start-PSClock](Start-PSClock.md)
