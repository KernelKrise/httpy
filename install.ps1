# Variables
$httpyUrl = "https://raw.githubusercontent.com/KernelKrise/httpy/refs/heads/main/httpy"
$httpyBatUrl = "https://raw.githubusercontent.com/KernelKrise/httpy/refs/heads/main/httpy.bat"

# Logging
function Write-ILog {
    param (
        [string]$Message
    )
    Write-Host "[*] $Message"
}
function Write-ELog {
    param (
        [string]$Message
    )
    Write-Host "[!] $Message"
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

Write-Ilog "httpy installed"
