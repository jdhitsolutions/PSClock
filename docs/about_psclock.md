# PSClock

## about_psclock

# SHORT DESCRIPTION

This module will create a WPF-based clock launched from a PowerShell prompt that runs on your Windows desktop. The clock runs in a background PowerShell runspace so that it doesn't block. You can customize the clock's appearance including how you want to format the date and time. The clock background is transparent so all you see is formatted text.

# LONG DESCRIPTION

Use `Start-PSClock` or the `psclock` alias to launch a PSClock.

```powershell
PS C:\> Start-PSClock -size 24 -FontFamily 'Bahnschrift Light'
```

The font size must be at least 8. You should have tab completion for the `Color`, `FontFamily`, and other font-related parameters.

By default, the clock will be displayed on the center of your screen. You can click and drag the clock to reposition using the left mouse button. You might have to try a few times to "grab" the clock. You can close the clock with a right click or the `Stop-PSClock` command.

The command lets you specify any `DateTime` format string. This is the same value you would use in a command like `Get-Date -format U`. Note that these strings are case-sensitive. See https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings for more information.

```powershell
PS C:\> Start-PSClock -size 30 -Color Yellow -format G -FontFamily Verdana
```

## Get-PSClock

Use this command to get information about the current clock.

```dos
PS C:\> Get-PSClock

Running Format FontFamily Size Weight Color  Style  OnTop RunspaceID
------- ------ ---------- ---- ------ -----  -----  ----- ----------
True      G    Verdana      30 Normal Yellow Normal False         28
```

If the clock is not running, the `Running` value will be displayed in Red and there will be no `RunspaceID`. There are other properties to this object you might want to use.

```dos
PS C:\> Get-PSClock | Select *

Started         : 11/6/2024 10:47:33 AM
Format          : G
Output          : 11/6/2024 10:59:08 AM
Running         : True
FontFamily      : Verdana
Size            : 30
Weight          : Normal
Color           : Yellow
Style           : Normal
OnTop           : False
CurrentPosition : {1635, 1089}
RunspaceID      : 28
```

The `Output` property is a sample using the specified format string.

## Stop-PSClock

Use this command to stop a running PSClock from the PowerShell prompt.

```powershell
PS C:\> Stop-PSClock
```

You can also right-click the clock to dismiss it, or close and remove the runspace it is using. You can still use `Get-PSClock` which should now reflect that a clock is not running.

```dos
PS C:\> Get-PSClock

Running Format FontFamily           Size Weight Color Style  OnTop RunspaceID
------- ------ ----------           ---- ------ ----- -----  ----- ----------
False     G    Baskerville Old Face   30 Normal white Normal False
```

## Set-PSClock

Use this command to modify the settings of a running PSClock.

```powershell
Set-PSClock -size 30 -color white -FontFamily 'Baskerville Old Face'
```
You can also increase the size by selecting the clock and using the <kbd>+</kbd> key. Decrease using the <kbd>-</kbd> key. Each change takes a second to be applied. You might need to "grab" the clock and move it slightly to ensure you have it selected.

If you only want to change the color, you can use PSReadLine to display a formatted list of color options. After the `-Color` parameter, press <kbd>Ctrl+Space</kbd> and answer `Y`. Move the cursor to your selected choice and press <kbd>Enter</kbd>.

### Settings Preview Form

Version 1.4.0 updates the PSClock and allows you to configure the font family, style, and color via a WPF-based GUI. Select the clock and press `p` to display the form. The form elements have tooltips to help you understand what each setting does. Hover your mouse over the element to see the tooltip.

You can select a combination of font elements and view the preview. If you want to apply the new settings, click the `Apply` button. Don't forget to run `Save-PSClock` to save the settings if you want to re-use them the next time you start a clock.

You can also run `Show-PSClockSettingPreview`.

If you don't want to apply and changes, close the form.

## Save-PSClock

You can use `Save-PSClock` to export current clock settings to an XML file.

```powershell
PS C:\> Save-PSClock
```

The file, PSClockSettings.xml, will be stored in `$HOME`. If the file is detected when you run `Start-PSClock`, the saved settings will be imported. If the file exists and you want to specify new settings, use the `-Force` parameter with `Start-PSClock`. This will not remove the saved settings file, only ignore it.

You need to manually delete the file if you no longer wish to use it.

## Runspaces and Limitations

The clock runs in a separate runspace launched from your PowerShell session. If you close the session, the clock will also be closed.

The command is designed to only have one clock running at a time. If you try to start another clock from another PowerShell session, you will get a warning.

```dos
PS C:\> Start-PSClock
WARNING:
A running clock has been detected from another PowerShell session:

[11/6/2024 10:47:33 AM] PSClock started by Jeff under PowerShell process id 13752

If this is incorrect, delete `C:\Users\Jeff\AppData\Local\Temp\psclock-flag.txt` and try again.
```

If you close PowerShell without properly shutting down the clock you may be left with the flag file. Manually delete the file and try again.

# NOTE

For a WPF-based countdown timer, take a look at the `Start-PSCountdownTimer` command in the [PSTimers](https://github.com/jdhitsolutions/PSTimers) module.

# TROUBLESHOOTING NOTE

There are no known issues at this time. Please post any bugs or feature requests in the [Issues](https://github.com/jdhitsolutions/PSClock/issues) section of this repository.

# SEE ALSO

For more details about the module design and technical implementation, read the [design document](https://github.com/jdhitsolutions/PSClock/blob/main/Design.md). Or read the project's [README](https://github.com/jdhitsolutions/PSClock/blob/main/README.md) file which is similar to this document but contains screen shots and additional information.

# KEYWORDS

- psclock

- clock
