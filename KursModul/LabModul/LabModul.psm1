function Get-Sum
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[int]$Summand1,

[Parameter(Mandatory=$true)]
[int]$summand2
)

Write-Debug -Message "VorSummierung"
$Summand1 + $summand2 


}