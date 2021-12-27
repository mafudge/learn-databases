
#Requires -RunAsAdministrator
Out-Host "This will install Learn-Databases"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install -y git
choco install -y vscode
choco install -y azure-data-studio 
choco install -y docker-desktop docker-compose 
cd ~/Documents
git clone http://github.com/mafudge/learn-databases.git 
cd learn-databases 
docker-compose up -d 

