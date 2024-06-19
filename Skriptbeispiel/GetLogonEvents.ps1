param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 10,

[string]$ComputerName = "localhost"
)
Write-Verbose -Message "ZusatzInfo:"
Write-Verbose -Message "EventId: $EventId"
Write-Verbose -Message "Newest: $Newest"
Write-Verbose -Message "Computername: $ComputerName"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventID -eq $EventId | Select-Object -First $Newest
