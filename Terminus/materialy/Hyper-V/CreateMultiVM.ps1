function CreateMultiVM {

    try {
            
        #pobieranie siezki od uzytkownika
        $csvPAth = Read-host "Podaj sciezke do pliku csv: "
        # impoirtowanie csv
        $excelData = Import-Csv -Path $csvPAth
        #pobieranie zmiennych z csv 
        foreach ($row in $excelData) {
            $name = $row.Name
            $memory = $row.MemoryStartupBytes
            $processor = $row.ProcessorCount
            $vhdBytes = $row.VHDSizeBytes
            $os = $row.OperatingSystem
            $path = $row.Path
            $switch = $row.SwitchName
            $iso = $row.PathToISO
            $newVHD = $row.NewVHDPath
    
            #zmiana z bajtow na GB
            $finalMemory = [System.Int64]$memory * 1024 * 1024 * 1024
            $finalVHD = [System.Int64]$vhdBytes * 1024 * 1024 * 1024
    
            #tworzenie nowej VM 
            New-vm -Name $name -MemoryStartupBytes "$finalMemory" -NewVHDSizeBytes "$finalVHD" -Path $path -SwitchName $switch -NewVHDPath $newVHD
            #przypisywanie VM procesorow
            Set-VMProcessor -VMName $name -Count $processor
            #przypisywanie VM RAM 
            Set-VMDvdDrive -VMName $name -Path $iso
        }

    }
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }

}