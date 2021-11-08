# Changelog for PSClock

## v0.9.1

+ Added online help links.
+ Updated module manifest to reset Verbose preference.
+ Fixed a bug in `Save-PSClock` that wasn't exporting all settings.
+ Updated `README.md`.

## v0.9.0

+ Added a module icon.
+ Modified `Start-PSClock` and `Get-PSClock` to include window position information.
+ Added `Save-PSClock` to export settings to a CliXML file.
+ Updated `Start-PSClock` to use saved values if found.
+ Added an argument completer for the `Color` parameter of `Start-PSClock` and `Set-PSClock`.
+ Updated help documentation.
+ Updated `README.md`.
+ Added verbose output for module import.
+ Manifest updates.
+ Release to PowerShell Gallery

## v0.8.0

+ Modified `Start-PSClock` and `Set-PSClock` to take parameter input from the pipeline by property name.
+ Added `System.Drawing` as a required assembly so that the font family autocompletion works.
+ Updated help files.
+ Added external help.

## v0.7.0

+ Added markdown help files.
+ Changed the default clock color to `White`.
+ Added `-Passthru` to `Set-PSColor`.

## v0.0.1

+ Initial module setup.
