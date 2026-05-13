---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://jdhitsolutions.com/yourls/e0e119
schema: 2.0.0
---

# Start-TitleClock

## SYNOPSIS

Start a clock in the session title.

## SYNTAX

```yaml
Start-TitleClock [[-Format] <String>] [-Text <String>] [-Variable <String>] [-PSVersion] [-Location]
 [-Separator <Char>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Start a clock in the title window or tab of your current PowerShell session. This works best in Windows Terminal. Although you may need to configure the Windows Terminal tab width to use the title size, especially if you decide to include the current location. The change won't take effect until you restart Windows Terminal.

You can also choose to display additional information such as the PowerShell version, your current location, a static bit of text, or the value of a global variable.

Once the clock is running, if you would like to change its appearance, you can modify settings in the global titleClockSettings variable.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-TitleClock
```

Start the clock in the console title or window tab. This will display the current time like 8:24:22 AM

### Example 2

```powershell
PS C:\> Start-TitleClock -Format G -PSVersion -Text Admin
```

This will display a clock with additional information that looks like 5/11/2026 8:30:11 AM | 7.6.1 | Admin

### Example 3

```powershell
PS C:\> Start-TitleClock -PSVersion -Text "NoProfile" -Separator "~"
```

Start a title clock using the tilde character as the separator with the default date time format. The clock will look like 5/11/2026 8:35:26 AM ~ 7.6.1 ~ NoProfile.

## PARAMETERS

### -Format

Specify the date time formatting using a .NET format string. For a list of available .NET format specifiers, see https://learn.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings

This format value is case-sensitive. The parameter is not technically mandatory, but it is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: T
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location

Show the current location. This might display a long path. If using Windows Terminal you will want to configure tabs to use the title length.

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

### -PSVersion

Show the PowerShell Version number.

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

### -Separator

Specify the separator character.

```yaml
Type: Char
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: |
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text

Display a static text message. This should be a short note like "Admin" or "Dev".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variable

Display a variable value.
Enter the variable name without the $ prefix.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Stop-TitleClock](Stop-TitleClock.md)

[Start-ConsoleClock](Start-ConsoleClock.md)

[Get-Date]()
