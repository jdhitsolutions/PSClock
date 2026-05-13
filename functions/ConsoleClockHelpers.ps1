
$e = [char]27
$reset = "$e[0m"

function ConvertTo-AnsiColor {
    param([string]$Color)
    $colorMap = @{
        'Black'       = "$([char]27)[30m"
        'DarkBlue'    = "$([char]27)[34m"
        'DarkGreen'   = "$([char]27)[32m"
        'DarkCyan'    = "$([char]27)[36m"
        'DarkRed'     = "$([char]27)[31m"
        'DarkMagenta' = "$([char]27)[35m"
        'DarkYellow'  = "$([char]27)[33m"
        'Gray'        = "$([char]27)[37m"
        'DarkGray'    = "$([char]27)[90m"
        'Blue'        = "$([char]27)[94m"
        'Green'       = "$([char]27)[92m"
        'Cyan'        = "$([char]27)[96m"
        'Red'         = "$([char]27)[91m"
        'Magenta'     = "$([char]27)[95m"
        'Yellow'      = "$([char]27)[93m"
        'White'       = "$([char]27)[97m"
    }
    if ($colorMap.ContainsKey($color)) {
        return $colorMap[$Color]
    }
    else {
        #return the original color
        return $color
    }
}

function Format-BorderBox {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            HelpMessage = 'Enter the text to be displayed in the box.'
        )]
        #blank lines should be allowed
        [string[]]$Text,
        [Parameter(HelpMessage = 'Enter an optional title')]
        [string]$Title,
        [Parameter(HelpMessage = 'Specify an ANSI or PSStyle sequence for the border color.')]
        [ValidateNotNullOrEmpty()]
        [string]$BorderColor = "$e[92m",
        [System.Management.Automation.Host.Coordinates]$Position
    )

    begin {
        [string]$topLeft = [char]0x256d
        [string]$bottomRight = [char]0x256f
        [string]$topRight = [char]0x256e
        [string]$bottomLeft = [char]0x2570
        [string]$horizontal = [char]0x2500
        [string]$vertical = [char]0x2502
        $Reset = "$([char]27)[0m"

        $list = [System.Collections.Generic.List[string]]::new()
    } #begin
    process {
        foreach ($line in $Text) {
            $list.Add($line)
        }
    } #process
    end {
        #process the list of strings stripping off any ANSI codes
        $longestLine = ($list | ForEach-Object { $_ -replace '\x1b\[[0-9;]*m', '' } | Sort-Object -Property Length | Select-Object length -Last 1).length
        $width = $longestLine + 2
        $box = @'

{0}{1}{2}{3}{4}{5}{6}

'@ -f $borderColor, $TopLeft, ($horizontal * 5), $Title, ($horizontal * ($width - $Title.Length - 5)), $TopRight, $reset

        if ($Position) {
            $host.UI.RawUI.CursorPosition = $Position
            Write-Host $box.Trim() -NoNewline
            $position.Y++
        }
        #Add each line to the head
        foreach ($line in $list) {
            #get the length of the line without any ANSI codes
            $rawLine = $line -replace '\x1b\[[0-9;]*m', ''
            $formLine = "$borderColor{0}$reset {1} {2}$borderColor{0}$reset`n" -f $vertical, $line, (' ' * ($width - $rawLine.length - 2))
            if ($Position) {
                $host.UI.RawUI.CursorPosition = $Position
                Write-Host $formLine -NoNewline
                $Position.y++
            }
            else {
                $box += $formLine
            }
        }

        $bottom = '{0}{1}{2}{3}{4}' -f $borderColor, $bottomLeft, ($horizontal * $width), $bottomRight, $reset

        if ($Position) {
            $host.UI.RawUI.CursorPosition = $Position
            Write-Host $bottom -NoNewline
        }
        else {
            $box += $bottom
            $box
        }
    } #end
} #close Format-BorderBox