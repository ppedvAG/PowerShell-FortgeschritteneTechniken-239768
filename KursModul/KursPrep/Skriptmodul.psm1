<#
.Synopsis
 Erzeugung eines TestDir Verzeichnisses
.DESCRIPTION
 Anlegen eines TestDir Verzeichnisses mit einer definierbaren Anzahl von Dateinen und Ordnern in diesem . 
.PARAMETER Path
 Dieser Parameter definiert unter welchem Pfad das TestFilesDir angelegt wird.
.EXAMPLE
 New-TestfilesDir.ps1 -Path C:\ 

 Erzeugung des Ordners unter C:\
#>
function New-TestFilesDir
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateScript({Test-Path -Path $PSItem -PathType Container})]
[string]$Path,

[ValidateRange(0,99)]
[int]$DirCount = 2,

[Validatelength(1,20)]
[string]$DirName = "TestFiles2",

[ValidateRange(0,99)]
[int]$FileCount = 9,

[switch]$Force

)
$TestFilesDirPath = Join-Path -Path $Path -ChildPath $DirName
if(Test-Path -Path $TestFilesDirPath -PathType Container)
{
    if($Force)
    {
        Write-Verbose -Message "Das Verzeichnis ist bereits vorhanden wird aber gelöscht weil der Parameter Force verwendet wurde: $TestFilesDirPath"
        Remove-Item -Path $TestFilesDirPath -Recurse -Force 
    }
    else
    {
        Write-Host -Object "Ordner bereits vorhanden" -ForegroundColor Red
        exit
    }
}
#Anlegen von TestfilesDir
$TestDir = New-Item -Path $Path -Name $DirName -ItemType Directory 

#Anlegen Dateien in TestFilesDir
New-TestFiles -Path $TestDir.FullName -FileCount $FileCount
<# Ersetzt durch Funktion
for($i = 1; $i -le $FileCount; $i++)
{
    $FileNr = "{0:D2}" -f $i
    $FileName = "File" + $FileNr + ".txt"
    New-Item -Path $TestDir.FullName -Name $FileName -ItemType File
} #>

#anlegen von UnterOrdnern
for($i = 1; $i -le $DirCount; $i++)
{
    $DirNr = "{0:D2}" -f $i
    $DirName = "Dir" + $DirNr
    $subdir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory

    ## anlage der Dateinen in den Unterordnern
    New-TestFiles -Path $subdir.FullName -FileCount $FileCount -BaseName ($DirName + "File")
    <#
    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileNr = "{0:D2}" -f $j
        $FileName = "File" + $FileNr + ".txt"
        New-Item -Path $subdir.FullName -Name $FileName -ItemType File
    }#>
}


}

<#
.SYNOPSIS
 Anlage von TestFiles
.DESCRIPTION
 Anlage von TestFiles in einem Verzeichnis
#>
function New-TestFiles
{
    [cmdletBinding()]
    param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem -PathType Container})]
    [string]$Path,

    [ValidateRange(0,99)]
    [int]$FileCount = 9,

    [Validatelength(1,20)]
    [string]$BaseName = "File"
    )


    for($i = 1; $i -le $FileCount; $i++)
    {
        $FileNr = "{0:D2}" -f $i
        $FileName = "$BaseName" + $FileNr + ".txt"
        New-Item -Path $Path -Name $FileName -ItemType File
    }
}