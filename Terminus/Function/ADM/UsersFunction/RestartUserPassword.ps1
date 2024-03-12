e

function RestartUserPassword {

    try {
        $user = (Read-Host "Podaj nazwe uzytkownika").Trim()
        $takePassword = Read-Host "Podaj nowe haslo" -AsSecureString
        $userSearch = Get-ADUser -Identity $user

        if ($null -ne $userSearch)
        {
            Set-ADAccountPassword -Identity $userSearch -Reset -NewPassword $takePassword
            Read-Host "Haslo zostalo zmienione"
        }
    }
    catch {

        Write-Host "Podany uzytkownik nie istnieje lub wystapil inny blad: $_"
    }
    
    
}