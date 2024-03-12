$menuPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. "$menuPath\Module\AdministrationModule.ps1"
. "$menuPath\Module\HardeningModule.ps1"
. "$menuPath\Module\InstallationModule.ps1"
. "$menuPath\Module\AuditModule.ps1"
. "$menuPath\Module\AntivirusModule.ps1"

  function ShowMenu {
	  do {
		  Clear-host
		  Write-Host '/========== Menu ==========\'
		  Write-Host '| 1. Modul Administracyjny |'
		  Write-Host '| 2. Modul Hardeningowy    |'
		  Write-Host '| 3. Modul Instalacyjny    |'
		  Write-Host '| 4. Modul Audytowy        |'
		  Write-Host '| 5. Modul Antywirusowy(NR)|'
		  Write-Host '|      ### Wyjscie ###     |'	
		  Write-Host '| 6. Wyjscie               |'
		  Write-Host '\==========================/'
			$choice = Read-Host "Wybierz opcje"
			switch ($choice)
			{
				'1' {AdministrationModule}
				'2' {HardeningModule}
				'3' {InstallationModule}
				'4' {AuditModule}
				'5' {AntivirusModule}
				'6' {Write-Host "Zamykanie ..." ; break}
				default {Write-Host "Bledna opcja "}
			}
		} 
		while ($choice -ne '6')
  }
	
