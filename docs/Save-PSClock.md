---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://jdhitsolutions.com/yourls/9116fc
schema: 2.0.0
---

# Save-PSClock

## SYNOPSIS

Save current PSClock settings to a file.

## SYNTAX

```yaml
Save-PSClock [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
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

### Example 2

```powershell
PS C:\> Save-PSClock -passthru

        Directory: C:\Users\Jeff


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---         3/30/2025   2:26 PM           1123 󰗀  PSClockSettings.xml
```

Save current settings and display the file.

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

### -Passthru

Display the file with saved settings.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

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

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Start-PSClock](Start-PSClock.md)

[Get-PSClock](Get-PSClock.md)
