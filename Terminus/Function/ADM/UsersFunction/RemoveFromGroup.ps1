

function RemoveFromGroup {
    try {
        

    $usersInput = Read-Host "Podaj użytkownika/ow (user,user1,user2): "
    $users = $usersInput.Split(',') | ForEach-Object { $_.Trim() }
    $group = (Read-Host :"Nazwa grupy z ktorej chcesz usunac uzytkownik/ow: ").Trim()


    if ($null -ne (Get-ADGroup -Identity $group))
    {
        Remove-ADGroupMember -Identity $group -Members $users
    }
    else {
        Read-Host "Podana grupa nie istnieje "
        
    }
}
catch {
    Write-Host "Blad: $_."
}   
} 