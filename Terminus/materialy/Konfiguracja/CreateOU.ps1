function CreateOU {
    try {
            
        $domainRoots = (Get-addomain).DistinguishedName
        $ouName = Read-Host "Podaj nazwe noego OU"

        Write-Host "LISTA DOSTEPNYCH OU"
        # Pobierz wszystkie OU
        $OUs = Get-ADOrganizationalUnit -Filter * | Sort-Object -Property DistinguishedName
        # Wylistuj OU w hierarchiczny sposob
        foreach ($OU in $OUs) {
            $indent = ' ' * ($OU.DistinguishedName.Split(',').Count - 1)
            Write-Host "$indent$($OU.Name)"
        }    
        $ouPath = Read-Host "OPCJONALNIE Podaj sciezke gdzie chcesz utworzyc OU (OU=<nazwa>) bez (DC=,DC=)"
        if ($ouPath -ne "") { 
            New-ADOrganizationalUnit -Name "OU=$ouName" -Path "OU=$ouPath,$domainRoots" 
        }
        elseif ($ouPath -eq "") {
            New-ADOrganizationalUnit -Name $ouName -Path $domainRoots
        }
        else {
            Write-Host "blad CreateOU"
        }
    }
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }
}