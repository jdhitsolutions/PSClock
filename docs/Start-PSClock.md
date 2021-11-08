---
external help file: PSClock-help.xml
Module Name: PSClock
online version:
schema: 2.0.0
---

# Start-PSClock

## SYNOPSIS

Start a PSClock.

## SYNTAX

```yaml
Start-PSClock [[-DateFormat] <String>] [-FontSize <Int32>] [-FontStyle <String>] [-FontWeight <String>] [-Color <String>] [-FontFamily <String>] [-OnTop] [-Position <Int32[]>] [-Force] [-Passthru]  [<CommonParameters>]
```

## DESCRIPTION

Start a WPF-based PSClock that will run in a background runspace. The clock will be displayed in the center of the screen. You can click and drag the clock to reposition using the left mouse button. You might have to try a few times to "grab" the clock. You can close the clock with a right-click or the Stop-PSClock command.

The command lets you specify any datetime format string. This is the same value you would use in a command like Get-Date -format U. Note that these strings are case-sensitive.

The clock runs in a separate runspace launched from your PowerShell session. If you close the session, the clock will also be closed.

The command is designed to only have one clock running at a time. If you try to start another clock from another PowerShell session, you will get a warning.

If you have saved PSClock settings, the exported values will be used unless you use -Force. The saved settings file will not be deleted.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSClock
```

Start a new PSClock using the default parameter values. If you have saved PSClock settings, then those values will be used.

### Example 2

```powershell
PS C:\> Start-PSClock -size 24 -FontFamily 'Bahnschrift Light' -OnTop
```

Start a clock using specific font settings. The clock will be displayed center screen. It will use the default datetime format string.

## PARAMETERS

### -Color

Specify a font color like Green or an HTML code like '#FF1257EA'. You can also use any [System.Drawing.Brushes] color like Coral or SkyBlue.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: White
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DateFormat

Specify a .NET format string value like F, or G. See https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings for more information.

```yaml
Type: String
Parameter Sets: (All)
Aliases: format

Required: False
Position: 0
Default value: F
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
Default value: Segoi UI
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontSize

Specify a font size.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: size

Required: False
Position: Named
Default value: 18
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontStyle

Specify a font style.

```yaml
Type: String
Parameter Sets: (All)
Aliases: style
Accepted values: Normal, Italic, Oblique

Required: False
Position: Named
Default value: Normal
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontWeight

Specify a font weight.

```yaml
Type: String
Parameter Sets: (All)
Aliases: weight
Accepted values: Normal, Bold, Light

Required: False
Position: Named
Default value: Normal
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OnTop

Do you want the clock to always be on top?

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

### -Passthru

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

### -Force

Force a new PSClock, ignoring any previously saved settings. The saved settings file will remain.

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

### -Position

Specify the clock position as an array of left and top values.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

### PSClock

## NOTES

View the project's README file at https://bit.ly/3H01fJe.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-PSClock](Set-PSClock.md)

[Get-PSClock](Get-PSClock.md)

[Stop-PSClock](Stop-PSClock.md)

[Save-PSClock](Save-PSClock.md)
