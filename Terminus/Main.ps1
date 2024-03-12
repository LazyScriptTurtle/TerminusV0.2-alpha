# Importowanie glownego menu
.  .\Menu\MainMenu.ps1

if($null -eq (Get-PackageProvider -Name Nuget -ErrorAction SilentlyContinue ))
{
$choice = Read-Host "Nie wykryto Providera Pakietow NuGet bez niego nie bedize mozliwe doinstalowanie niezbednych modolow czy chcesz doinstalowac go tera? (Y_ or (N)"

if ($choice.ToLower() -eq 'y')
{
 Install-PackageProvider -Name NuGet -Force -Confirm:$false -ForceBootstrap
}
else
{
 Write-host "Nie dosinstalowano NuGet moze to ograniczyc pwne funkcjonalnosci i powodowac bledy"
sleep 3
}
}

$moduleChecker = @(Get-Module -ListAvailable -All).Name
$requiredModule = @('PSWindowsUpdate', 'ActiveDirectory')

foreach ($module in $requiredModule)
{
    if($moduleChecker -notcontains $module)
    {
        Write-Host "Modul $module nie jest dostepny na tej stacji " -ForegroundColor Red
        $choice = Read-Host "Chcesz zaimportowac (Y) or (No) ? " 
        if ($choice.ToLower() -eq 'y')
        {  
           Install-Module -Name $module -Confirm:$false -Force
        }
        else
        {
            write-host "Funkcje zwiazane z $module nie beda dostepne" -ForegroundColor White -BackgroundColor Black
        }
    }
}
<#
if($null -eq (Get-Module -Name Hyper-V))
{
Write-Host "Modul Hyper-V nie jest dostepny na tej stacji "
$choice = Read-Host "Chcesz zaimportowac (Y) or (N) ? "
if ($choice.ToLower() -eq 'y')
{
 Enable-WindowsOptionalFeature -Online -FeatureName  Microsoft-Hyper-V-Management-PowerShell
}
}
else
{
  write-host "Funkcje zwiazane z Hyper-V nie beda dostepne" -ForegroundColor White -BackgroundColor Black
}
#>

# Czas na zapoznanie sie z informacjami
Read-Host "Przejdz do menu naciskajac Enter "
# wywolanie menu
ShowMenu