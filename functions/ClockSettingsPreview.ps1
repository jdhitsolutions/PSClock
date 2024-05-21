if ($IsWindows -OR $PSEdition -eq 'desktop') {
    Try {
        Add-Type -AssemblyName PresentationFramework -ErrorAction Stop
        Add-Type -AssemblyName PresentationCore -ErrorAction Stop
        Add-Type -AssemblyName System.Drawing -ErrorAction Stop
    }
    Catch {
        #Failsafe error handling
        Throw $_
        Return
    }
}
else {
    Write-Warning 'This requires Windows PowerShell or PowerShell Core on Windows.'
    #Bail out
    Return
}

Function Show-PSClockSettingPreview {
    [CmdletBinding()]
    Param()

    <#
    define form titles and tooltips here so I can easily change
    them without digging through the code. I am using a custom
    object instead of a hashtable so I can define a script property
    to get the current font size setting.
    #>
    $formConfig = [PSCustomObject]@{
        PSTypeName    = 'formConfig'
        Title         = 'PSClock Settings Preview [Ctrl+Q to close]'
        FontFamilyTip = 'Select a PSClock font family'
        FontStyleTip  = 'Select a PSClock font style'
        FontWeightTip = 'Select a PSClock font weight'
        ColorTip      = 'Select a foreground color for the PSClock'
        ApplyTip      = 'Apply the new settings to the current clock'
        ApplyWarning  = 'Cannot apply settings to a stopped or non-existent PSClock.'
    }

    #defining a dynamic tooltip for the font size slider
    $updateSplat = @{
        TypeName    = 'formConfig'
        MemberType  = 'ScriptProperty'
        MemberName  = 'FontSizeTip'
        Value       = {"Select a PSClock font size: $($sliderSize.Value -as [int])"}
        Force       = $true
    }
    Update-TypeData @updateSplat

    Write-Verbose "Starting $($MyInvocation.MyCommand)"
    Write-Verbose "Running under PowerShell $($PSVersionTable.PSVersion)"
    Write-Verbose 'Loading font families'
    $Families = [System.Drawing.Text.InstalledFontCollection]::new().Families
    Write-Verbose 'Loading color values'
    $Colors = [System.Drawing.Brushes].GetProperties().name | Select-Object -Skip 1
    $defaultText = $(Get-Date -Format F)

    Write-Verbose "Using default text: $defaultText"
    Write-Verbose 'Defining the WPF form and controls'
    $window = [System.Windows.Window]@{
        Title                 = $formConfig.Title
        Height                = 400
        Width                 = 600
        WindowStartupLocation = 'CenterScreen'
    }

    #add a handler to resize controls if the window is resized
    $window.Add_SizeChanged({
        $txtPreview.Height = $window.Height - 275
        $txtPreview.Width = $window.Width - 50
    })

    #add a handler to go to next font if the > key is pressed
    $window.Add_KeyDown({
        if ($_.Key -eq 'Right' -OR $_.Key -eq 'Down') {
            $comboFont.SelectedIndex++
        }
    })

    #add a handler to go to previous font if the < key is pressed
    $window.Add_KeyDown({
        if (($comboFont.SelectedIndex -gt 0) -AND ($_.Key -eq 'Up' -OR $_.Key -eq 'Left' )) {
            $comboFont.SelectedIndex--
        }
    })

    #add a handler to close window with Ctrl+Q
    $window.Add_KeyDown({
        if ($_.Key -eq 'Q' -AND $_.KeyboardDevice.Modifiers -eq 'Control') {
            $window.Close()
        }
    })

    $Stack = [System.Windows.Controls.StackPanel]@{
        Orientation = 'Vertical'
        Background  = 'Ivory'
    }
    $comboStyle = [System.Windows.Controls.ComboBox]@{
        ItemsSource         = 'Normal', 'Italic', 'Oblique'
        SelectedIndex       = 0
        FontSize            = 14
        Height              = 25
        Width               = 100
        ToolTip             = $formConfig.FontStyleTip
        HorizontalAlignment = 'Left'
        Margin              = '5,5,0,0'
    }

    $comboStyle.Add_SelectionChanged({ $txtPreview.FontStyle = $comboStyle.SelectedItem })

    $Stack.AddChild($comboStyle)

    #add a combo box to select the font weight
    $comboWeight = [System.Windows.Controls.ComboBox]@{
        ItemsSource         = 'Normal', 'Bold', 'Light', 'Medium', 'SemiBold'
        SelectedIndex       = 0
        FontSize            = 14
        Height              = 25
        Width               = 100
        ToolTip             = $formConfig.FontWeightTip
        HorizontalAlignment = 'Left'
        Margin              = '5,5,0,0'
    }

    $comboWeight.Add_SelectionChanged({ $txtPreview.FontWeight = $comboWeight.SelectedItem })
    $Stack.AddChild($comboWeight)

    $comboFont = [System.Windows.Controls.ComboBox]@{
        ItemsSource         = $Families.Name
        SelectedIndex       = 0
        FontSize            = 14
        Height              = 25
        Width               = 250
        HorizontalAlignment = 'left'
        ToolTip             = $formConfig.FontFamilyTip
        Margin              = '5,5,0,0'
    }
    #change the text box to use the selected font
    $comboFont.Add_SelectionChanged({ $txtPreview.FontFamily = $comboFont.SelectedItem })

    $Stack.AddChild($comboFont)

    $comboColor = [System.Windows.Controls.ComboBox]@{
        ItemsSource         = $Colors
        SelectedIndex       = 0
        FontSize            = 14
        Height              = 25
        Width               = 250
        HorizontalAlignment = 'left'
        ToolTip             = $formConfig.ColorTip
        Margin              = '5,5,0,0'
    }
    #change the text box to use the selected color
    $comboColor.Add_SelectionChanged({$txtPreview.Foreground = $comboColor.SelectedItem})

    $Stack.AddChild($comboColor)

    #use a slider control to set the font size
    $sliderSize = [System.Windows.Controls.Slider]@{
        Minimum             = 10
        Maximum             = 100
        Value               = 18
        Width               = 200
        Height              = 25
        HorizontalAlignment = 'Left'
        Margin              = '5,10,5,5'
        ToolTip             = $formConfig.FontSizeTip
    }

    $sliderSize.Add_ValueChanged({
        #force an update of the tooltip
        $SliderSize.Tooltip = $formConfig.FontSizeTip
        $txtPreview.FontSize = $sliderSize.Value -as [int]
    })
    $Stack.AddChild($sliderSize)

    $txtPreview = [System.Windows.Controls.TextBox]@{
        TextWrapping                  = 'Wrap'
        AcceptsReturn                 = $true
        VerticalScrollBarVisibility   = 'Auto'
        HorizontalScrollBarVisibility = 'Auto'
        FontSize                      = 20
        Height                        = $Window.Height - 275
        Width                         = $window.Width - 50
        FontFamily                    = $comboFont.SelectedItem
        FontStyle                     = 'Normal'
        Foreground                    = $comboColor.SelectedItem
        Background                    = 'DarkGray'
        Text                          = $DefaultText
        TextAlignment                 = 'Center'
        VerticalAlignment             = 'Top'
        HorizontalAlignment           = 'Center'
        Margin                        = '5,10,5,5'
    }

    $Stack.AddChild($txtPreview)

    $btnApply = [System.Windows.Controls.Button]@{
        Content             = 'Apply'
        Width               = 75
        HorizontalAlignment = 'Left'
        VerticalAlignment   = 'Bottom'
        FontSize            = 14
        Margin              = '5,25,0,0'
        ToolTip             = $formConfig.ApplyTip
    }
    $btnApply.Add_Click({
        #only apply to a running clock
        if ($PSClockSettings.Running) {
            $PSClockSettings.FontFamily = $comboFont.SelectedItem
            $PSClockSettings.FontStyle = $comboStyle.SelectedItem
            $PSClockSettings.FontWeight = $comboWeight.SelectedItem
            $PSClockSettings.Color = $comboColor.SelectedItem
            $PSClockSettings.FontSize = $sliderSize.Value -As [int]
        }
        else {
            Write-Warning $formConfig.ApplyWarning
        }
    })

    $Stack.AddChild($btnApply)

    $window.Add_Loaded({
        if ($PSClockSettings) {
            $comboFont.SelectedItem = $PSClockSettings.FontFamily
            $comboWeight.SelectedItem = $PSClockSettings.FontWeight
            $comboStyle.SelectedItem = $PSClockSettings.FontStyle
            $comboColor.SelectedItem = $PSClockSettings.Color
            $sliderSize.Value = $PSClockSettings.FontSize
        }
        $SliderSize.Tooltip = $formConfig.FontSizeTip
    })

    $window.AddChild($Stack)
    Write-Verbose 'Showing the form'
    [void]$Window.ShowDialog()

    Write-Verbose "Ending $($MyInvocation.MyCommand)"
    $global:fc =$formConfig
    $global:ss = $sliderSize
}