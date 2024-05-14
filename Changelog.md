# Changelog for PSClock

## v1.3.-0

- Code cleanup.
- Added alias `gpc` for `Get-PSClock`.
  Added alias `spc` for `Set-PSClock`.
- Added command `Show-FontPreview` to display a preview of a font in a WPF form.
- Updated Verbose output in the module functions.
- Updated `Design.md`.s
- Updated `README.md`.

## v1.2.0

- Moved the `Color` parameter in `Set-PSColor` to the first position. __This is a minor breaking change__.

## v1.1.0

- Changed form title to "PSClock".
- Updated `Start-PSClock` to allow user to delete the flag file if detected.
- Updated module manifest.
- Updated `Color` parameter auto completer for `Set-PSClock` to display values using the named color. Use `Ctrl-Space` to display the formatted list.
- Updated `README.md`.
- Added private functions `Convert-RGBtoAnsi` and `Get-RGB`.
- Updated help documentation.

## v1.0.0

- Fixed bad formatting in markdown help files.
- Updated `README.md`.
- Added `Design.md`.
- General code cleanup.
- Official release

## v0.9.1

- Added online help links.
- Updated module manifest to reset Verbose preference. [Issue #1](https://github.com/jdhitsolutions/PSClock/issues/1)
- Fixed a bug in `Save-PSClock` that wasn't exporting all settings.
- Updated `README.md`.

## v0.9.0

- Added a module icon.
- Modified `Start-PSClock` and `Get-PSClock` to include window position information.
- Added `Save-PSClock` to export settings to a CliXML file.
- Updated `Start-PSClock` to use saved values if found.
- Added an argument completer for the `Color` parameter of `Start-PSClock` and `Set-PSClock`.
- Updated help documentation.
- Updated `README.md`.
- Added verbose output for module import.
- Manifest updates.
- Release to PowerShell Gallery

## v0.8.0

- Modified `Start-PSClock` and `Set-PSClock` to take parameter input from the pipeline by property name.
- Added `System.Drawing` as a required assembly so that the font family autocompletion works.
- Updated help files.
- Added external help.

## v0.7.0

- Added markdown help files.
- Changed the default clock color to `White`.
- Added `-Passthru` to `Set-PSColor`.

## v0.0.1

- Initial module setup.
