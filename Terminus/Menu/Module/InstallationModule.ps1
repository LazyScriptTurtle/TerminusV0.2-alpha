


function InstallationModule {

    do 
    {
     Clear-Host
     Write-Host '/========== Installation Module ==========\'
     Write-Host '| 1. Active Directory                     |'
     Write-Host '| 2. Exchange Server                      |'
     Write-Host '| 3. File Server                          |'
     Write-Host '| 4. Web Server (IIS)                     |'
     Write-Host '| 5. Remote Desktop Server                |'
     Write-Host '| 6. SQL Server                           |'
     Write-Host '| 7. Backup Server                        |'
     Write-Host '| ############### Wyjscie ############### |'
     Write-Host '| 8. Powrot                               |'
     Write-Host '|=========================================|'

     $choice = Read-Host "Wybierz opcje "
     switch($choice){
      '1' {InstallAD}
      '2' {InstallExchange}
      '3' {InstallFS}
      '4' {InstallIIS}
      '5' {InstallRDS}
      '6' {InstallSQL}
      '7' {InstallBackup}
      '8' {Write-Host "Powrot ..."; break}
      deafult {Write-Host " Bledna opcja"}
     }

    } while ($choice -ne '8')


}