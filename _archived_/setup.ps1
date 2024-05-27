
# Requires -RunAsAdministrator Virtualization must be on in the bios
Out-Host "This will install Learn-Databases"

# OLD
# dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
# dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
# wget https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# wsl --set-defawsl --set-default-version 2ult-version 2

# wsl --update 
# wsl --shutdown 


wsl --install 
# REBOOT .. set user ubuntu SU44orange!
wsl --update 
wsl --set-default-version 2 


wsl.exe
sudo apt-get update && sudo apt-get upgrade -y 
exit


Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install -y git
choco install -y vscode
choco install -y azure-data-studio 
choco install -y docker-desktop docker-compose 
cd ~/Documents
git clone http://github.com/mafudge/learn-databases.git 
cd learn-databases 
docker-compose up -d 

