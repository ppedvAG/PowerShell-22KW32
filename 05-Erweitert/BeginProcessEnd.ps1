[cmdletBinding()]
param(
[Parameter(ValueFromPipeLine=$true,ValueFromPipeLineByPropertyName=$true)]
[string]$Name,

[Parameter(ValueFromPipeLineByPropertyName=$true)]
[int]$PM

)

Begin
{
    $Color = Get-Random -Minimum 0 -Maximum 15
}
Process
{
$Ausgabe = $Name + " | "  + ("{0:N2}" -f ($PM / 1MB))
Write-Host -Object $Ausgabe -ForegroundColor $color
}
End
{
Write-Host -Object "-- Ende Der Übermittlung --" -ForegroundColor $color
}