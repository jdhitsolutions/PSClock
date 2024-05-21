---
external help file: PSClock-help.xml
Module Name: PSClock
online version:
schema: 2.0.0
---

# Get-PrimaryDisplaySize

## SYNOPSIS

Get the primary display size in pixels.

## SYNTAX

```yaml
Get-PrimaryDisplaySize [<CommonParameters>]
```

## DESCRIPTION

When positioning the PSClock, or any WPF form, you might need to know the dimension of your display.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PrimaryDisplaySize

  Width Height WorkArea
  ----- ------ --------
1536.00 864.00 0,0,1536,816
```

These values are different than $host.UI.RawUI.WindowSize.Width and $host.UI.RawUI.WindowSize.Height. The $host values are dimensions of the console window, not the display screen.

### Example 2

```powershell
PS C:\> Get-PrimaryDisplaySize | Select-Object -ExpandProperty WorkArea

IsEmpty     : False
Location    : 0,0
Size        : 1536,816
X           : 0
Y           : 0
Width       : 1536
Height      : 816
Left        : 0
Top         : 0
Right       : 1536
Bottom      : 816
TopLeft     : 0,0
TopRight    : 1536,0
BottomLeft  : 0,816
BottomRight : 1536,816
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSPrimaryDisplaySize

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
