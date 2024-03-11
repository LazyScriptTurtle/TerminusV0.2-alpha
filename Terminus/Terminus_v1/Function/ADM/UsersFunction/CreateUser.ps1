

function CreateUser {
    try {
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

        # Pobieranie i wyświetlanie dostępnych OU
        $ous = Get-ADOrganizationalUnit -Filter * -Properties DistinguishedName | Sort-Object DistinguishedName
        for ($i = 0; $i -lt $ous.Count; $i++) {
            Write-Host "$i. $($ous[$i].DistinguishedName)"
        }
        
        # Wybór OU przez użytkownika
        $selectedOUIndex = Read-Host "Wybierz numer OU, w którym chcesz utworzyć użytkownika"
        $selectedOU = $ous[$selectedOUIndex].DistinguishedName

        # Sprawdzenie czy wybrany index znajduje się w zakresie dostępnych OU
        if (-not $selectedOU) {
            Write-Host "Nieprawidłowy wybór OU. Proces zostaje przerwany."
            return
        }

        New-ADUser -Name "$fullName" -GivenName "$firstName" -Surname "$lastName" -SamAccountName "$userPrincipalName" -UserPrincipalName "$login" -AccountPassword $password -PasswordNeverExpires $false -PasswordNotRequired $false -Enabled $isEnable -ChangePasswordAtLogon $change -Path $selectedOU
        $checker = Get-ADUser -Identity "$userPrincipalName"
        if($checker){
            Write-Host "Użytkownik $fullName został pomyślnie utworzony w OU: $selectedOU"
        }
        else{
            Read-Host " nie udalo sie utworzyc uzytkownika :("
        }
        
        
    }
    catch {
        Write-Host "Błąd: $_"
    }
}
