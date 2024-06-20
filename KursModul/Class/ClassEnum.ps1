class Vehicle
{
    [string]$Farbe
    [string]$Hersteller
    [int]$Sitzplätze
    [int]$MaxSpeed
}

class Car : Vehicle
{
    [int]$Tires
    [string]$Model
    [int]$PS
    [Antriebstechnologie]$Motor

    #Konstruktor, wird ausgeführt beim erstellen einer neuen Instanz der Klasse
    Car()
    {
        #Default Konstruktor
    }
    Car([string]$Hersteller)
    {
        $this.Hersteller = $Hersteller
    }

    #eigene Methoden
    [void]Drive([int]$Distance)
    {
        [int]$Speed = 0
        [string]$Fahrbahn = "🚗"
        for($i = 1; $i -le $Distance;$i++)
        {
            $Fahrbahn = "_" + $Fahrbahn
            if($Speed -le $this.MaxSpeed)
            {
                $Speed += 15
            }

            Start-Sleep -Milliseconds (300 - $Speed)
            Clear-Host
            Write-Host -Object $Fahrbahn
        }
    }


     #Überladung der Default Methode ToString
    [string]ToString()
    {
        [string]$Ausgabe = "[ " + $this.Hersteller + " | " + $this.Model + " ]"
        return $Ausgabe
    }
    [string]ToString([string]$Informationlevel)
    {
        [string]$Ausgabe = ""
        switch($Informationlevel)
        {
            Detailed {$Ausgabe = "[ " + $this.Hersteller + " | " + $this.Model + " | Leistung: " + $this.PS + " ]"}
            Default {$Ausgabe = $this.ToString()}
        }

        return $Ausgabe
    }
}

enum Antriebstechnologie
{
    Sonstiges
    Benzin
    Diesel
    Elektrisch
    Hybrid
    Wasserstoff
}

#$MyCar = [Car]::new()
#$MyCar.Hersteller = "BMW"
$MyCar = [Car]::new("BMW")
$MyCar.Farbe = "Grau Metallic"
$MyCar.Model = "F31"
$MyCar.PS = 252
$MyCar.MaxSpeed = 260
$MyCar.Sitzplätze = 5
$MyCar.Tires = 4

$MyCar.Drive(100)