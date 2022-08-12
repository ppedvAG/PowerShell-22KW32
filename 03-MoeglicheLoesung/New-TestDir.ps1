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

for($i = 1; $i -le $FileCount; $i++)
{
    $FileNumber = "{0:D3}" -f $i
    $FileName = "File" + $FileNumber + ".txt"

    New-Item -Path $TestDir.FullName -Name $FileName -ItemType File

}

for($i = 1; $i -le $DirCount; $i++)
{
    $DirNumber = "{0:D3}" -f $i
    $DirName = "Dir" + $DirNumber

    $subdir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory

    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileNumber = "{0:D3}" -f $j
        $FileName = $DirName + "_" + "File" + $FileNumber + ".txt"        
        #$FileName = "$($DirName)_File$($FileNumber).txt"

        New-Item -Path $subdir.FullName -Name $FileName -ItemType File
    }
}