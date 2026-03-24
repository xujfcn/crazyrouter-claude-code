#!/bin/bash
# Crazyrouter + Claude Code one-click setup for macOS / Linux
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh | bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

say() { echo -e "${CYAN}==> $1${NC}"; }
ok() { echo -e "${GREEN}[OK] $1${NC}"; }
warn() { echo -e "${YELLOW}[WARN] $1${NC}"; }

ensure_cmd() {
  command -v "$1" >/dev/null 2>&1
}

install_git() {
  if ensure_cmd git; then
    ok "Git already installed: $(git --version)"
    return
  fi

  say "Installing Git"

  if ensure_cmd brew; then
    brew install git
  elif ensure_cmd apt-get; then
    sudo apt-get update
    sudo apt-get install -y git
  elif ensure_cmd dnf; then
    sudo dnf install -y git
  elif ensure_cmd yum; then
    sudo yum install -y git
  else
    echo "❌ Could not auto-install Git. Please install Git manually, then rerun."
    exit 1
  fi

  ok "Git installed: $(git --version)"
}

install_node() {
  if ensure_cmd node && ensure_cmd npm; then
    ok "Node.js already installed: $(node --version) / npm $(npm --version)"
    return
  fi

  say "Installing Node.js"

  if ensure_cmd brew; then
    brew install node
  elif ensure_cmd apt-get; then
    sudo apt-get update
    sudo apt-get install -y nodejs npm
  elif ensure_cmd dnf; then
    sudo dnf install -y nodejs npm
  elif ensure_cmd yum; then
    sudo yum install -y nodejs npm
  else
    echo "❌ Could not auto-install Node.js. Please install Node.js 18+ manually, then rerun."
    exit 1
  fi

  ok "Node.js installed: $(node --version) / npm $(npm --version)"
}

install_claude() {
  if ensure_cmd claude; then
    ok "Claude Code already installed: $(claude --version 2>/dev/null || echo 'present')"
    return
  fi

  say "Installing Claude Code"
  npm install -g @anthropic-ai/claude-code

  if ! ensure_cmd claude; then
    export PATH="$PATH:$(npm config get prefix)/bin:$HOME/.npm-global/bin:$HOME/.local/bin"
  fi

  if ! ensure_cmd claude; then
    echo "❌ Claude Code installed, but 'claude' is still not found in PATH. Reopen terminal and run: claude --version"
    exit 1
  fi

  ok "Claude Code installed: $(claude --version 2>/dev/null || echo 'present')"
}

pick_shell_rc() {
  if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
    echo "$HOME/.zshrc"
  elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
    echo "$HOME/.bashrc"
  else
    echo "$HOME/.profile"
  fi
}

write_exports() {
  local shell_rc="$1"
  local api_key="$2"

  touch "$shell_rc"

  if grep -q "# >>> Crazyrouter Claude Code >>>" "$shell_rc" 2>/dev/null; then
    tmpfile=$(mktemp)
    awk '
      BEGIN { skip=0 }
      /# >>> Crazyrouter Claude Code >>>/ { skip=1; next }
      /# <<< Crazyrouter Claude Code <<</ { skip=0; next }
      skip==0 { print }
    ' "$shell_rc" > "$tmpfile"
    mv "$tmpfile" "$shell_rc"
  fi

  cat >> "$shell_rc" <<EOF

# >>> Crazyrouter Claude Code >>>
export ANTHROPIC_BASE_URL="https://crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="$api_key"
export OPENAI_API_KEY="$api_key"
export OPENAI_BASE_URL="https://crazyrouter.com/v1"
# <<< Crazyrouter Claude Code <<<
EOF
}

main() {
  echo "🚀 Claude Code + Crazyrouter One-Click Setup"
  echo ""
  echo "This script will:"
  echo "- Install Git (if needed)"
  echo "- Install Node.js (if needed)"
  echo "- Install Claude Code"
  echo "- Save your Crazyrouter token"
  echo "- Configure Claude Code-related environment variables"
  echo ""

  say "Enter your Crazyrouter token"
  read -r -p "Crazyrouter token: " API_KEY

  if [ -z "$API_KEY" ]; then
    echo "❌ No token provided. Get one at https://crazyrouter.com"
    exit 1
  fi

  if ! echo "$API_KEY" | grep -Eq '^(sk-|cr-|rk-)'; then
    warn "Token format looks unusual. Continuing anyway."
  fi

  install_git
  install_node
  install_claude

  SHELL_RC=$(pick_shell_rc)
  say "Saving configuration to $SHELL_RC"
  write_exports "$SHELL_RC" "$API_KEY"

  export ANTHROPIC_BASE_URL="https://crazyrouter.com"
  export ANTHROPIC_AUTH_TOKEN="$API_KEY"
  export OPENAI_API_KEY="$API_KEY"
  export OPENAI_BASE_URL="https://crazyrouter.com/v1"

  ok "Configuration saved"
  echo ""
  echo "Next steps:"
  echo "1. Run: source $SHELL_RC"
  echo "2. Run: claude --version"
  echo "3. Start using Claude Code normally: claude"
  echo ""
  echo "Saved variables:"
  echo "- ANTHROPIC_BASE_URL=https://crazyrouter.com"
  echo "- ANTHROPIC_AUTH_TOKEN=<your token>"
  echo "- OPENAI_API_KEY=<your token>"
  echo "- OPENAI_BASE_URL=https://crazyrouter.com/v1"
}

main "$@"
