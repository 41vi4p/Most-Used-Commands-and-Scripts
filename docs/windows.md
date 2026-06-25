# Windows Tips & Scripts Reference

## Skip Microsoft Account Login During Windows Setup

Run this in **Command Prompt** during OOBE (Out-of-Box Experience / initial setup screen):

```bat
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE /v BypassNRO /t REG_DWORD /d 1 /f
shutdown /r /t 0
```

This reboots the machine and allows you to create a local account instead of being forced to log in with a Microsoft account.

---

## Activate Windows Without Microsoft Account (Offline Account)

During setup, when asked to connect to the internet:
1. Press `Shift + F10` to open Command Prompt
2. Run the bypass command above
3. Or disconnect from the internet and click "I don't have internet"

---

## WSL (Windows Subsystem for Linux)

### Install WSL
```powershell
# Run in PowerShell as Administrator
wsl --install                                     # installs WSL2 + Ubuntu by default
wsl --install -d Ubuntu-22.04                     # install specific distro
wsl --list --online                               # list available distros
wsl --list --verbose                              # list installed distros
```

### Common WSL commands
```powershell
wsl                                               # launch default distro
wsl -d Ubuntu-22.04                               # launch specific distro
wsl --shutdown                                    # stop all WSL instances
wsl --update                                      # update WSL kernel
wsl --export Ubuntu-22.04 backup.tar              # export distro to file
wsl --import MyUbuntu C:\WSL\ backup.tar          # import distro from file
wsl --set-default Ubuntu-22.04                    # set default distro
wsl --set-version Ubuntu-22.04 2                  # upgrade distro to WSL2
```

---

## Windows Package Manager (winget)

```powershell
winget search "app name"                          # search for an app
winget install package-id                         # install an app
winget install Microsoft.VisualStudioCode         # VS Code example
winget install Git.Git                            # Git example
winget install Docker.DockerDesktop               # Docker Desktop example
winget upgrade --all                              # upgrade all installed apps
winget uninstall package-id                       # uninstall an app
winget list                                       # list installed apps
winget export -o packages.json                    # export installed app list
winget import -i packages.json                    # install from exported list
```

---

## Chocolatey (Alternative Package Manager)

### Install Chocolatey
```powershell
# Run in PowerShell as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Chocolatey commands
```powershell
choco install googlechrome                        # install Chrome
choco install nodejs                              # install Node.js
choco install git                                 # install Git
choco install vscode                              # install VS Code
choco upgrade all                                 # upgrade all packages
choco list --local-only                           # list installed packages
choco uninstall package-name                      # uninstall
```

---

## Useful Windows CMD Commands

```bat
:: System Info
systeminfo                                        :: full system info
ver                                               :: Windows version
hostname                                          :: computer name
ipconfig                                          :: network config
ipconfig /all                                     :: detailed network info
ipconfig /flushdns                                :: flush DNS cache

:: File Operations
dir                                               :: list files
dir /s /b *.txt                                   :: find all .txt files recursively
copy file.txt C:\destination\                     :: copy file
move file.txt C:\destination\                     :: move file
del file.txt                                      :: delete file
rmdir /s /q folder                                :: delete directory

:: Process Management
tasklist                                          :: list running processes
tasklist | findstr "chrome"                       :: find a process
taskkill /F /IM chrome.exe                        :: kill by name
taskkill /F /PID 1234                             :: kill by PID

:: Network
ping google.com                                   :: test connectivity
tracert google.com                                :: trace route
netstat -ano                                      :: open ports
netstat -ano | findstr :3000                      :: who's on port 3000
nslookup example.com                              :: DNS lookup
```

---

## Useful PowerShell Commands

```powershell
# System
Get-ComputerInfo                                  # full system info
Get-Process                                       # list processes
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10  # top by CPU
Stop-Process -Name chrome -Force                  # kill a process

# Files
Get-ChildItem                                     # list files (like ls)
Get-ChildItem -Recurse -Filter "*.txt"            # find files
Copy-Item file.txt C:\destination\                # copy
Move-Item file.txt C:\destination\                # move
Remove-Item file.txt                              # delete
Remove-Item -Recurse -Force folder\               # delete directory

# Network
Test-NetConnection google.com                     # ping equivalent
Test-NetConnection google.com -Port 443           # test specific port
Resolve-DnsName example.com                       # DNS lookup
Get-NetIPAddress                                  # IP addresses
Get-NetAdapter                                    # network adapters

# Services
Get-Service                                       # list all services
Get-Service -Name wsl*                            # find services by name
Start-Service -Name ServiceName                   # start service
Stop-Service -Name ServiceName                    # stop service
Set-Service -Name ServiceName -StartupType Automatic  # auto-start
```

---

## Registry (regedit) Quick Reference

```bat
:: Export a registry key
reg export HKLM\SOFTWARE\MyKey backup.reg

:: Import a registry key
reg import backup.reg

:: Add a value
reg add HKCU\SOFTWARE\MyApp /v Setting /t REG_SZ /d "value" /f

:: Delete a value
reg delete HKCU\SOFTWARE\MyApp /v Setting /f

:: Query a value
reg query HKCU\SOFTWARE\MyApp /v Setting
```
