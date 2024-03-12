        $global:ouPaths = @()
        $global:counter = 0

        function Get-OuPath {
            param (
                [string]$searchBase = $defaultDomain,
                [int]$level = 0
            )

            $ous = Get-ADOrganizationalUnit -Filter * -SearchBase $searchBase -SearchScope OneLevel -Properties distinguishedName | Sort-Object DistinguishedName

            foreach ($ou in $ous) {
                $indent = " " * ($level * 4)
        
                # Zapisanie ścieżki OU do globalnej listy z użyciem haszmapy
                $global:ouPaths += @{"Number" = $global:counter; "Path" = $ou.DistinguishedName }
        
                # Wyświetlenie ścieżki z numerem
                Write-Host "$indent$($global:counter). $($ou.DistinguishedName)"
        
                # Inkrementacja licznika
                $global:counter++

                # Rekurencyjne wywołanie funkcji dla zagnieżdżonych OU
                Get-OuPath -searchBase $ou.DistinguishedName -level ($level + 1)
            }
        }

        function Select-OuPath {
            param (
                [int]$selectedNumber
            )

            $selectedPath = $global:ouPaths | Where-Object { $_["Number"] -eq $selectedNumber } | ForEach-Object { $_["Path"] }

            if ($selectedPath) {
                Write-Host "Wybrano sciezke: $selectedPath"
                return $selectedPath
            }
            else {
                Write-Host "Nie znaleziono sciezki dla numeru: $selectedNumber"
                return $null
            }
        }

        # Uruchomienie funkcji dla korzenia domeny
        Get-OuPath -searchBase $defaultDomain -level 0

        # Przykład, jak użytkownik może wybrać ścieżkę OU
        $userInput = Read-Host "Wpisz numer wiersza, aby wybrac lokalizacje"
        $userChoice = Select-OuPath -selectedNumber $userInput

        # Teraz zmienna $userChoice zawiera wybraną ścieżkę OU
        if ($userChoice) {
            $continue = Read-Host "Uzytkownik zostanie utworzony we wskazanej lokalizacji chcesz kontynuowac ? YES(Y) or NO(N)"
            if ($continue -eq "y" -or $continue -eq "Y") {
                # Jesli pole CN jest puste, użyj nazwy użytkownika ($SamAccountName) jako CN
                if ([string]::IsNullOrEmpty($FirstName)) {
                    $CN = $SamAccountName
                }
                else {
                    $CN = $FirstName
                }
                
                $lista = @($LastName, $Description)
                
                foreach ($item in $lista) {
                    if ([string]::IsNullOrEmpty($item)) {
                        $item = $default
                    }
                }            
                if ([string]::IsNullOrEmpty($userChoice)) {
                    $userChoice = $defaultDomain
                }
                
                New-ADUser -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName -Name "$CN $LastName" -GivenName $FirstName -Surname $LastName -Description $Description -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -ChangePasswordAtLogon $true -Path $userChoice
                Write-Host "Uzytkownik $FirstName zostal utworzony w $userChoice "
            }
            else {
                return
            }
        }
        else {
            Write-Host "Nie dokonano wyboru poprawnej sciezki OU."
        }