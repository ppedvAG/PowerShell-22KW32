<#
.SYNOPSIS
Kurzbeschreibung
.DESCRIPTION
lange Beschreibung was das Skript so alles macht
.PARAMETER EventId
Folgende Werte sind möglich:
4624 | Anmeldung
4625 | fehlgeschlagen
4634 | Abmeldung
.EXAMPLE
Get-Events.ps1 -EventId 4624

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  136025 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  136022 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  136018 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  136016 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  136014 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
.EXAMPLE
.\Get-Events.ps1 -EventId 4624 -Verbose
AUSFÜHRLICH: Vom User wurde folgendes angegeben: 4624 5 localhost

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  136032 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  136029 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  136025 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  136022 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  136018 Aug 11 15:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
.LINK
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1
#>
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$EventId,

[ValidateRange(5,10)]
[int]$Newest = 5,

[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTCPPort WinRM -InformationLevel Quiet})]
[string]$ComputerName = "localhost"
)

#Zusätzliche Ausgabe die ausgegeben wird wenn das Skript mit -Verbose aufgerufen wird
Write-Verbose -Message "Vom User wurde folgendes angegeben: $EventID $Newest $ComputerName"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest
