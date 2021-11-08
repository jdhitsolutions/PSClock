# PSClock

![logo](images/psclock.png)

This module will create a WPF-based clock that runs on your Windows desktop. The clock runs in a background runspace. You can customize the clock's appearance including how you want to format the date and time. If you are running Windows, you can install the module from the PowerShell Gallery. It will work in both Windows PowerShell and PowerShell 7.

```powershell
Install-Module PSClock [-scope currentuser]
```

Installing the module will also install the `ThreadJob` module if it isn't already installed.

## [Start-PSClock](docs/Start-PSClock.md)

Use this command, or the `psclock` alias to launch a PSClock.

```powershell
Start-PSClock -size 24 -FontFamily 'Bahnschrift Light'
```

The font size must be at least 8. You should have tab completion for the FontFamily and other font-related parameters.

By default, the clock will be displayed on the center of your screen. You can click and drag the clock to reposition using the left mouse button. You might have to try a few times to "grab" the clock. You can close the clock with a right click or the `Stop-PSClock` command.

The command lets you specify any datetime format string. This is the same value you would use in a command like `Get-Date -format U`. Note that these strings are case-sensitive.

```powershell
Start-PSClock -size 30 -Color Yellow -format G -FontFamily Verdana
```

![format G](images/sample-2.png)

### [Save-PSClock](docs/Save-PSClock.md)

You can use `Save-PSClock` to export current clock settings to an xml file.

```powershell
Save-PSClock
```

The file, PSClockSettings.xml, will be stored in $HOME. If the file is detected when you run `Start-PSClock`, the saved settings will be imported. If the file exists and you want to specify new settings, use the `-Force` parameter with `Start-PSClock`. This will not remove the saved settings file, only ignore it.

You need to manually delete the file if you no longer wish to use it.

### Runspaces and Limitations

The clock runs in a separate runspace launched from your PowerShell session. If you close the session, the clock will also be closed.

The command is designed to only have one clock running at a time. If you try to start another clock from another PowerShell session, you will get a warning.

```dos
PS C:\> start-psclock
WARNING:
A running clock has been detected from another PowerShell session:

[11/6/2021 10:47:33 AM] PSClock started by Jeff under PowerShell process id 13752

If this is incorrect, delete `C:\Users\Jeff\AppData\Local\Temp\psclock-flag.txt` and try again.
```

If you close PowerShell without properly shutting down the clock you may be left with the flag file. Manually delete the file and try again.

## [Get-PSClock](docs/Get-PSClock.md)

Use this command to get information about the current clock.

```dos
PS C:\> Get-Clock
Running Format FontFamily Size Weight Color  Style  OnTop RunspaceID
------- ------ ---------- ---- ------ -----  -----  ----- ----------
True      G    Verdana      30 Normal Yellow Normal False         28
```

If the clock is not running, the `Running` value will be displayed in Red and there will be no `RunspaceID`. There are other properties to this object you might want to use.

```dos
PS C:\> Get-PSClock | Select *

Started         : 11/6/2021 10:47:33 AM
Format          : G
Output          : 11/6/2021 10:59:08 AM
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

## [Set-PSClock](docs/Set-PSClock.md)

Use this command to modify the settings of a running PSClock.

```powershell
Set-PS Clock -size 30 -color white -FontFamily 'Baskerville Old Face'
```

![modify the clock](images/sample-3.png)

You can also increase the size by selecting the clock and use the <kbd>+</kbd> key. Decrease using the <kbd>-</kbd> key. Each change takes a second to be applied. You might need to "grab" the clock and move it slightly to ensure you have it selected.

## [Stop-PSClock](docs/Stop-PSClock.md)

Use this command to stop a running PSClock from the PowerShell prompt.

```powershell
Stop-PSClock
```

You can also right-click the clock to dismiss it, or close and remove the runpace it is using. You can still use `Get-PSClock` which should now reflect that a clock is not running.

```dos
PS C:\> Get-PSClock

Running Format FontFamily           Size Weight Color Style  OnTop RunspaceID
------- ------ ----------           ---- ------ ----- -----  ----- ----------
False     G    Baskerville Old Face   30 Normal white Normal False
```

## Known Issues

There are no known issues at this time. Please post any bugs or feature requests in the Issues section of this repository.
