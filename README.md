# PSClock

![PSGallery Version](https://img.shields.io/powershellgallery/v/PSClock.png?style=for-the-badge&logo=powershell&label=PowerShell%20Gallery)![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSClock.png?style=for-the-badge&label=Downloads)

![logo](images/psclock.png)

This module offers several commands for creating clock displays that you can launch from PowerShell.The original module was designed to create a WPF-based clock, launched from a PowerShell prompt that runs on your Windows desktop. The clock runs in a background PowerShell runspace so that it doesn't block. The module will automatically clean up the runspace when you close the clock. You can customize the clock's appearance including how you want to format the date and time. The clock's background is transparent so all you see is formatted text.

The module has since been updated to display customized clock in the [console window](#console-clock) itself, or in the [session title bar or tab](#title-clock).

## Installation

If you are running Windows, you can install the module from the PowerShell Gallery. This module will work in Windows PowerShell and PowerShell 7 on Windows.

```powershell
Install-PSResource PSClock [-scope AllUsers]
```

Installing the module will also install the `Microsoft.PowerShell.ThreadJob` module if it isn't already installed. If you attempt to install the module with `Install-Module` and you have the legacy `ThreadJob` module installed, you might get a warning message. If this happens, run `Install-Module PSClock -AllowClobber`. This error doesn't seem to happen when using `Install-PSResource`.

## Module Commands

| Name | Alias | Synopsis |
| ------ | ------- | ---------- |
| [Get-PrimaryDisplaySize](docs/Get-PrimaryDisplaySize.md) |  | Get the primary display size in pixels. |
| [Get-PSClock](docs/Get-PSClock.md) | *gpc* | Get PSClock details. |
| [Save-PSClock](docs/Save-PSClock.md) | | Save current PSClock settings to a file. |
| [Set-PSClock](docs/Set-PSClock.md) | *spc* | Modify a running PSClock. |
| [Show-FontPreview](docs/Show-FontPreview.md) | | Show a font preview in a WPF form. |
| [Show-PSClockSettingPreview](docs/Show-PSClockSettingPreview.md) | | Show a GUI preview of PSClock settings. |
| [Start-ConsoleClock](docs/Start-ConsoleClock.md) | *scc* | Start a console-based clock. |
| [Start-PSClock](docs/Start-PSClock.md) | *psclock* | Start a PSClock. |
| [Start-TitleClock](docs/Start-TitleClock.md) | *stc* | Start a clock in the session title. |
| [Stop-ConsoleClock](docs/Stop-ConsoleClock.md) | *stcc* | Stop a running console clock. |
| [Stop-PSClock](docs/Stop-PSClock.md) | | Stop a running PSClock. |
| [Stop-TitleClock](docs/Stop-TitleClock.md) | *sttc* | Stop a running title clock. |

### [Start-PSClock](docs/Start-PSClock.md)

Use `Start-PSClock` or the `psclock` alias to launch a PSClock.

```powershell
Start-PSClock -size 24 -FontFamily 'Bahnschrift Light'
```

The font size must be at least 8. You should have tab completion for the `Color`, `FontFamily`, and other font-related parameters.

By default, the clock will be displayed on the center of your screen. You can click and drag the clock to reposition using the left mouse button. You might have to try a few times to "grab" the clock. You can close the clock with a right click or the `Stop-PSClock` command.

The command lets you specify any `DateTime` format string. This is the same value you would use in a command like `Get-Date -format U`. Note that these strings are case-sensitive. See https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings for more information.

```powershell
Start-PSClock -size 30 -Color Yellow -format G -FontFamily Verdana
```

![format G](images/sample-2.png)

### [Save-PSClock](docs/Save-PSClock.md)

You can use `Save-PSClock` to export current clock settings to an XML file.

```powershell
Save-PSClock
```

The file, `PSClockSettings.xml`, will be stored in `$HOME`. If the file is detected when you run `Start-PSClock`, the saved settings will be imported. If the file exists and you want to specify new settings, use the `-Force` parameter with `Start-PSClock`. This will not remove the saved settings file, only ignore it.

You need to manually delete the file if you no longer wish to use it. If you uninstall the module you will also need to manually delete the file.

### [Get-PSClock](docs/Get-PSClock.md)

Use this command to get information about the current clock.

```powershell
PS C:\> Get-PSClock

Running Format FontFamily Size Weight Color  Style  OnTop RunspaceID
------- ------ ---------- ---- ------ -----  -----  ----- ----------
True      G    Verdana      30 Normal Yellow Normal False         24
```

If the clock is not running, the `Running` value will be displayed in Red and there will be no `RunspaceID`. There are other properties to this object you might want to use.

```powershell
PS C:\> Get-PSClock | Select *

Started         : 3/30/2025 10:57:30 AM
Format          : G
Output          : 3/30/2025 10:59:49 AM
Running         : True
FontFamily      : Verdana
Size            : 30
Weight          : Normal
Color           : Yellow
Style           : Normal
OnTop           : False
CurrentPosition : {1729, 552}
RunspaceID      : 24
```

The `Output` property is a sample using the specified format string.

### [Set-PSClock](docs/Set-PSClock.md)

Use this command to modify the settings of a running PSClock.

```powershell
Set-PSClock -size 30 -color white -FontFamily 'Baskerville Old Face' -force
```

![modify the clock](images/sample-3.png)

You can also increase the size by selecting the clock and using the <kbd>+</kbd> key. Decrease using the <kbd>-</kbd> key. Each change takes a second to be applied. You might need to "grab" the clock and move it slightly to ensure you have it selected.

If you only want to change the color, you can use PSReadLine to display a formatted list of color options. After the `-Color` parameter, press <kbd>Ctrl+Space</kbd> and answer `Y`.

![PSReadLine completion](images/set-psclock-color.png)

Move the cursor to your selected choice and press <kbd>Enter</kbd>.

### Settings Preview Form

Version 1.4.0 updates the PSClock and allows you to configure the font family, style, and color via a WPF-based GUI. Select the clock and press `p` to display the form. The form elements have tooltips that explain each setting. Hover your mouse over the element to see the tooltip.

![show settings preview](images/psclock-preview.png)

You can select a combination of font elements and view the preview. If you want to apply the new settings, click the `Apply` button. Don't forget to run `Save-PSClock` to save the settings if you want to re-use them the next time you start a clock.

You can also run `Show-PSClockSettingPreview`.

If you don't want to apply and changes, close the form.

### [Stop-PSClock](docs/Stop-PSClock.md)

Use this command to stop a running PSClock from the PowerShell prompt.

```powershell
Stop-PSClock
```

You can also right-click the clock to dismiss it, or close and remove the runspace it is using. You can still use `Get-PSClock` which should now reflect that a clock is not running.

```powershell
PS C:\> Get-PSClock

Running Format FontFamily           Size Weight Color Style  OnTop RunspaceID
------- ------ ----------           ---- ------ ----- -----  ----- ----------
False     G    Baskerville Old Face   30 Normal white Normal False
```

## Profile Integration

Ideally, you will start and stop the PSClock from the PowerShell prompt. This ensures that the flag file is removed. When you terminate a PowerShell session with a running clock, the flag file will not be removed. One way to ensure that the clock is stopped is to add the following code to your PowerShell profile. This will remove the flag file when you end the PowerShell session.

```powershell
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action {
    If ($PSClockSettings.Running) {
        $flag = "$ENV:temp\psclock-flag.txt"
        If (Test-Path $flag) {
            Remove-Item $flag -Force
        }
        Stop-PSClock
    }
} | Out-Null
```

However, this will only run if you type `exit` to terminate the session. If you simply close the window, the `PowerShell.Exiting` event will not be triggered. You can also add the code to your profile to automatically start the clock when you open a new PowerShell session. In Windows Terminal, you still might need to manually close the profile tab once you see that the clock has ended.

## Runspaces and Limitations

The WPF-based clock runs in a separate runspace launched from your PowerShell session. If you close the session, the clock will also be closed.

The command is designed to only have one clock running at a time. If you try to start another clock from another PowerShell session, you will get a warning.

```powershell
PS C:\> Start-PSClock
WARNING:
A running clock has been detected from another PowerShell session:

[3/30/2025 11:00:36 AM] PSClock started by Jeff under PowerShell process id 46900

If this is incorrect, delete C:\Users\Jeff\AppData\Local\Temp\psclock-flag.txt and try again.

Do you want to remove the flag file? Y/N:
```

If you close PowerShell without properly shutting down the clock you may be left with the flag file. Delete the file and try again.

## Font Preview

This module includes a font preview utility. Run `Show-FontPreview` to display a WPF form that will let you preview different fonts.

![font preview](images/show-fontpreview.png)

You can use the arrow keys or buttons to navigate through the fonts. Press <kbd>Ctrl+Q</kbd> to quit or manually close the form.

## Console Clock

Version 1.6.0 added a console clock feature. You can display a clock in the upper-right corner of your PowerShell console or terminal window. The clock uses an event subscription that updates the clock when PowerShell is idle.

The default format is a long date time format like `Thursday, May 7, 2026 3:58:35 PM` displayed in yellow. However, you can format the display using console colors or ANSI escape sequences, including $PSStyle. Optionally, you can add a border which you can also style with color.

```powershell
PS C:\> Start-ConsoleClock -border -DisplayColor "`e[93;3m"
```

![console clock](images/console-clock.png)

While running, there is hashtable of settings stored as a global variable `$consoleClockSettings`.

```powershell
PS C:\> $consoleClockSettings

Name                           Value
----                           -----
Format                         F
DisplayColor
Border                         True
BorderColor
Note                           This is used by the PSClock module. Do not manually remove.
```

You won't see values for ANSI sequences because they are escape sequences. But you can change any value.

```powershell
PS C:\> $consoleClockSettings.DisplayColor = "`e[91m"
PS C:\> $consoleClockSettings.Border = $False
```

> *You can also use `$PSStyle.Foreground` settings.*

If you manually remove this variable, the console clock will automatically be stopped and removed. Although the last display will remain until you clear the screen or it scrolls out of view.

You can only have one clock at a time. Use `Stop-ConsoleClock` to stop updating the clock. The display will remain until you clear the host or it scrolls out of view.

## Title Clock

Another location for a clock is in the title bar of your PowerShell session, or the tab if using Windows Terminal. Run [Start-TitleClock](docs/Start-TitleClock.md) The default behavior is to display a clock using the `T` format datetime format string. You can also choose to display additional information.

- The PowerShell version number from `$PSVersionTable.PSVersion`
- Your current location
- A static piece of text like 'Admin'
- The value of a global variable

Values will be displayed separated by the vertical pipe character by default. You can select an alternative separator.

```text
5/11/2026 8:50:17 AM | 7.6.1 | Admin
```

If you are using Windows Terminal, you may need to configure the tab to use the title length. Set the `Tab width mode` under `Settings - Appearance.` The change won't take effect until you restart Windows terminal.

While running, you can adjust settings using the global `timeClockSettings` variable, which is a hashtable.

```powershell
PS C:\> $titleClockSettings

Name                           Value
----                           -----
Format                         G
PSVersion                      True
Text                           Admin
Variable
Location                       False
Separator                      |
Note                           This is used by the PSClock module. Do not manually remove.

PS C:\> $titleClockSettings.Text = $Null
PS C:\> $titleClockSettings.Variable = 'shellID'
PS C:\> $titleClockSettings.location = $True
```

The change is immediate.

Run `Stop-TitleClock` to restore the original title and remove the `$timeClockSettings` variable.
This will restore the original title and remove the global timeClockSettings variable.

## WPF Clock Design

For more details about the module design and technical implementation, read the [design document](Design.md).

## Related Modules

For a WPF-based countdown timer, take a look at the [Start-PSCountdownTimer](https://jdhitsolutions.com/yourls/9f666f) command in the [PSTimers](https://github.com/jdhitsolutions/PSTimers) module.

## Known Issues

There are no known issues at this time. Please post any bugs or feature requests in the [Issues](https://github.com/jdhitsolutions/PSClock/issues) section of this repository.

## Future Plans

These are some ideas I'm considering for future releases.

- Add border styles for the console clock
- Support a border title for the console clock
- Add an optional border for the WPF-based clock
