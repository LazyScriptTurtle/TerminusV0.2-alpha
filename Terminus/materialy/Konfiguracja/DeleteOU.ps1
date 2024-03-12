function DeleteOU {
    try {

        Write-Host "LISTA DOSTEPNYCH OU"
        # Pobierz wszystkie OU
        $OUs = Get-ADOrganizationalUnit -Filter * | Sort-Object -Property DistinguishedName
        # Wylistuj OU w hierarchiczny sposob
        foreach ($OU in $OUs) {
            $indent = ' ' * ($OU.DistinguishedName.Split(',').Count - 1)
            Write-Host "$indent$($OU.Name)"
        }  

        $findOU = Read-Host "Podaj nazwe OU: "
        $finder = Get-ADOrganizationalUnit -Filter "Name -like '*$findOU*'" | Select-Object -ExpandProperty DistinguishedName
        if ([string]::IsNullOrEmpty($finder)) {
            Write-Host "Podane OU $finder nie istnieje"
        }
        else {
            try {
                
                Set-ADOrganizationalUnit -Identity $finder -ProtectedFromAccidentalDeletion $false -Confirm:$false
                remove-adorganizationalunit -identity $finder -Confirm:$false
            }

            catch {
                Write-Host "Blad: $_"    
            }

        }
    }
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }
}