---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://bit.ly/3o7rlS6
schema: 2.0.0
---

# Save-PSClock

## SYNOPSIS

Save current PSClock settings to a file.

## SYNTAX

```yaml
Save-PSClock [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will export the settings for a PSClock to an xml file,using Export-CliXML. The file PSClockSettings.xml will be created in $HOME. The next time you run Start-PSClock, if this file is detected, the settings will be imported and used for the clock unless you use -Force. If you no longer wish to use the saved settings, you can manually delete the file.

The clock does not have to be running in order to export the settings.

## EXAMPLES

### Example 1

```powershell
PS C:\> Save-PSClock
```

Save current settings to $HOME\PSClockSettings.xml.

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

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-PSClock](Start-PSClock.md)

[Get-PSClock](Get-PSClock.md)
