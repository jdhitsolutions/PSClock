#these are private functions

#define a custom Verbose function

function _verbose {
    [CmdletBinding()]
    Param([string]$Message)

    $m = "[$([char]27)[3m{0}$([char]27)[0m] {1}" -f (Get-Date).TimeOfDay, $Message
    Microsoft.PowerShell.Utility\Write-Verbose $m
}

function Get-RGB {
    [CmdletBinding()]
    [OutputType('RGB')]
    Param(
        [Parameter(Mandatory, HelpMessage = 'Enter the name of a system color like Tomato')]
        [ValidateNotNullOrEmpty()]
        [String]$Name
    )
    Try {
        $Color = [System.Drawing.Color]::FromName($Name)
        [PSCustomObject]@{
            PSTypeName = 'RGB'
            Name       = $Name
            Red        = $color.R
            Green      = $color.G
            Blue       = $color.B
        }
    }
    Catch {
        Throw $_
    }
}
function Convert-RGBtoAnsi {
    #This will write an opening ANSI escape sequence to the pipeline
    [CmdletBinding()]
    [OutputType('String')]
    Param(
        [parameter(Position = 0, ValueFromPipelineByPropertyName)]
        [Int]$Red,
        [parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [Int]$Green,
        [parameter(Position = 2, ValueFromPipelineByPropertyName)]
        [Int]$Blue
    )
    Process {
        "$([char]27)[38;2;{0};{1};{2}m" -f $red, $green, $blue
    }
}
