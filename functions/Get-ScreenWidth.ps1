Function Get-PrimaryDisplaySize {
    [cmdletbinding()]
    [OutputType('PSPrimaryDisplaySize')]
        Param()

        Begin {
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
        } #begin

        Process {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Measuring primary display."
            [PSCustomObject]@{
                PSTypeName = 'PSPrimaryDisplaySize'
                Width      = [System.Windows.SystemParameters]::PrimaryScreenWidth
                Height     = [System.Windows.SystemParameters]::PrimaryScreenHeight
                WorkArea   = [System.Windows.SystemParameters]::WorkArea
            }
        } #process

        End {
            Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
        } #end

    } #close Get-ScreenWidth