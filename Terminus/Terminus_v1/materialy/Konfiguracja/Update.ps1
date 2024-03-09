function Update {
    try {
        Write-Host "Prosze czekac trwa sprawdzanie aktualizacji"
        $vmUpdate = $null
        $vmUpdate = Get-WindowsUpdate
            

        if ($vmUpdate) {
            $vmUpdate | Format-Table -AutoSize
            $choice = Read-Host "Chcesz przeprowadzic aktualizacje? Y or N:"
            if ($choice -eq "Y" -or $choice -eq "y" ) {

                Write-Host "Znajdujesz sie na maszynie $global:vmName po 5 sekundach zostana zaaplikowane zmiany"
                Install-WindowsUpdate -AcceptAll -IgnoreReboot
                
                $restart = Read-Host "Jezeli chcesz zrestartowac maszyne wybierz 'Y': "
                if ($restart -eq "Y" -or $restart -eq "y") {
                }
                else {
                    Write-Host "Restart pominieto"
                }
            }
            else {
                Write-Host "Update pominieto"
            }
        }
        else {
            Write-Host "System jest aktualny nie ma nowych aktualizacji"
        }
        
    }
    
    catch {
        Write-Host "Blad skontaktuj sie z administratorem: $_"
    }
}