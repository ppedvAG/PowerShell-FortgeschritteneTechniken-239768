param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 10,

[string]$ComputerName = "localhost"
)

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventID -eq $EventId | Select-Object -First $Newest
