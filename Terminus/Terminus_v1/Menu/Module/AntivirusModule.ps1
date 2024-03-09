


function AntivirusModule {

    do 
    {
     Clear-Host
     Write-Host '/=========== Antivirus Module ===========\'
     Write-Host '|        Cierpliwosci Prace Trwaja       |'
     Write-Host '| ############### Wyjscie ###############|'
     Write-Host '| 1. Powrot                              |'
     Write-Host '|========================================|'

     $choice = Read-Host "Wybierz opcje "
     switch($choice){
      '4' {Write-Host "Powrot ..."; break}
      deafult {Write-Host " Bledna opcja"}
     }

    } while ($choice -ne '1')


}