---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://jdhitsolutions.com/yourls/98a370
schema: 2.0.0
---

# Set-PSClock

## SYNOPSIS

Modify a running PSClock.

## SYNTAX

```yaml
Set-PSClock [[-Color] <String>] [[-DateFormat] <String>] [-FontSize <Int32>] [-FontStyle <String>]
 [-FontWeight <String>] [-FontFamily <String>] [-OnTop] [-CurrentPosition <Double[]>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to modify the settings of a running PSClock. You can also increase the size by selecting the clock and use the + key. Decrease using the - key. Each change takes a second to be applied. You might need to "grab" the clock and move it slightly to ensure you have it selected.

If you want to change the position, left-click and drag to re-position.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-PSClock -size 28 -FontStyle Oblique -FontFamily 'Tahoma'
```

### Example

```powershell
PS C:\> Set-PSClock -size 35 -Position 500,100
```

Adjust the font size and clock position. This example is using the Position parameter alias.

## PARAMETERS

### -Color

Specify a font color like Green or an HTML code like '#FF1257EA'. You can also use any [System.Drawing.Brushes] color like Coral or SkyBlue. If you press Ctrl+Space after the parameter, you can use PSReadLine to display options formatted in the corresponding color.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### -DateFormat

Specify a .NET format string value like F, or G.

```yaml
Type: String
Parameter Sets: (All)
Aliases: format

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontFamily

Specify a font family.

```yaml
Type: String
Parameter Sets: (All)
Aliases: family

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontSize

How large do you want the font size?

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: size

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontStyle

Specify a font style. Accepted values: Normal, Italic, Oblique

```yaml
Type: String
Parameter Sets: (All)
Aliases: style
Accepted values: Normal, Italic, Oblique

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontWeight

Specify a font weight. Accepted values: 'Normal', 'Bold', 'Light', 'Medium', 'SemiBold'

```yaml
Type: String
Parameter Sets: (All)
Aliases: weight
Accepted values: 'Normal', 'Bold', 'Light', 'Medium', 'SemiBold'

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OnTop

Should the clock be on top of other applications?

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### -CurrentPosition

Specify an array of (X,Y) coordinates for the clock position. Use Get-PrimaryDisplaySize to determine the values.

```yaml
Type: Double[]
Parameter Sets: (All)
Aliases: Position

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

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

[Show-PSClockSettingPreview](Show-PSClockSettingPreview.md)

[Start-PSClock](Start-PSClock.md)

[Get-PSClock](Get-PSClock.md)

[Stop-PSClock](Stop-PSClock.md)

[Save-PSClock](Save-PSClock.md)
