function StationChangeName {
       
            
    $newName = Read-Host "Podaj nowa nazwe komputera"
    Rename-Computer $newName -Force
    $restart = Read-Host "Chcesz zrestartowac komputer teraz aby zapisac zmiany? Y or N"
    if ($restart -eq "Y" -or $restart -eq "y") {
        Restart-Computer -Force
    }
    else {
        Write-Host "Restart pominieto"
    }
}
    
catch {
    Write-Host "Blad skontaktuj sie z administratorem: $_"
}