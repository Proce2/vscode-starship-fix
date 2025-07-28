# install.ps1 - PowerShell 7+ Config & Starship Setup
# ---------------------------------------------------

# --- Sanity Checks ---
if (-not $HOME) {
    Write-Error "`$HOME is not defined. Please use PowerShell 7 or higher."
    exit 1
}

if (-not $PROFILE) {
    Write-Error "`$PROFILE is not set. Cannot find the PowerShell profile location."
    exit 1
}

if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
    Write-Warning "⚠️ Starship is not installed or not found in PATH. Please install it from https://starship.rs"
}

# --- Paths ---
$configDir = Join-Path $HOME ".config"
$pwshDir   = Split-Path $PROFILE

# --- Ensure folders exist ---
New-Item -ItemType Directory -Force -Path $configDir | Out-Null
New-Item -ItemType Directory -Force -Path $pwshDir   | Out-Null

# --- GitHub raw content base URL ---
$base = "https://raw.githubusercontent.com/Proce2/starship-pwsh-setup/main"

# --- Download Starship Configs ---
Invoke-WebRequest "$base/starship.toml"        -OutFile "$configDir\starship.toml"
Invoke-WebRequest "$base/starship_aws_on.toml" -OutFile "$configDir\starship_aws_on.toml"

# --- Download PowerShell Scripts ---
Invoke-WebRequest "$base/advanced-prompt.ps1"              -OutFile "$pwshDir\advanced-prompt.ps1"
Invoke-WebRequest "$base/starship-prompt.ps1"              -OutFile "$pwshDir\starship-prompt.ps1"
Invoke-WebRequest "$base/Microsoft.PowerShell_profile.ps1" -OutFile "$PROFILE"

# --- Done! ---
Write-Host "`n✅ PowerShell configs installed" -ForegroundColor Green

