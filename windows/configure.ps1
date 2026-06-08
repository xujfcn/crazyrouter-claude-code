# Crazyrouter Claude Code config-only setup for Windows users who already installed Claude Code.
# Usage:
#   powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex"
# Short:
#   irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex

$ErrorActionPreference = 'Stop'

function Write-Step($msg) {
  Write-Host "`n==> $msg" -ForegroundColor Cyan
}

function Write-Ok($msg) {
  Write-Host "[OK] $msg" -ForegroundColor Green
}

function Write-WarnMsg($msg) {
  Write-Host "[WARN] $msg" -ForegroundColor Yellow
}

function Test-ClaudeCode {
  if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    throw "Claude Code was not found in PATH. This lightweight script is for users who already installed Claude Code. Install Claude Code first, then rerun. Official docs: https://docs.anthropic.com/en/docs/claude-code"
  }

  try {
    $ver = claude --version 2>$null
    Write-Ok "Claude Code detected: $ver"
  } catch {
    Write-Ok "Claude Code command detected"
  }
}

function Set-CrazyrouterEnv($token, $baseUrl, $model) {
  $baseUrl = $baseUrl.TrimEnd('/')

  [Environment]::SetEnvironmentVariable('ANTHROPIC_BASE_URL', $baseUrl, 'User')
  [Environment]::SetEnvironmentVariable('ANTHROPIC_AUTH_TOKEN', $token, 'User')
  [Environment]::SetEnvironmentVariable('OPENAI_API_KEY', $token, 'User')
  [Environment]::SetEnvironmentVariable('OPENAI_BASE_URL', "$baseUrl/v1", 'User')
  [Environment]::SetEnvironmentVariable('ANTHROPIC_MODEL', $model, 'User')
  [Environment]::SetEnvironmentVariable('CLAUDE_MODEL', $model, 'User')

  $env:ANTHROPIC_BASE_URL = $baseUrl
  $env:ANTHROPIC_AUTH_TOKEN = $token
  $env:OPENAI_API_KEY = $token
  $env:OPENAI_BASE_URL = "$baseUrl/v1"
  $env:ANTHROPIC_MODEL = $model
  $env:CLAUDE_MODEL = $model
}

try {
  Write-Host "⚡ Crazyrouter config for existing Claude Code" -ForegroundColor White
  Write-Host "This script does NOT install Claude Code. It only configures base URL + token." -ForegroundColor Gray

  Test-ClaudeCode

  Write-Step "Enter your Crazyrouter token"
  $secure = Read-Host 'Paste your Crazyrouter token (input hidden)' -AsSecureString
  $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
  $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
  [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)

  if ([string]::IsNullOrWhiteSpace($token)) {
    throw 'No token entered. Get one at https://cn.crazyrouter.com'
  }

  if ($token -notmatch '^sk-|^cr-|^rk-') {
    Write-WarnMsg "Token format looks unusual. Continuing anyway."
  }

  $baseUrl = Read-Host 'Base URL [https://cn.crazyrouter.com]'
  if ([string]::IsNullOrWhiteSpace($baseUrl)) { $baseUrl = 'https://cn.crazyrouter.com' }
  $baseUrl = $baseUrl.TrimEnd('/')

  $model = Read-Host 'Default Claude model [claude-opus-4-8]'
  if ([string]::IsNullOrWhiteSpace($model)) { $model = 'claude-opus-4-8' }

  Write-Step "Saving user environment variables"
  Set-CrazyrouterEnv $token $baseUrl $model

  Write-Host "`n========================================" -ForegroundColor Cyan
  Write-Host "Crazyrouter Claude Code config complete" -ForegroundColor Cyan
  Write-Host "========================================`n" -ForegroundColor Cyan

  Write-Host "Next steps:" -ForegroundColor White
  Write-Host "1. Open a NEW PowerShell window" -ForegroundColor Gray
  Write-Host "2. Run: claude" -ForegroundColor Gray
  Write-Host ""
  Write-Host "Saved env vars:" -ForegroundColor White
  Write-Host "- ANTHROPIC_BASE_URL=$baseUrl" -ForegroundColor Gray
  Write-Host "- ANTHROPIC_AUTH_TOKEN=<your token>" -ForegroundColor Gray
  Write-Host "- OPENAI_BASE_URL=$baseUrl/v1" -ForegroundColor Gray
  Write-Host "- OPENAI_API_KEY=<your token>" -ForegroundColor Gray
  Write-Host "- ANTHROPIC_MODEL=$model" -ForegroundColor Gray
  Write-Host "- CLAUDE_MODEL=$model" -ForegroundColor Gray
}
catch {
  Write-Host "`n[ERROR] $($_.Exception.Message)" -ForegroundColor Red
  exit 1
}
