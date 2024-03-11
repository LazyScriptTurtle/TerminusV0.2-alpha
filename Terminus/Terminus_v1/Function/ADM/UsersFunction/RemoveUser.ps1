

function RemoveUser {
    try {

# Zbieranie danych wejściowych od użytkownika
$imie = Read-Host "Podaj imię"
$nazwisko = Read-Host "Podaj nazwisko"
$email = Read-Host "Podaj adres email"

# Wyszukiwanie użytkownika w Active Directory
$uzytkownik = Get-ADUser -Filter "GivenName -eq '$imie' -and Surname -eq '$nazwisko' -and EmailAddress -eq '$email'" -Properties EmailAddress

if ($null -ne $uzytkownik) {
    # Jeśli znaleziono użytkownika, wyświetl potwierdzenie
    $odpowiedz = Read-Host "Czy na pewno chcesz usunąć użytkownika $($uzytkownik.Name) (t/n)?"
    if ($odpowiedz -eq 't') {
        # Usuwanie użytkownika
        Remove-ADUser -Identity $uzytkownik -Confirm:$false
        Write-Host "Użytkownik został usunięty."
    } else {
        Write-Host "Anulowano usuwanie użytkownika."
    }
} else {
    # Jeśli użytkownik nie został znaleziony
    Read-Host "Nie znaleziono użytkownika spełniającego podane kryteria."
}

    }
    catch {
        Write-Host "Błąd: $_"
    }
}
