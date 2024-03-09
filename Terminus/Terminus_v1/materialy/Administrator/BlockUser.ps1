function BlockUser {

    try {
            

        $name = Read-Host "Nazwa SAM uzytkownika"
        Disable-ADAccount -Identity $name
        Write-Host "Uzytkownik $name"
        Get-ADUser -identity $name  | Select-Object Name, Enabled, SamAccountName, SID
    }
    
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }
}