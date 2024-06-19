<#
.Synopsis
   Abfrage Sicherheitsevent
.DESCRIPTION
   Mit diesem Skript wird das Eventlog Security nach bestimmten Events abgefrragt
.EXAMPLE
  GetLogonEvents.ps1 -EventId 4624

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  722303 Jun 19 13:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722300 Jun 19 13:37  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722297 Jun 19 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722292 Jun 19 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722289 Jun 19 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722285 Jun 19 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722283 Jun 19 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722281 Jun 19 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722279 Jun 19 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  722276 Jun 19 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
Hier wird das Login Event abgefragt
.EXAMPLE
GetLogonEvents.ps1 -EventId 4625 -Newest 2 -Verbose
AUSFÜHRLICH: ZusatzInfo:
AUSFÜHRLICH: EventId: 4625
AUSFÜHRLICH: Newest: 2
AUSFÜHRLICH: Computername: localhost

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  720121 Jun 19 09:46  FailureA... Microsoft-Windows...         4625 Fehler beim Anmelden eines Kontos....
  716128 Jun 18 09:43  FailureA... Microsoft-Windows...         4625 Fehler beim Anmelden eines Kontos....
.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1
#>
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$EventId,

[int]$Newest = 10,

[string]$ComputerName = "localhost"
)

Write-Verbose -Message "ZusatzInfo:"
Write-Verbose -Message "EventId: $EventId"
Write-Verbose -Message "Newest: $Newest"
Write-Verbose -Message "Computername: $ComputerName"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventID -eq $EventId | Select-Object -First $Newest
