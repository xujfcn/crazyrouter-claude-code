#!/bin/bash
# Crazyrouter Claude Code config-only setup for users who already installed Claude Code.
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

say() { echo -e "${CYAN}==> $1${NC}"; }
ok() { echo -e "${GREEN}[OK] $1${NC}"; }
warn() { echo -e "${YELLOW}[WARN] $1${NC}"; }

ensure_claude() {
  if ! command -v claude >/dev/null 2>&1; then
    echo "❌ Claude Code was not found in PATH."
    echo "This lightweight script is for users who already installed Claude Code."
    echo "Install Claude Code first, then rerun this script."
    echo "Official docs: https://docs.anthropic.com/en/docs/claude-code"
    exit 1
  fi
  ok "Claude Code detected: $(claude --version 2>/dev/null || echo 'present')"
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
  local base_url="${3:-https://cn.crazyrouter.com}"
  local model="${4:-claude-opus-4-8}"

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
export ANTHROPIC_BASE_URL="$base_url"
export ANTHROPIC_AUTH_TOKEN="$api_key"
export OPENAI_API_KEY="$api_key"
export OPENAI_BASE_URL="$base_url/v1"
export ANTHROPIC_MODEL="$model"
export CLAUDE_MODEL="$model"
# <<< Crazyrouter Claude Code <<<
EOF
}

main() {
  echo "⚡ Crazyrouter config for existing Claude Code"
  echo ""
  echo "This script does NOT install Claude Code. It only saves:"
  echo "- ANTHROPIC_BASE_URL"
  echo "- ANTHROPIC_AUTH_TOKEN"
  echo "- OPENAI_BASE_URL"
  echo "- OPENAI_API_KEY"
  echo "- default Claude model"
  echo ""

  ensure_claude

  say "Enter your Crazyrouter token"
  read -r -p "Crazyrouter token: " API_KEY

  if [ -z "$API_KEY" ]; then
    echo "❌ No token provided. Get one at https://cn.crazyrouter.com"
    exit 1
  fi

  if ! echo "$API_KEY" | grep -Eq '^(sk-|cr-|rk-)'; then
    warn "Token format looks unusual. Continuing anyway."
  fi

  read -r -p "Base URL [https://cn.crazyrouter.com]: " BASE_URL
  BASE_URL=${BASE_URL:-https://cn.crazyrouter.com}
  BASE_URL=${BASE_URL%/}

  read -r -p "Default Claude model [claude-opus-4-8]: " MODEL
  MODEL=${MODEL:-claude-opus-4-8}

  SHELL_RC=$(pick_shell_rc)
  say "Saving configuration to $SHELL_RC"
  write_exports "$SHELL_RC" "$API_KEY" "$BASE_URL" "$MODEL"

  export ANTHROPIC_BASE_URL="$BASE_URL"
  export ANTHROPIC_AUTH_TOKEN="$API_KEY"
  export OPENAI_API_KEY="$API_KEY"
  export OPENAI_BASE_URL="$BASE_URL/v1"
  export ANTHROPIC_MODEL="$MODEL"
  export CLAUDE_MODEL="$MODEL"

  ok "Configuration saved"
  echo ""
  echo "Next steps:"
  echo "1. Run: source $SHELL_RC"
  echo "2. Run: claude"
  echo ""
  echo "Saved variables:"
  echo "- ANTHROPIC_BASE_URL=$BASE_URL"
  echo "- ANTHROPIC_AUTH_TOKEN=<your token>"
  echo "- OPENAI_BASE_URL=$BASE_URL/v1"
  echo "- OPENAI_API_KEY=<your token>"
  echo "- ANTHROPIC_MODEL=$MODEL"
  echo "- CLAUDE_MODEL=$MODEL"
}

main "$@"
