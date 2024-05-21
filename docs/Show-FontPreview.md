---
external help file: PSClock-help.xml
Module Name: PSClock
online version:
schema: 2.0.0
---

# Show-FontPreview

## SYNOPSIS

Show a font preview in a WPF form.

## SYNTAX

```
Show-FontPreview [-SampleText <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to display a preview of a font in a WPF form. This can be useful when you need to see what a font looks like before using it in a clock. You can use the buttons or arrow keys to navigate through the fonts. Press Ctrl+Q to quit or manually close the form.

## EXAMPLES

### Example 1

```powershell
PS C:\> Show-FontPreview
```

Your prompt will be blocked until you close the form. This will display the default sample text
from Get-Date -Format F.

### Example 2

```powershell
PS C:\> Show-FontPreview -Verbose -SampleText (Get-Date -Format D)
```

Launch the preview form with the current date displayed. You can always modify the text in the text box.

## PARAMETERS

### -SampleText
The default text to display.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $(Get-Date -Format F)
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

[Set-PSClock](Set-PSClock.md)

[Show-PSClockSettingPreview](Show-PSClockSettingPreview.md)
