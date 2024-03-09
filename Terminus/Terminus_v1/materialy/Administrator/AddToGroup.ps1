function AddUserToGroup {

    try {
            
        $allGroups = Get-ADGroup -Filter { GroupCategory -eq 'Security' -and GroupScope -eq 'Global' } | Sort-Object Name | Select-Object -ExpandProperty Name

        Write-Host "### Dostepne Grupy ###"
        $index = 1
        $groupList = @{}
        foreach ($group in $allGroups) {
            $groupList.Add($index, $group)
            Write-Host "$index $($group)"
            $index++
        }
        
        # Zapytaj uzytkownika o wybor grupy
        $selectGroupIndex = Read-Host "Wybierz grupe"
        
        if ([string]::IsNullOrEmpty($selectGroupIndex)) {
            Write-Host "Nie podano numeru grupy."
        }
        elseif ($groupList.ContainsKey([int]$selectGroupIndex)) {
            $selectedGroupName = $groupList[[int]$selectGroupIndex]
            Write-Host "GRUPA: $selectedGroupName"
        }
        else {
            Write-Host "Nieprawidlowy numer grupy."
        }
        
        Write-Host "CZYTAJ ZE ZROZUMIENIEM CO WPISUJESZ"
        Write-Host "1. Pojedynczy uzytkownik"
        Write-Host "2. Wiecej uzytkownikow za jednym razem"
        $choice = Read-Host "Wybierz opcje"
        if ($choice -eq "1") {
            $oneMember = Read-Host "Podaj nazwe uzytkownika"
            Add-ADGroupMember -Identity $selectedGroupName -Members $oneMember
            if (Get-ADGroupMember -Identity $selectedGroupName -Members $oneMember) {
                Write-Host "$oneMember pomyslnie dodany do $selectedGroupName"
            }
            else {
                Write-Host "Uzytkownik nie istnieje lub wystapic‚ blad."
            }
        }
        elseif ($choice -eq "2") {
            $groupMember = Read-Host "Podaj kilku uzytkownikow oddzielonych spacjami"
            $groupMemberList = $groupMember -split ' '
            $memberList = @()
            foreach ($member in $groupMemberList) {
                if (Get-ADUser -Filter { SamAccountName -eq $member }) {
                    $memberList += $member
                }
                else {
                    Write-Host "Uzytkownik '$member' nie istnieje."
                }
            }
        
            if ($memberList.Count -gt 0) {
                Add-ADGroupMember -Identity $selectedGroupName -Members $memberList
                foreach ($user in $memberList) {
                    Write-Host "$user pomyslnie dodany do $selectedGroupName"
                }
            }
            else {
                Write-Host "Nie udalo sie dodac zadnych uzytkownikow."
            }
        }
        else {
            Write-Host "Wybrano niepoprawna opcja™."
        }
    }
    
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }

}