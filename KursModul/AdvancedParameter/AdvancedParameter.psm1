<#
.SYNOPSIS
 ValueFrom Pipeline example
.Parameter Name
 Dieser Parameter unterstützt Input über die Pipeline, über die Technike ByPropertyName also über den Namen
.PARAMETER text
 Dieser Parameter unterstützt Input über die Pipeline über die Technik ByValue also über den Datentyp
#>
function Out-Color
{
[cmdletBinding()]
param(
[Parameter(ValueFromPipelineByPropertyName=$true)]
[string]$Name,

[Parameter(ValueFromPipeline=$true)]
[string]$text
)
Begin
{
    Write-Host -BackgroundColor White -ForegroundColor Green -Object "Wird einmal am Start ausgeführt"
}
Process
{
    Write-Verbose -Message "Der Process Teil wird für jedes übergebene Objekt ausgeführt"
    Write-Host -Object " By PropertName: $Name" -ForegroundColor (Get-Random -Maximum 15)
    Write-Host -Object " By Value: $text" -ForegroundColor (Get-Random -Maximum 15)
}
End
{
    Write-Host -BackgroundColor White -ForegroundColor Red -Object "Wird einmal zum Ende ausgeführt"
}

}

<#
.SYNOPSIS
 PostionalBinding Example
.DESCRIPTION
 Das automatische binden Parameter an Positionen für die positionalen Parameter wird hier ausgeschaltet. Um dann dem Parameter 3 manuell eine Position zuzuweisen.
#>
function Test-PositionalBinding
{
[cmdletBinding(PositionalBinding=$false)]
param(
    $param1,

    $param2,

    [Parameter(Position=1)]
    $param3
)

Write-Host -Object "1: $param1"
Write-Host -Object "2: $param2"
Write-Host -Object "3: $param3"

}

<#
.SYNOPSIS
 Helpmessage für Mandatory Parameter
#>
function Test-MandatoryMessage
{
[cmdletBinding()]
param(
#Kommentar zu param1
[Parameter(Mandatory=$true,HelpMessage="Pflichtparameter irgendwas")]
$param1
)
}

<#
.SYNOPSIS
 Verwendung von verschiedenen ParameterSets
#>
function Test-ParameterSet
{
[cmdletBinding(DefaultParameterSetName="Zahl")]
param(
[Parameter(ParameterSetName="Wort")]
[string]$Wort1,
[Parameter(ParameterSetName="Wort")]
[string]$Wort2,

[Parameter(ParameterSetName="Zahl")]
[int]$Zahl1,
[Parameter(ParameterSetName="Zahl")]
[int]$zahl2,

[Parameter(ParameterSetName="Wort", Mandatory=$true)]
[Parameter(ParameterSetName="Zahl")]
[ValidateRange(0,15)]
[int]$color = 15
)
if($PSCmdlet.ParameterSetName -eq "Wort")
{
    $Ausgabe = $Wort1 + " " + $Wort2
}
elseif($PSCmdlet.ParameterSetName -eq "Zahl")
{
    $Ausgabe= $Zahl1 + $zahl2
}

    Write-Host -Object $Ausgabe -ForegroundColor $color
}

<#
.SYNOPSIS
 LAden von .Net Assemblies in der Powershell
#>
function Out-Voice
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true,ValueFromPipeLine=$true)]
[string]$text
)
Begin
{
    if((Get-Service -Name Audiosrv).Status -ne "Running")
    {
        Start-Service -Name Audiosrv
    }

    Add-Type -AssemblyName System.Speech
    $speaker = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
}
Process
{
    $speaker.Speak($text)
}
End
{

}
}