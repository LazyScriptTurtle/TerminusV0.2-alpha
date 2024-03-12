

function RemoveUser {
    try {

# Zbieranie danych wejściowych od uzytkownika
$imie = Read-Host "Podaj imie"
$nazwisko = Read-Host "Podaj nazwisko"
$email = Read-Host "Podaj adres email"

# Wyszukiwanie uzytkownika w Active Directory
$uzytkownik = Get-ADUser -Filter "GivenName -eq '$imie' -and Surname -eq '$nazwisko' -and EmailAddress -eq '$email'" -Properties EmailAddress

if ($null -ne $uzytkownik) {
    # Jeśli znaleziono uzytkownika, wyświetl potwierdzenie
    $odpowiedz = Read-Host "Czy na pewno chcesz usunac uzytkownika $($uzytkownik.Name) (t/n)?"
    if ($odpowiedz -eq 't') {
        # Usuwanie uzytkownika
        Remove-ADUser -Identity $uzytkownik -Confirm:$false
        Read-Host "Uzytkownik zostal usuniety."
    } else {
        Read-Host "Anulowano usuwanie uzytkownika."
    }
} else {
    # Jeśli uzytkownik nie zostal znaleziony
    Read-Host "Nie znaleziono uzytkownika spelniajacego podane kryteria."
}

    }
    catch {
        Write-Host "Blad: $_"
    }
}
