<#
.SYNOPSIS
Erstellung von TestDir
.DESCRIPTION
Dieses Skript erstellt einen TestFiles Ordner welcher mit Unterordner und Dateien gefüllt ist.
.PARAMETER DirCount
Mit diesem Parameter geben Sie die Anzahl der Unterordner an. Der gültige Wertebereich wäre: 1 - 100
.EXAMPLE
New-TestDir.ps1 -Path C:\ -Name TestFiles2
Bei dieser Verwendung erstellt das Skript unter dem Pfad C:\ einen Ordner TestFiles und darin die Standardanzahl an Ordnern und Dateien
#>
function New-TestFilesDir
{
[cmdletBinding(PositionalBinding=$false)]
param(

[Parameter(Mandatory=$true,HelpMessage="Pfad unter dem das erstellt werden soll")]
[ValidateScript({Test-Path -Path $PSItem -Type Container})]
[string]$Path,

[ValidateRange(1,100)]
[int]$DirCount = 3,

[ValidateRange(1,100)]
[int]$FileCount = 9,

[ValidateLength(3,20)]
[string]$Name = "TestFiles",

[switch]$Force

)

if($Path.EndsWith("\"))
{
    $Testdirpath = $Path + $Name
}
else
{
    $Testdirpath = $Path + "\" + $Name
}

if(Test-Path -Path $Testdirpath -PathType Container)
{
    if($Force)
    {
        Remove-Item -Path $Testdirpath -Recurse -Force
    }
    else
    {
        Write-Host -ForegroundColor Red -Object "Ordner bereits vorhanden"
        exit
    }
}

$TestDir = New-Item -Path $Path -Name $Name -ItemType Directory

#Verwendung der oben definierten Funktion
New-TestFiles -Path $TestDir.FullName -FileCount $FileCount

for($i = 1; $i -le $DirCount; $i++)
{
    $DirNumber = "{0:D3}" -f $i
    $DirName = "Dir" + $DirNumber

    $subdir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory

    #Verwendung der oben definierten Funktion
    New-TestFiles -Path $subdir.FullName -FileCount $FileCount -BaseName ($DirName + "File")
}
}

function New-TestFiles
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true,HelpMessage="Pfad unter dem das erstellt werden soll")]
[ValidateScript({Test-Path -Path $PSItem -Type Container})]
[string]$Path,

[ValidateLength(3,20)]
[string]$BaseName = "File",

[ValidateRange(1,100)]
[int]$FileCount = 9
)
Write-Debug -Message "Vor Schleife"
for($i = 1; $i -le $FileCount; $i++)
{
    $FileNumber = "{0:D3}" -f $i
    $FileName = $BaseName + $FileNumber + ".txt"
    try
    {
        New-Item -Path $Path -Name $FileName -ItemType File -ErrorAction Stop
    }
    catch
    {
        throw "Die Datei ist bereits vorhanden. Löschen Sie die bereits bestehenden Dateien"
    }
}
}