


function AuditModule {

    do 
    {
     Clear-Host
     Write-Host '/============= Audit Module ============= \'
     Write-Host '| 1. Raport z Konfiguracji                |'
     Write-Host '| 2. Wykaz Programow                      |'
     Write-Host '| 3. Zgodnosc z Baseline                  |'
     Write-Host '| ############### Wyjscie ############### |'
     Write-Host '| 4. Powrot                               |'
     Write-Host '|=========================================|'

     $choice = Read-Host "Wybierz opcje "
     switch($choice){
      '1' {AuditReport}
      '2' {AuditInstallProgram}
      '3' {AuditBaseline}
      '4' {Write-Host "Powrot ..."; break}
      deafult {Write-Host " Bledna opcja"}
     }

    } while ($choice -ne '4')


}