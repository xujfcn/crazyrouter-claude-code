# Claude Code + Crazyrouter one-click installer for Windows
# Remote-exec friendly version for GitHub raw hosting
# Usage:
#   powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex"
# Or shorter:
#   irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex

$ErrorActionPreference = 'Stop'

# Enable TLS 1.2/1.3 so older PowerShell (5.1) can reach GitHub / nodejs.org over HTTPS
try {
  [Net.ServicePointManager]::SecurityProtocol = `
    [Net.ServicePointManager]::SecurityProtocol -bor `
    [Net.SecurityProtocolType]::Tls12 -bor `
    [Net.SecurityProtocolType]::Tls13
} catch {
  # Tls13 may not exist on very old .NET; fall back to Tls12 only
  [Net.ServicePointManager]::SecurityProtocol = `
    [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
}

# Pinned Node.js LTS used only when winget is unavailable / fails
$script:NodeFallbackVersion = 'v20.19.0'
$script:HasWinget = $false

function Write-Step($msg) {
  Write-Host "`n==> $msg" -ForegroundColor Cyan
}

function Write-Ok($msg) {
  Write-Host "[OK] $msg" -ForegroundColor Green
}

function Write-WarnMsg($msg) {
  Write-Host "[WARN] $msg" -ForegroundColor Yellow
}

function Refresh-UserPath {
  $machine = [Environment]::GetEnvironmentVariable('Path', 'Machine')
  $user = [Environment]::GetEnvironmentVariable('Path', 'User')
  $env:Path = (($machine, $user) -join ';')
}

function Get-RemoteFile($url, $dest) {
  # Prefer BITS (progress + resumable); fall back to Invoke-WebRequest
  try {
    if (Get-Command Start-BitsTransfer -ErrorAction SilentlyContinue) {
      Start-BitsTransfer -Source $url -Destination $dest -ErrorAction Stop
    } else {
      Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
    }
  } catch {
    Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
  }
}

function Install-NodeFromMsi {
  Write-Step "Downloading Node.js LTS $script:NodeFallbackVersion (winget unavailable)"
  $arch = if ([Environment]::Is64BitOperatingSystem) { 'x64' } else { 'x86' }
  $msi = Join-Path $env:TEMP "node_installer_$($arch).msi"
  $url = "https://nodejs.org/dist/$script:NodeFallbackVersion/node-$script:NodeFallbackVersion-$arch.msi"
  Get-RemoteFile $url $msi
  Write-Step "Installing Node.js (silent)"
  Start-Process msiexec.exe -ArgumentList "/i `"$msi`" /qn /norestart" -Wait -Verb RunAs
  Remove-Item $msi -Force -ErrorAction SilentlyContinue
}

function Install-GitFromExe {
  Write-Step "Downloading Git for Windows (winget unavailable)"
  $headers = @{ 'User-Agent' = 'Mozilla/5.0'; 'Accept' = 'application/json' }
  try {
    $rel = Invoke-RestMethod -Uri 'https://api.github.com/repos/git-for-windows/git/releases/latest' -Headers $headers -TimeoutSec 20
    $asset = $rel.assets | Where-Object { $_.name -match '64-bit\.exe$' } | Select-Object -First 1
    if (-not $asset) { throw 'Could not locate Git 64-bit installer asset.' }
    $exe = Join-Path $env:TEMP $asset.name
    Get-RemoteFile $asset.browser_download_url $exe
    Write-Step "Installing Git (silent)"
    Start-Process $exe -ArgumentList '/VERYSILENT /NORESTART /NOCANCEL /SP-' -Wait
    Remove-Item $exe -Force -ErrorAction SilentlyContinue
  } catch {
    throw "Automatic Git download failed: $($_.Exception.Message). Install Git manually from https://git-scm.com/download/win then rerun."
  }
}

function Ensure-Winget {
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    $script:HasWinget = $true
    Write-Ok "winget detected"
  } else {
    $script:HasWinget = $false
    Write-WarnMsg "winget not found. Will fall back to direct downloads for Git and Node.js."
    Write-WarnMsg "Tip: install/update 'App Installer' from Microsoft Store to enable winget."
  }
}

function Ensure-Git {
  if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Ok "Git already installed: $(git --version)"
    return
  }

  Write-Step "Installing Git for Windows"
  if ($script:HasWinget) {
    try {
      winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
    } catch {
      Write-WarnMsg "winget Git install failed, falling back to direct download..."
      Install-GitFromExe
    }
  } else {
    Install-GitFromExe
  }
  Refresh-UserPath

  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    $gitCmd = Get-ChildItem 'C:\Program Files\Git\cmd\git.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($gitCmd) {
      $gitDir = Split-Path $gitCmd.FullName
      if ($env:Path -notlike "*$gitDir*") { $env:Path += ";$gitDir" }
    }
  }

  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git installation finished, but git is still not found in PATH. Please reopen PowerShell and rerun the command."
  }

  Write-Ok "Git installed: $(git --version)"
}

function Ensure-Node {
  $hasNode = Get-Command node -ErrorAction SilentlyContinue
  $hasNpm = Get-Command npm -ErrorAction SilentlyContinue
  if ($hasNode -and $hasNpm) {
    Write-Ok "Node already installed: $(node --version) / npm $(npm --version)"
    return
  }

  Write-Step "Installing Node.js LTS"
  if ($script:HasWinget) {
    try {
      winget install --id OpenJS.NodeJS.LTS -e --source winget --accept-package-agreements --accept-source-agreements
    } catch {
      Write-WarnMsg "winget Node.js install failed, falling back to direct download..."
      Install-NodeFromMsi
    }
  } else {
    Install-NodeFromMsi
  }
  Refresh-UserPath

  if (-not (Get-Command node -ErrorAction SilentlyContinue) -or -not (Get-Command npm -ErrorAction SilentlyContinue)) {
    $nodeDirs = @(
      'C:\Program Files\nodejs',
      "$env:LOCALAPPDATA\Programs\nodejs"
    )
    foreach ($dir in $nodeDirs) {
      if (Test-Path $dir) {
        if ($env:Path -notlike "*$dir*") { $env:Path += ";$dir" }
      }
    }
  }

  if (-not (Get-Command node -ErrorAction SilentlyContinue) -or -not (Get-Command npm -ErrorAction SilentlyContinue)) {
    throw "Node.js installation finished, but node/npm are still not found in PATH. Please reopen PowerShell and rerun the command."
  }

  Write-Ok "Node installed: $(node --version) / npm $(npm --version)"
}

function Ensure-ClaudeCode {
  if (Get-Command claude -ErrorAction SilentlyContinue) {
    try {
      $ver = claude --version 2>$null
      Write-Ok "Claude Code already installed: $ver"
    } catch {
      Write-Ok "Claude Code command already present"
    }
    return
  }

  Write-Step "Installing Claude Code"
  npm install -g @anthropic-ai/claude-code
  Refresh-UserPath

  $npmPrefix = npm config get prefix
  $candidates = @(
    $npmPrefix,
    (Join-Path $env:APPDATA 'npm')
  ) | Select-Object -Unique

  foreach ($dir in $candidates) {
    if ($dir -and (Test-Path $dir)) {
      if ($env:Path -notlike "*$dir*") { $env:Path += ";$dir" }
    }
  }

  if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    throw "Claude Code installed, but 'claude' is still not found. Please open a new PowerShell window and run: claude --version"
  }

  try {
    $ver = claude --version 2>$null
    Write-Ok "Claude Code installed: $ver"
  } catch {
    Write-Ok "Claude Code installed"
  }
}

function Set-CrazyrouterEnv($token) {
  Write-Step "Saving Crazyrouter environment variables"

  [Environment]::SetEnvironmentVariable('OPENAI_API_KEY', $token, 'User')
  [Environment]::SetEnvironmentVariable('OPENAI_BASE_URL', 'https://cn.crazyrouter.com/v1', 'User')
  [Environment]::SetEnvironmentVariable('ANTHROPIC_AUTH_TOKEN', $token, 'User')
  [Environment]::SetEnvironmentVariable('ANTHROPIC_BASE_URL', 'https://cn.crazyrouter.com', 'User')
  [Environment]::SetEnvironmentVariable('ANTHROPIC_MODEL', 'claude-opus-4-8', 'User')
  [Environment]::SetEnvironmentVariable('CLAUDE_MODEL', 'claude-opus-4-8', 'User')

  $env:OPENAI_API_KEY = $token
  $env:OPENAI_BASE_URL = 'https://cn.crazyrouter.com/v1'
  $env:ANTHROPIC_AUTH_TOKEN = $token
  $env:ANTHROPIC_BASE_URL = 'https://cn.crazyrouter.com'
  $env:ANTHROPIC_MODEL = 'claude-opus-4-8'
  $env:CLAUDE_MODEL = 'claude-opus-4-8'

  Write-Ok "Crazyrouter token saved for current user"
}

function Ensure-TestRepo {
  $repoPath = Join-Path $HOME 'Projects\claude-code-test'
  if (-not (Test-Path $repoPath)) {
    New-Item -ItemType Directory -Path $repoPath -Force | Out-Null
  }
  Push-Location $repoPath
  if (-not (Test-Path (Join-Path $repoPath '.git'))) {
    git init | Out-Null
    Write-Ok "Created test repo at $repoPath"
  } else {
    Write-Ok "Test repo exists at $repoPath"
  }
  Pop-Location
  return $repoPath
}

function Show-NextSteps($repoPath) {
  Write-Host "`n========================================" -ForegroundColor Cyan
  Write-Host "Claude Code + Crazyrouter setup complete" -ForegroundColor Cyan
  Write-Host "========================================`n" -ForegroundColor Cyan

  Write-Host "Installed / configured:" -ForegroundColor White
  Write-Host "- Git" -ForegroundColor Gray
  Write-Host "- Node.js + npm" -ForegroundColor Gray
  Write-Host "- Claude Code" -ForegroundColor Gray
  Write-Host "- Crazyrouter token + base URL" -ForegroundColor Gray
  Write-Host ""
  Write-Host "Next steps:" -ForegroundColor White
  Write-Host "1. Open a NEW PowerShell window" -ForegroundColor Gray
  Write-Host "2. Run: claude --version" -ForegroundColor Gray
  Write-Host "3. Run:" -ForegroundColor Gray
  Write-Host "   cd \"$repoPath\"" -ForegroundColor DarkGray
  Write-Host "   claude" -ForegroundColor DarkGray
  Write-Host ""
  Write-Host "Saved env vars:" -ForegroundColor White
  Write-Host "- OPENAI_API_KEY" -ForegroundColor Gray
  Write-Host "- OPENAI_BASE_URL=https://cn.crazyrouter.com/v1" -ForegroundColor Gray
  Write-Host "- ANTHROPIC_AUTH_TOKEN" -ForegroundColor Gray
  Write-Host "- ANTHROPIC_BASE_URL=https://cn.crazyrouter.com" -ForegroundColor Gray
  Write-Host "- ANTHROPIC_MODEL=claude-opus-4-8" -ForegroundColor Gray
  Write-Host "- CLAUDE_MODEL=claude-opus-4-8" -ForegroundColor Gray
}

try {
  Write-Host "Claude Code + Crazyrouter Windows one-click installer" -ForegroundColor White
  Write-Host "This script installs Git, Node.js, Claude Code, and saves your Crazyrouter token." -ForegroundColor Gray

  Write-Step "Checking Windows package manager"
  Ensure-Winget

  Write-Step "Checking / installing Git"
  Ensure-Git

  Write-Step "Checking / installing Node.js"
  Ensure-Node

  Write-Step "Checking / installing Claude Code"
  Ensure-ClaudeCode

  Write-Step "Enter your Crazyrouter token"
  $secure = Read-Host 'Paste your Crazyrouter token (input hidden)' -AsSecureString
  $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
  $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
  if ([string]::IsNullOrWhiteSpace($token)) {
    throw 'No token entered. Aborting.'
  }

  if ($token -notmatch '^sk-|^cr-|^rk-') {
    Write-WarnMsg "Token format looks unusual. Continuing anyway."
  }

  Set-CrazyrouterEnv $token
  $repoPath = Ensure-TestRepo
  Show-NextSteps $repoPath
}
catch {
  Write-Host "`n[ERROR] $($_.Exception.Message)" -ForegroundColor Red
  exit 1
}
