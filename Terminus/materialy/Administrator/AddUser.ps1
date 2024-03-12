function AddUser {

    try {

        $defaultDomain = Get-ADDomain | Select-Object -ExpandProperty DistinguishedName
        $default = $null
        $domainInfo = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty Domain
        $SamAccountName = Read-Host "Podaj logon (obowiazkowe)"
        $UserPrincipalName = "$SamAccountName@$domainInfo"
        $FirstName = Read-Host "Podaj imie (obowiazkowe)"
        $LastName = Read-Host "Podaj nazwisko (opcjonalne)"
        $Description = Read-Host "Opis (opcjonalne)"
        $Password = Read-Host "Haslo"
    }
    
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }
}