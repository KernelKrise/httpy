# Constants
$httpyUrl = "https://raw.githubusercontent.com/KernelKrise/httpy/refs/heads/main/httpy"
$httpyBatUrl = "https://raw.githubusercontent.com/KernelKrise/httpy/refs/heads/main/httpy.bat"
$contextMenuLabel = "Launch HTTPY here"

# Logging
function Write-ILog {
    param (
        [string]$Message
    )
    Write-Host "[*] ${Message}" -ForegroundColor Green
}
function Write-QLog {
    param (
        [string]$Message
    )
    return Read-Host "[?] ${Message}"
}
function Write-ELog {
    param (
        [string]$Message
    )
    Write-Host "[!] ${Message}" -ForegroundColor Red
}

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-ILog "This script requires Administrator privileges to add httpy to context menu"
    Write-ILog "Context menu is a menu that appears when you right-click on desktop or folder background"
    $answer = Write-QLog "Do you want to elevate to Administrator? [Y/n]"
 
    if ($answer -eq '' -or $answer -eq 'y' -or $answer -eq 'Y') {
        if ($PSCommandPath) {
            Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        }
        else {
            $tmpFile = "$env:TEMP\httpy_tmp.ps1"
            $MyInvocation.MyCommand.ScriptBlock | Out-File -FilePath $tmpFile -Encoding UTF8
            Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmpFile`"" -Verb RunAs
        }
        exit
    }
    Write-ILog "Continuing without elevation"
}

# Check if python available
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-ELog "Python is not available. Exiting..."
    exit 1
}

# Get python script folder path
$scriptsPath = python -c "import sys, os; print(os.path.join(os.path.dirname(sys.executable), 'Scripts'))"
Write-Ilog "Python Scripts folder path: ${scriptsPath}"

# Check if the Scripts folder
$path = [System.Environment]::GetEnvironmentVariable("PATH", "User")
$pathFolders = $path -split ';'
if (-not ($pathFolders -contains $scriptsPath)) {
    Write-ELog "Folder ${scriptsPath} is NOT in PATH. Add it to PATH to use httpy"
}

# Download httpy
Write-Ilog "Downloading httpy"
Invoke-WebRequest -Uri "${httpyUrl}" -OutFile "${scriptsPath}/httpy.py"
Invoke-WebRequest -Uri "${httpyBatUrl}" -OutFile "${scriptsPath}/httpy.bat"

# Contex menu on desktop / folder
if ($isAdmin) {
    Write-Ilog "Adding httpy to context menu"
    if (-not (Get-PSDrive -Name HKCR -ErrorAction SilentlyContinue)) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    $contextMenuCommand = "cmd.exe /c `"${scriptsPath}/httpy.bat`""
    $pathBg = "HKCR:\Directory\Background\shell\httpy"
    if (-not (Test-Path "${pathBg}")) { New-Item -Path "${pathBg}" -Force | Out-Null }
    Set-ItemProperty -Path "${pathBg}" -Name "(Default)" -Value "$contextMenuLabel"
    if (-not (Test-Path "${pathBg}\command")) { New-Item -Path "${pathBg}\command" -Force | Out-Null }
    Set-ItemProperty -Path "${pathBg}\command" -Name "(Default)" -Value "${contextMenuCommand}"
}
else {
     Write-Ilog "httpy is not added to context menu (reinstall as Administrator)"
}

Write-Ilog "httpy installed"
