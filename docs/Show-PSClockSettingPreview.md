---
external help file: PSClock-help.xml
Module Name: PSClock
online version:
schema: 2.0.0
---

# Show-PSClockSettingPreview

## SYNOPSIS

Show a GUI preview of PSClock settings

## SYNTAX

```yaml
Show-PSClockSettingPreview [<CommonParameters>]
```

## DESCRIPTION

Use this command to display a GUI preview of the settings that can be applied to a PSClock. The preview text will adjust to the selected font family, weight, style, color and size. Changes will be reflected in the preview box. Click the Apply button to commit the changes to the current clock. If you don't want to apply any changes, close the form. The form elements have tooltips to help you understand what each setting does. Hover your mouse over the element to see the tooltip.

You can also invoke this command by selecting the PSClock and pressing 'p'.

If you have a running clock, the form will default to the current clock settings. If you don't have a running clock, the form will use the default settings from Start-PSClock.

## EXAMPLES

### Example 1

```powershell
PS C:\> Show-PSClockSettingPreview
```

Your prompt will be blocked until you close the form.

## PARAMETERS

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
