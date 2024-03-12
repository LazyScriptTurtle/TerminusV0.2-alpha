function IPConfig {

   try{
         Write-Host "1. Przywroc ustawienia domyslne karty sieciowej"
        Write-Host "2. Konfiguracja karty sieciowej"
        $netAdapterRestart = Read-Host 

        if ($netAdapterRestart -eq "1") {
            $ipAddresses = Get-NetIPAddress -InterfaceAlias $interface
            foreach ($ip in $ipAddresses) {
                Remove-NetIPAddress -InterfaceAlias $interface -IPAddress $ip.IPAddress -PrefixLength $ip.PrefixLength -Confirm:$false
            }
            Set-NetIPInterface -InterfaceAlias $interface -DHCP Enabled
            # Pobierz wszystkie obiekty DNSClientServerAddress
            $dnsServers = Get-DnsClientServerAddress
            # Usuń wszystkie niestandardowe serwery DNS
            Set-DnsClientServerAddress -InterfaceAlias $interface -ResetServerAddresses
            #$dnsServers | Where-Object { $_.ServerAddresses.Count -gt 1 } | ForEach-Object {
            # Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses $_.ServerAddresses}
            start-sleep -Seconds 5
            Disable-NetAdapter -Name $interface -Confirm:$false
            Enable-NetAdapter -Name $interface -Confirm:$false
            start-sleep -Seconds 5
            Get-NetIPConfiguration | Select-Object InterfaceAlias, IPAddress, PrefixLength, DefaultIPGateway, DNSServer
        }

        elseif ($netAdapterRestart -eq "2") {
            $newIP = Read-Host "Podaj nowe IP"
            $mask = Read-Host "Podaj maske podsieci w notacji CIDR"
            $gate = Read-Host "podaj adres bramy domyslnej"
            #DNS1 i DNS2
            $firstAddressDNS = Read-Host "Podaj pierwszy DNS lub nacisnij 'ENTER' aby zostawic wartosc domyslna"
            $secondAddressDNS = Read-Host "Podaj drugi DNS lub nacisnij 'ENTER' aby zostawic wartosc domyslna"
            #sprawdzenie DNS1
            if ($firstAddressDNS -ne "" -and $secondAddressDNS -ne "") {
                Set-DnsClientServerAddress -InterfaceAlias $interface -ServerAddresses $firstAddressDNS, $secondAddressDNS
                Write-Host "DNS1 $firstAddressDNS DNS2 $secondAddressDNS"
            }
            elseif ($firstAddressDNS -ne "" -and $secondAddressDNS -eq "") {
                Set-DnsClientServerAddress -InterfaceAlias $interface -ServerAddresses $firstAddressDNS
                Write-Host "DNS1 $firstAddressDNS DNS2 ..."
            }
            else {
                Write-Host "Nie zdefiniowano adresow"    
            }
            New-NetIPAddress -InterfaceAlias $interface -IPAddress $newIP -PrefixLength $mask -SkipAsSource $true -DefaultGateway $gate
        }
        else {
            Write-Host "Wyjscie"
        }
                
        $IPv6 = Read-Host "Czy chcesz wylaczyc IPv6 ? Y or N"

        if ($IPv6 -eq "Y" -or $IPv6 -eq "y") {
            $checker = Get-NetAdapterBinding -Name $interface -ComponentID ms_tcpip6 
            $IP = $checker.Enabled
            if ($IP -eq $False) {
                Write-Host "IPv6 zostalo wczesniej wylaczone"
            }
            else {
                Disable-NetAdapterBinding -Name $interface -ComponentID ms_tcpip6    
            }            
        }
        else {
            Write-Host "IPv6 pozostawione bez zmian"
        }
    }
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }
}