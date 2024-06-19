param(
$EventId,
$Newest,
$ComputerName 
)

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventID -eq $EventId | Select-Object -First $Newest
