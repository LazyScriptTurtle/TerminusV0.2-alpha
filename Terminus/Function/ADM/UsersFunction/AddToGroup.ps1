



function AddToGroup {
    try {
        

    $usersInput = Read-Host "Podaj użytkownika/ow (user,user1,user2): "
    $users = $usersInput.Split(',') | ForEach-Object { $_.Trim() }
    $group = (Read-Host :"Nazwa grupy do ktorej chcesz dodac uzytkownik/ow: ").Trim()


    if ($null -ne (Get-ADGroup -Identity $group))
    {
        Add-ADGroupMember -Identity $group -Members $users
        Read-Host "Uzytkownik pomyslnie dodany :) "
    }
    else {
        Read-Host "Podana grupa nie istnieje "
        
    }
}
catch {
    Write-Host "Blad: $_."
}    
    


}