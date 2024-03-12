function DomainInstallation {
    try {
            
        $domainName = Read-Host "Podaj nazwe domeny: "
        $netBiosName = Read-Host "Podaj nazwe NetBios: "
        Write-Host "Postepuj zgodnie z  informacjami"
        Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
        Install-ADDSForest -DomainName $domainName -DomainNetbiosName $netBiosName -InstallDns
    }
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }
}
function DOmainControllerPromotion {   

    try {
    
        $dnsDelegation = Read-Host "Delegowac DNS? (Y)es or (N)o"
        if ($dnsDelegation -eq "y" -or $dnsDelegation -eq "Y") {
            $dnsDelegation = $true
        }
        elseif ($dnsDelegation -eq "N" -or $dnsDelegation -eq "n") {
            $dnsDelegation = $false
        }
        else {
            Write-Host "Niepoprawna opcja"
            return
        }
        $databasePath = $null
        $defaultDatabasePath = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" | Select-Object -ExpandProperty "DSA Working Directory"
        $databasePath = Read-Host "Podaj sciezke do bazy danych domeny (default: $defaultDatabasePath )"
        if ([string]::IsNullOrEmpty($databasePath)) {
            $databasePath = $defaultDatabasePath
        }
        $domainName = $null
        $defaultDomain = Get-ADDomain | Select-Object -ExpandProperty DNSRoot
        $domainName = Read-Host "Podaj nazwę DNS nowej domeny ktora będzie nazywac twoja siec (domyslnie: $defaultDomain)"
        if ([string]::IsNullOrEmpty($domainName)) {
            $domainName = $defaultDomain
        }
        $netBiosName = $null
        $defaultNetBiosName = Get-ADDomain | Select-Object -ExpandProperty NetBIOSName
        $netBiosName = Read-Host "Podaj nazwę DNS nowej domeny ktora będzie nazywac twoja siec (domyslnie: $defaultNetBiosName)"
        if ($netBiosName -eq $null) {
            $netBiosName = Get-ADDomain | Select-Object -ExpandProperty NetBIOSName
        }
        $dnsInstall = Read-Host "instalowac DNS? (Y)es or (N)o (domyslnie: YES)"
        if ($dnsInstall -eq "y" -or $dnsInstall -eq "Y") {
            $dnsDelegation = $true
        }
        elseif ($dnsInstall -eq "N" -or $dnsInstall -eq "n") {
            $dnsInstall = $false
        }
        else {
            $dnsInstall = $true
        }
        $defaultLogPath = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" | Select-Object -ExpandProperty "Database log files path"
        $logPath = Read-Host "Podaj nazwę DNS nowej domeny ktora będzie nazywac twoja siec (domyslnie: $defaultLogPath)" 
        if ($logPath -eq "1") {
            $logPath = $defaultLogPath
        }
        $reboot = Read-Host "Restartowac maszyne po instalacji? (Y)es or (N)o (domyslnie: NO)"
        if ($reboot -eq "y" -or $reboot -eq "Y") {
            $reboot = $true
        }
        elseif ($reboot -eq "N" -or $reboot -eq "n") {
            $reboot = $false
        }
        else {
            $reboot = $true
        }

        $sysvolPath = Read-Host "Podaj sciezke do pliku SYSVOL (domyslnie: 'C:\Windows\SYSVOL')"
        if ($sysvolPath -eq $null) {
            $sysvolPath = "C:\Windows\SYSVOL"
        }

        Write-Host "Sprawdzenie danych "
        if ($dnsDelegation -eq $true ) {
            Write-Host "Delegacja DNS Wlaczona"
        }
        else {
            Write-Host "Delegacja DNS wylaczona"
        }
        Write-Host "2 Sciezka Bazadanych "$databasePath
        Write-Host "3 Nazwa domeny "$domainName
        Write-Host "4 Nazwa NetBIOS"$netBiosName
        if ($dnsInstall -eq $true ) {
            Write-Host "Instalacja DNS Wlaczona"
        }
        else {
            Write-Host "Instalacja DNS wylaczona"
        }
        Write-Host "6 Sciezka LOG "$logPath
        if ($reboot -eq $true ) {
            Write-Host "Restart wylaczony"
        }
        else {
            Write-Host "Restart wlaczony"
        }
        Write-Host "8 Sciezka SYSVOL "$sysvolPath

        Install-ADDSForest -CreateDnsDelegation:$dnsDelegation -DatabasePath $databasePath -DomainMode "WinThreshold" -DomainName $domainName -DomainNetbiosName $netBiosName -ForestMode "WinThreshold" -InstallDns:$dnsInstall -LogPath $logPath -NoRebootOnCompletion:$reboot -SysvolPath $sysvolPath -Force:$true 

    }
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }
}