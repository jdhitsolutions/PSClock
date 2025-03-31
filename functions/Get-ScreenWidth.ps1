Function Get-PrimaryDisplaySize {
    [cmdletbinding()]
    [OutputType('PSPrimaryDisplaySize')]
    Param()

    Begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $Host.Name)
    } #begin

    Process {
        _verbose $strings.Measuring
        [PSCustomObject]@{
            PSTypeName = 'PSPrimaryDisplaySize'
            Width      = [System.Windows.SystemParameters]::PrimaryScreenWidth
            Height     = [System.Windows.SystemParameters]::PrimaryScreenHeight
            WorkArea   = [System.Windows.SystemParameters]::WorkArea
        }
        Write-Information -MessageData [System.Windows.SystemParameters] -Tags raw
    } #process

    End {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

} #close Get-ScreenWidth