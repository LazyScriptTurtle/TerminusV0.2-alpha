function CreateFunction {
    param (
        [string]$searchBase = (Get-ADDomain).DistinguishedName
    )

    $global:ouPaths = @()
    $global:counter = 0
    $level = 0

    function Get-OuPath {
        param (
            [string]$searchBaseInner,
            [int]$levelInner
        )

        $ous = Get-ADOrganizationalUnit -Filter * -SearchBase $searchBaseInner -SearchScope OneLevel -Properties distinguishedName | Sort-Object DistinguishedName

        foreach ($ou in $ous) {
            $indent = " " * ($levelInner * 4)
            
            # Saving OU path to global list using hashmap
            $global:ouPaths += @{"Number" = $global:counter; "Path" = $ou.DistinguishedName }
            
            # Display path with number
            Write-Host "$indent$($global:counter). $($ou.DistinguishedName)"
            
            # Increment counter
            $global:counter++
    
            # Recursive call for nested OUs
            Get-OuPath -searchBaseInner $ou.DistinguishedName -levelInner ($levelInner + 1)
        }
    }

    Get-OuPath -searchBaseInner $searchBase -levelInner $level

    # Asking user to select an OU path
    $userInput = Read-Host "wybierz numer z odpowiednia sciezka: "
    $selectedNumber = [int]$userInput
    $selectedPath = $global:ouPaths | Where-Object { $_.Number -eq $selectedNumber } | ForEach-Object { $_.Path }

    if ($selectedPath) {
        Write-Host "Wybrana sciezka: $selectedPath"
    }
    else {
        Write-Host "Sciezki nie znaleziono: $selectedNumber"
    }

    $ouName = (Read-Host "Podaj nazwe OU: ")
    $protect = (Read-Host "wlaczyc ochrone przed usunieciem? (Y) or (N) ").Trim()
    
    if ($protect.ToLower() -eq "y")
    {
    New-ADOrganizationalUnit -Name $ouName -Path $selectedPath  -ProtectedFromAccidentalDeletion $true
    Read-Host "OU $ouName zostalo utworozne :) "
    }
    else {
        New-ADOrganizationalUnit -Name $ouName -Path $selectedPath  -ProtectedFromAccidentalDeletion $false
        Read-Host "OU $ouName zostalo utworozne :) "
    }
}

