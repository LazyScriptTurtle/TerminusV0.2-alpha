function AddProcessors {
    $name = Read-Host "Podaj nazwe VM"
    $processor = Read-Host "Podaj nowa ilosc procesorow"
    Set-VMProcessor -VMName $name -Count $processor
}