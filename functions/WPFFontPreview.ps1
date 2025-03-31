Function Show-FontPreview {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, HelpMessage = "The default text to display")]
        [string]$SampleText = $(Get-Date -Format F)
    )

    _verbose ($strings.Starting -f $MyInvocation.MyCommand)
    _verbose ($strings.Running -f $PSVersionTable.PSVersion)
    _verbose ($strings.Detected -f $Host.Name)

    _verbose $strings.LoadingFont
    $Families = [System.Drawing.text.installedFontCollection]::new().Families

    $defaultText = @"

$sampleText

"@
    _verbose ($strings.UsingText -f $SampleText)
    _verbose $strings.definingWPF
    $window = [System.Windows.Window]@{
        Title                 = 'Font Family Preview [Ctrl+Q to close]'
        Height                = 325
        Width                 = 400
        WindowStartupLocation = 'CenterScreen'
        icon                  = [System.Windows.Media.ImageSource]"$PSScriptRoot\fonts.ico"
    }

    #add a handler to resize controls if the window is resized
    $window.Add_SizeChanged({ $txtPreview.Height = $window.Height - 200 })

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
        Background  = 'CornSilk'
    }
    $comboStyle = [System.Windows.Controls.ComboBox]@{
        ItemsSource         = 'Normal', 'Italic', 'Oblique'
        SelectedIndex       = 0
        FontSize            = 14
        Height              = 25
        Width               = 100
        ToolTip             = 'Select a font style'
        HorizontalAlignment = 'Left'
        Margin              = '5,5,0,0'
    }

    $comboStyle.Add_SelectionChanged({
            $txtPreview.FontStyle = $comboStyle.SelectedItem
        })

    $stack.AddChild($comboStyle)

    $comboFont = [System.Windows.Controls.ComboBox]@{
        ItemsSource         = $Families.Name
        SelectedIndex       = 0
        FontSize            = 14
        Height              = 25
        Width               = 250
        HorizontalAlignment = 'left'
        ToolTip             = 'Select a font family'
        Margin              = '5,5,0,0'
    }
    #change the text box to use the selected font
    $comboFont.Add_SelectionChanged({ $txtPreview.FontFamily = $comboFont.SelectedItem })

    $Stack.AddChild($comboFont)

    $grid = [System.Windows.Controls.Grid]@{
        Height = 25
    }

    $btnPrevious = [System.Windows.Controls.Button]@{
        Content             = '<'
        Width               = 20
        HorizontalAlignment = 'Left'
        VerticalAlignment   = 'Center'
        ToolTip             = 'Previous Font'
        Margin              = '10,5,0,0'
    }

    $btnPrevious.Add_Click({
        if ($comboFont.SelectedIndex -gt 0) {
            $comboFont.SelectedIndex--
        }
    })

    $grid.AddChild($btnPrevious)

    $btnNext = [System.Windows.Controls.Button]@{
        Content             = '>'
        Width               = 20
        HorizontalAlignment = 'Left'
        VerticalAlignment   = 'Center'
        ToolTip             = 'Next Font'
        Margin              = '40,5,0,0'
    }

    $btnNext.Add_Click({ $comboFont.SelectedIndex++ })

    $grid.AddChild($btnNext)
    $Stack.AddChild($grid)

    $txtPreview = [System.Windows.Controls.TextBox]@{
        TextWrapping                  = 'Wrap'
        AcceptsReturn                 = $true
        VerticalScrollBarVisibility   = 'Auto'
        HorizontalScrollBarVisibility = 'Auto'
        FontSize                      = 24
        Height                        = $window.Height - 200
        Width                         = $window.Width - 50
        FontFamily                    = $comboFont.SelectedItem
        FontStyle                     = 'Normal'
        Text                          = $DefaultText
        TextAlignment                 = 'Center'
        VerticalAlignment             = 'Center'
        HorizontalAlignment           = 'Center'
        Margin                        = '5,10,5,5'
    }

    $stack.AddChild($txtPreview)

    $btnReset = [System.Windows.Controls.Button]@{
        Content             = 'Reset'
        Width               = 75
        HorizontalAlignment = 'Left'
        VerticalAlignment   = 'Bottom'
        Margin              = '5,25,0,0'
        ToolTip             = 'Reset to default text and font'
    }
    $btnReset.Add_Click({
        $txtPreview.Text = $defaultText
        $comboStyle.SelectedIndex = 0
        $comboFont.SelectedIndex = 0
    })
    $stack.AddChild($btnReset)

    $window.AddChild($Stack)
    _verbose $strings.Showing
    [void]$Window.ShowDialog()

    _verbose ($strings.Ending -f $MyInvocation.MyCommand)

}