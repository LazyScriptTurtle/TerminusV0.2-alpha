$admPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. "$admPath\..\..\Function\ADM\AdmUsers.ps1"
. "$admPath\..\..\Function\ADM\AdmDirectory"

#$admPath = "$PSScriptRoot\..\..\Function\ADM\AdmUsers.ps1"
#$ouPath = "$PSScriptRoot\..\..\Function\ADM\AdmDirectory.ps1"

#. $admPath
#. $ouPath
function AdministrationModule {

    do 
    {
     Clear-Host
     Write-Host '/======== Administration Module ========\'
     Write-Host '| 1. Uzytkownicy                        |'
     Write-Host '| 2. OUs\Foldery                        |'
     Write-Host '| 3. Uprawnienia\ACL                    |'
     Write-Host '| ############## Wyjscie ############## |'
     Write-Host '| 4. Powrot                             |'
     Write-Host '|=======================================|'

     $choice = Read-Host "Wybierz opcje "
     switch($choice){
      '1' {AdmUsers}
      '2' {AdmDirectory}
      '3' {AdmPermnissions}
      '4' {Write-Host "Powrot ..."; break}
      deafult {Write-Host " Bledna opcja"}
     }

    } while ($choice -ne '4')

}
