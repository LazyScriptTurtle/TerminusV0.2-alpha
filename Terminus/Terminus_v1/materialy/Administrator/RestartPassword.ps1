function RestartPassword {
    try {
            

        $name = Read-Host "Podaj nazwe uzytkownika"
        if (Get-ADUser -identity $name) {
            $newPassword = Read-Host "Podaj nowe haslo"
            Set-ADAccountPassword -Identity $name -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)
            Write-Host "Haslo zmienione z powodzeniem"

        }
        else {
            write-host "Uzytkownik nie istnieje"
        }
    }
    catch { Write-Host "Blad skontaktuj sie z administratorem: $_ "}
    }
