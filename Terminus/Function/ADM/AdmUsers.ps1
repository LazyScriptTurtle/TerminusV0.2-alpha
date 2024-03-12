$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. "$scriptPath\UsersFunction\CreateUser.ps1"
. "$scriptPath\UsersFunction\RemoveUser.ps1"
. "$scriptPath\UsersFunction\AddToGroup.ps1"
. "$scriptPath\UsersFunction\RemoveFromGroup.ps1"
. "$scriptPath\UsersFunction\BlockUser.ps1"
. "$scriptPath\UsersFunction\RestartUserPassword.ps1"
. "$scriptPath\UsersFunction\ListUsers.ps1"
. "$scriptPath\UsersFunction\Search.ps1"
. "$scriptPath\UsersFunction\UserImportCSV.ps1"


function AdmUsers {

    do 
    {
     Clear-Host
     Write-Host '/================= Uzytkownicy =================\'
     Write-Host '| 1. Stworz Uzytkownika                         |'
     Write-Host '| 2. Usun Uzytkownika                           |'
     Write-Host '| 3. Dodaj Uzytkownika do Grupy                 |'
     Write-Host '| 4. Usun Uzytkownika z Grupy                   |'
     Write-Host '| 5. Zablokuj Uzytkownika                       |'
     Write-Host '| 6. Zrestartuj Haslo                           |'
     Write-Host '| 7. Wylistuj Uzytkownikow                      |'
     Write-Host '| 8. Szukaj Uzytkownika                         |'
     Write-Host '| 9. Zaimportuj Liste Uzytkownikow z plikuu CSV |'
     Write-Host '| ################## Wyjscie ################## |'
     Write-Host '| 10. Powrot                                    |'
     Write-Host '|===============================================|'

     $choice = Read-Host "Wybierz opcje "
     switch($choice){
      '1' {CreateUser}
      '2' {RemoveUser}
      '3' {AddToGroup}
      '4' {RemoveFromGroup}
      '5' {BlockUser}
      '6' {RestartUserPassword}
      '7' {ListUsers}
      '8' {Search}
      '9' {UserImportCSV}
      '10' {Write-Host "Powrot ..."; break}
      deafult {Write-Host " Bledna opcja"}
     }

    } while ($choice -ne '10')


}

