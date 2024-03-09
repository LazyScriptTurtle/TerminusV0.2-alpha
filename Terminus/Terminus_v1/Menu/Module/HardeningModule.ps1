


function HardeningModule {

    do 
    {
     Clear-Host
     Write-Host '/=========== Hardening Module ===========\'
     Write-Host '| 1. Group Policy Objects                |'
     Write-Host '| 2. Firewall                            |'
     Write-Host '| 3. Baseline                            |'
     Write-Host '| ############## Wyjscie ##############  |'
     Write-Host '| 4. Powrot                              |'
     Write-Host '|========================================|'

     $choice = Read-Host "Wybierz opcje "
     switch($choice){
      '1' {HardGPO}
      '2' {HardFirewall}
      '3' {HardBaseline}
      '4' {Write-Host "Powrot ..."; break}
      deafult {Write-Host " Bledna opcja"}
     }

    } while ($choice -ne '4')


}