
Function Get-PSClock {
[cmdletbinding()]
Param(

)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
} #begin

Process {
    Write-Verbose "[PROCESS] "

} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Get-PSClock


