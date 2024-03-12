
function Search{
try {
    
    $user = (Read-Host "Podaj nazwe uzytkownika: ").Trim()

   $userSerach = Get-ADUser -Identity "$user"

    if ($null -ne $userSerach)
    {
        Write-Host $userSerach
    }
    else {
        Read-Host "Podany uzytkownik nie istnieje"
    }

}

catch {
    Write-Host "Blad: $_."
}



}