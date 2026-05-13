---
external help file: PSClock-help.xml
Module Name: PSClock
online version: https://jdhitsolutions.com/yourls/7c153b
schema: 2.0.0
---

# Start-ConsoleClock

## SYNOPSIS

Start a console-based clock.

## SYNTAX

```yaml
Start-ConsoleClock [[-Format] <String>] [-DisplayColor <String>] [-Border] [-BorderColor <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to start a clock in your current PowerShell console or terminal window. The clock will be displayed in the upper right corner of your console window. You can format the output and even wrap it in a border.

While running, there is hashtable of settings stored as a global variable $consoleClockSettings.

ConsoleColor values may get converted to ANSI sequences. You won't see value for ANSI sequences because they are escape sequences. But you can change any value.

PS C:\\> $consoleClockSettings.DisplayColor = "`e[91m"

PS C:\\> $consoleClockSettings.Border = $False

These values will be immediately detected.

If you manually delete the variable, the clock will automatically be removed, although the last display will remain until you clear the host or it scrolls out of view.

You may see cursor flickering, especially is using a border. This is to be expected.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-ConsoleClock
```

Start the default clock displayed in yellow. The default formatting will look like Thursday, May 7, 2026 3:34:51 PM.

### Example 2

```powershell
PS C:\> Start-ConsoleClock -Format g -Border
```

Start a clock using the default border. The date time will be formatted as 5/7/2026 3:37 PM.

### Example 3

```powershell
PS C:\> Start-ConsoleClock -border -DisplayColor $PSStyle$.Foreground.BrightYellow -BorderColor $PSStyle.Foreground.BrightGreen -Format "HH\:mm\:ss"
```

Start a console clock using $PSStyle to customize the appearance. The clock is formatted to display the time in 24-hour format.

### Example 4

```powershell
PS C:\> Start-ConsoleClock -Border -BorderColor "`e[38;5;228m" -DisplayColor "`e[38;5;219;3m"
```

Start the clock using a colored border and styled content.

## PARAMETERS

### -Format

Specify the date time formatting using a .NET format string. For a list of available .NET format specifiers, see https://learn.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings

This format value is case-sensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: F
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayColor

Specify an ANSI style or console color for the clock display.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Yellow
Accept pipeline input: False
Accept wildcard characters: False
```

### -Border

Add a line border with rounded corners to the display. You can customize the border color using the -BorderColor parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderColor

Specify an ANSI or console color for the border. This will only be used with -Border.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Green
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

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Stop-ConsoleClock](Stop-ConsoleClock.md)

[Start-TitleClock](Start-TitleClock.md)

[Get-Date]()
