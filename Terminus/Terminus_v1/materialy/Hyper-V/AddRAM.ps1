function AddRAM {
    $vmName = Read-Host "Podaj nazwe VM"
    $minimumBytes = Read-Host "Podaj minimalna dopuszczalna ilosc RAM"
    $maximumBytes = Read-Host "Maksymalna dopuszczalna ilosc VM"
    Set-VMMemory -VMName -MinimumBytes -MaximumBytes
}