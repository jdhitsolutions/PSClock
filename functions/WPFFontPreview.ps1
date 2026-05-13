function Show-FontPreview {
    [CmdletBinding()]
    param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            HelpMessage = 'The default text to display'
        )]
        [string]$SampleText = $(Get-Date -Format F)
    )

    begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.UsingModule -f $modVersion)
        _verbose ($strings.Detected -f $Host.Name)
        _verbose $strings.LoadingFont
        $Families = [System.Drawing.text.installedFontCollection]::new().Families

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
                if ($_.Key -eq 'Right' -or $_.Key -eq 'Down') {
                    $comboFont.SelectedIndex++
                }
            })

        #add a handler to go to previous font if the < key is pressed
        $window.Add_KeyDown({
                if (($comboFont.SelectedIndex -gt 0) -and ($_.Key -eq 'Up' -or $_.Key -eq 'Left' )) {
                    $comboFont.SelectedIndex--
                }
            })

        #add a handler to close window with Ctrl+Q
        $window.Add_KeyDown({
                if ($_.Key -eq 'Q' -and $_.KeyboardDevice.Modifiers -eq 'Control') {
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
    } #begin
    process {
        _verbose ($strings.UsingText -f $SampleText)
        $defaultText = @"

    $sampleText

"@
        $txtPreview.Text = $defaultText
        [void]$Window.ShowDialog()
        _verbose $strings.Showing
    } #process

    end {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

}