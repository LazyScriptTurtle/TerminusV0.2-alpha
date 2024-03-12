

function ListUsers {
    try {

$users = Get-ADUser -Filter * -Properties DistinguishedName, SamAccountName | Sort-Object Name

$groupedUsers = $users | Group-Object { ($_ -split ',',2)[-1] }

foreach ($group in $groupedUsers) {
    Write-Output "`nOU=$($group.Name)"
    foreach ($user in $group.Group) {
        Write-Output $($user.SamAccountName)
    }
}
Read-Host "Nacisnij dowolny klawisz aby powrocic do menu:  "
}
catch {
  Read-Host "Blad: $_."
}
    
}