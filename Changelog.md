# Changelog for PSClock

## [Unreleased]

## [1.5.0] - 2025-03-31

### Added

- Added a private, custom function for verbose messages.
- Moved verbose messages and warnings to localized string data.
- Modified commands to write additional data for debugging and troubleshooting to the Information stream.
- Added parameter `-Passthru` to `Save-PSClock`.

### Changed

- Updated `Design.md`.
- Updated auto completers for the `Color` and `FontFamily` parameters to let the user start typing a parameter value..
- Help updates.
- Updated `README`.
- Changed dependency from `ThreadJob` to the newer `Microsoft.PowerShell.ThreadJob`.

### Removed

- Removed all error handling related to non-Windows systems since this module can't be imported into non-Windows systems.

## [1.4.0] - 2024-05-21

### Added

- Added parameter `SampleText` to `Show-FontPreview`.
- Added parameter `CurrentPosition` with an alias of `Position` to `Set-PSClock`.
- Added command `Get-PrimaryDisplaySize`.
- Added verbose output to `Show-FontPreview`.
- Added an about help topic.
- Added the function `Show-PSClockSettingPreview` to configure PSClock settings with a WPF-based GUI.

### Changed

- Modified `Start-PSClock` to temporarily pause the dispatch timer if grabbing and moving the clock.
- Updated `Design.md`.
- Modified `FontWeight` default values to be a more complete set of: 'Normal', 'Bold', 'Light', 'Medium', 'SemiBold'.
- Documentation and help updates.
- Converted ChangeLog format.

## [1.3.0] - 2024-05-14

- Code cleanup.
- Added alias `gpc` for `Get-PSClock`.
  Added alias `spc` for `Set-PSClock`.
- Added command `Show-FontPreview` to display a preview of a font in a WPF form.
- Updated Verbose output in the module functions.
- Updated `Design.md`.s
- Updated `README.md`.

## [1.2.0] - 2022-08-08

- Moved the `Color` parameter in `Set-PSColor` to the first position. __This is a minor breaking change__.

## [1.1.0] - 2022-02-23

- Changed form title to "PSClock".
- Updated `Start-PSClock` to allow user to delete the flag file if detected.
- Updated module manifest.
- Updated `Color` parameter auto completer for `Set-PSClock` to display values using the named color. Use `Ctrl-Space` to display the formatted list.
- Updated `README.md`.
- Added private functions `Convert-RGBtoAnsi` and `Get-RGB`.
- Updated help documentation.

## [1.0.0] - 2021-11-09

- Fixed bad formatting in markdown help files.
- Updated `README.md`.
- Added `Design.md`.
- General code cleanup.
- Official release

## [0.9.1] - 2021-11-08

- Added online help links.
- Updated module manifest to reset Verbose preference. [Issue #1](https://github.com/jdhitsolutions/PSClock/issues/1)
- Fixed a bug in `Save-PSClock` that wasn't exporting all settings.
- Updated `README.md`.

## 0.9.0 - 2021-11-08

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

## 0.8.0 - 2021-11-06

- Modified `Start-PSClock` and `Set-PSClock` to take parameter input from the pipeline by property name.
- Added `System.Drawing` as a required assembly so that the font family autocompletion works.
- Updated help files.
- Added external help.

## 0.7.0 - 2021-11-06

- Added markdown help files.
- Changed the default clock color to `White`.
- Added `-Passthru` to `Set-PSColor`.

## 0.0.1 - 2021-11-06

- Initial module setup.

[Unreleased]: https://github.com/jdhitsolutions/PSClock/compare/v1.5.0..HEAD
[1.5.0]: https://github.com/jdhitsolutions/PSClock/compare/v1.4.0..v1.5.0
[1.4.0]: https://github.com/jdhitsolutions/PSClock/compare/v1.3.0..v1.4.0
[1.3.0]: https://github.com/jdhitsolutions/PSClock/compare/v1.2.0..v1.3.0
[1.2.0]: https://github.com/jdhitsolutions/PSClock/compare/v1.1.0..v1.2.0
[1.1.0]: https://github.com/jdhitsolutions/PSClock/compare/v1.0.0..v1.1.0
[1.0.0]: https://github.com/jdhitsolutions/PSClock/compare/v0.9.1..v1.0.0
[0.9.1]: https://github.com/jdhitsolutions/PSClock/compare/v0.9.0..v0.9.1