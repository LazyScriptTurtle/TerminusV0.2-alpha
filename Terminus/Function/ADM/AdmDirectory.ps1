

function AdmDirectory {

    do 
    {
     Clear-Host
     Write-Host '/======== Administration Module ========\'
     Write-Host '| 1. Stworz OU                          |'
     Write-Host '| 2. Usun OU                            |'
     Write-Host '| 3. Przenies OU                        |'
     Write-Host '| 4. Zablokuj Usuwanie OU               |'
     Write-Host '| 5. Odblokuj Usuwanie OU               |'
     Write-Host '| 6. Wylistuj obecne OU                 |'
     Write-Host '| 7. Wyszukaj OU                        |'
     Write-Host '| ############## Wyjscie ############## |'
     Write-Host '| 8. Powrot                             |'
     Write-Host '|=======================================|'

     $choice = Read-Host "Wybierz opcje "
     switch($choice){
      '1' {CreateOU}
      '2' {DeleteOU}
      '3' {MoveOU}
      '4' {LockOUDel}
      '5' {UnlockOUDel}
      '6' {ListOU}
      '7' {SearchOU}
      '8' {Write-Host "Powrot ..."; break}
      deafult {Write-Host " Bledna opcja"}
     }

    } while ($choice -ne '8')

}