

function CreateUser {

    param (
        [string]$searchBase = (Get-ADDomain).DistinguishedName
    )

    $global:ouPaths = @()
    $global:counter = 0
    $level = 0

    function Get-OuPath {
        param (
            [string]$searchBaseInner,
            [int]$levelInner
        )

        $ous = Get-ADOrganizationalUnit -Filter * -SearchBase $searchBaseInner -SearchScope OneLevel -Properties distinguishedName | Sort-Object DistinguishedName

        foreach ($ou in $ous) {
            $indent = " " * ($levelInner * 4)
            
            # Saving OU path to global list using hashmap
            $global:ouPaths += @{"Number" = $global:counter; "Path" = $ou.DistinguishedName }
            
            # Display path with number
            Write-Host "$indent$($global:counter). $($ou.DistinguishedName)"
            
            # Increment counter
            $global:counter++
    
            # Recursive call for nested OUs
            Get-OuPath -searchBaseInner $ou.DistinguishedName -levelInner ($levelInner + 1)
        }
    }

    Get-OuPath -searchBaseInner $searchBase -levelInner $level

    # Asking user to select an OU path
    $userInput = Read-Host "wybierz numer z odpowiednia sciezka: "
    $selectedNumber = [int]$userInput
    $selectedPath = $global:ouPaths | Where-Object { $_.Number -eq $selectedNumber } | ForEach-Object { $_.Path }

    if ($selectedPath) {
        Write-Host "Wybrana lokalizacja: $selectedPath"
    }
    else {
        Write-Host "Sciezki nie znaleziono: $selectedNumber"
    }
 
        $domain = Get-ADDomain | Select-Object -ExpandProperty Forest
        $firstName = (Read-Host "Podaj imie").Trim()
        $lastName = (Read-Host "Podaj nazwisko").Trim()
        $fullName = "$firstName $lastName"
        $userPrincipalName = (Read-Host "Podaj login").Trim()
        $login = "$userPrincipalName@$domain"
        $takePassword = (Read-Host "Haslo" -AsSecureString)
        $password = (ConvertTo-SecureString $takePassword -AsPlainText -Force)
        $choice = Read-Host "Czy uzytkownik ma byc wlaczony (Y) or (N)?"
        $isEnable = $false
        if ($choice -eq 'Y' -or $choice -eq 'y') {
            $isEnable = $true
        }

        $choice = (Read-Host "Czy uzytkownik musi zmienic haslo przy logowaniu (Y) or (N)?")
        $change = $false
        if ($choice -eq 'Y' -or $choice -eq 'y') {
            $change = $true
        }

        New-ADUser -Name "$fullName" -GivenName "$firstName" -Surname "$lastName" -SamAccountName "$userPrincipalName" -UserPrincipalName "$login" -AccountPassword $password -PasswordNeverExpires $false -PasswordNotRequired $false -Enabled $isEnable -ChangePasswordAtLogon $change -Path $selectedPath
        $checker = Get-ADUser -Identity "$userPrincipalName"
        if($checker){
            Read-Host "Uzytkownik $fullName został pomyslnie utworzony w OU: $selectedOU"
        }
        else{
            Read-Host " nie udalo sie utworzyc uzytkownika :("
        }
    
    }
