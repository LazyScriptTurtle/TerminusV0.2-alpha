

function BlockUser {
try {
    
$imie = Read-Host "Podaj imię"
$nazwisko = Read-Host "Podaj nazwisko"
$email = Read-Host "Podaj adres email"

$user = Get-ADUser -Filter "GivenName -eq '$imie' -and Surname -eq '$nazwisko' -and EmailAddress -eq '$email'" -Properties EmailAddress

if ($null -ne $user)
{
    Disable-ADAccount -Identity "$user" -Confirm:$false
}
else {
    Read-Host "Uztkownik nie istnieje"
}

}
catch {
    Write-Host "Blad: $_."
}

}