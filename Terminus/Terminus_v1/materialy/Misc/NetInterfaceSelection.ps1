            # Pobierz liste wszystkich interfejsow sieciowych
            $networkInterfaces = Get-NetAdapter

            # Wyswietl liste dostepnych interfejsow z numeracja
            Write-Host "Dostepne interfejsy sieciowe:"
            $index = 1
            $interfaceNumbers = @()
            foreach ($interface in $networkInterfaces) {
                Write-Host "$index $($interface.Name)"
                $interfaceNumbers += $index
                $index++
            }

            # Zapytaj uzytkownika o wybor interfejsu
            $selectedInterface = Read-Host "Wybierz interfejs:"

            # Sprawdź, czy wybrany interfejs jest dostepny
            $selectedInterfaceNumbers = $selectedInterface.Split(',')
            $isValidSelection = $true
            foreach ($number in $selectedInterfaceNumbers) {
                if ($number -notin $interfaceNumbers) {
                    Write-Host "Blad: Interfejs o numerze $number nie istnieje."
                    $isValidSelection = $false
                }
            }

            if ($isValidSelection) {
                # Przypisz wybrany interfejs do zmiennej $interface
                $interface = $networkInterfaces[$selectedInterface - 1].Name
                Write-Host "Wybrany interfejs $interface"
            }
            else {
                Write-Host "Niepoprawny wybor interfejsu."
            }