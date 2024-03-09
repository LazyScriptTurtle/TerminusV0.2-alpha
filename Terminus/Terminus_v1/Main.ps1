# Importowanie glownego menu
.  .\Menu\MainMenu.ps1

$moduleChecker = @(Get-Module -ListAvailable -All).Name
$requiredModule = @('PSWindowsUpdate', 'Hyper-V', 'ActiveDirectory')

foreach ($module in $requiredModule)
{
    if($moduleChecker -notcontains $module)
    {
        Write-Host "Modul $module nie jest dostepny na tej stacji " -ForegroundColor Red
        $choice = Read-Host "Chcesz zaimportowac (Y) or (No) ? " 
        if ($choice.ToLower() -eq 'y')
        {  
            Import-Module -Name Hyper-V 
        }
        elseif ($choice.ToLower() -ne 'y')
        {
            write-host "Funkcje zwiazane z $module nie beda dostepne" -ForegroundColor White -BackgroundColor Black
        }
    }
}

# Czas na zapoznanie sie z informacjami
Write-Host "Otwieranie Menu..."
sleep -Seconds 3
# wywolanie menu
ShowMenu