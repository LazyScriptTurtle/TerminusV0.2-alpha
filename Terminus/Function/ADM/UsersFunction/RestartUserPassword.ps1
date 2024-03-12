

function RestartUserPassword {

    try {
        $user = (Read-Host "Podaj nazwę użytkownika").Trim()
        $takePassword = Read-Host "Podaj nowe hasło" -AsSecureString
        $userSearch = Get-ADUser -Identity $user

        if ($null -ne $userSearch)
        {
            Set-ADAccountPassword -Identity $userSearch -Reset -NewPassword $takePassword
        }
    }
    catch {

        Write-Host "Podany użytkownik nie istnieje lub wystąpił inny błąd: $_"
    }
    
    
}