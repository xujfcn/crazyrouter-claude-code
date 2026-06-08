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

CLAUDE_BIN=""
CLAUDE_BIN_DIR=""

load_shell_profiles() {
  # Interactive shells often define PATH in these files. curl | bash does not load them.
  # Source them best-effort so aliases/PATH managed by npm/nvm/fnm can become visible.
  for rc in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile" "$HOME/.zshrc"; do
    [ -f "$rc" ] || continue
    # shellcheck disable=SC1090
    . "$rc" >/dev/null 2>&1 || true
  done
}

add_common_paths() {
  load_shell_profiles
  # curl | bash runs a non-login shell on many Linux servers, so user PATH may be incomplete.
  # Add common npm/global install locations before checking for Claude Code.
  local npm_prefix=""
  if command -v npm >/dev/null 2>&1; then
    npm_prefix="$(npm config get prefix 2>/dev/null || true)"
  fi

  for dir in \
    "$HOME/.npm-global/bin" \
    "$HOME/.npm/bin" \
    "$HOME/.local/bin" \
    "$HOME/bin" \
    "/usr/local/bin" \
    "/usr/bin" \
    ${npm_prefix:+"$npm_prefix/bin"} \
    ${npm_prefix:+"$npm_prefix"}
  do
    [ -n "$dir" ] || continue
    [ -d "$dir" ] || continue
    case ":$PATH:" in
      *":$dir:"*) ;;
      *) export PATH="$dir:$PATH" ;;
    esac
  done
}

find_claude_binary() {
  add_common_paths

  if command -v claude >/dev/null 2>&1; then
    command -v claude
    return 0
  fi

  # Some npm installs create symlinks in locations that are not loaded by non-login shells.
  local candidates=""
  candidates="$candidates /usr/local/bin/claude /usr/bin/claude"
  candidates="$candidates $HOME/.npm-global/bin/claude $HOME/.npm/bin/claude $HOME/.local/bin/claude $HOME/bin/claude"

  if command -v npm >/dev/null 2>&1; then
    local npm_prefix
    npm_prefix="$(npm config get prefix 2>/dev/null || true)"
    if [ -n "$npm_prefix" ]; then
      candidates="$candidates $npm_prefix/bin/claude $npm_prefix/claude"
    fi
  fi

  for bin in $candidates; do
    if [ -x "$bin" ]; then
      export PATH="$(dirname "$bin"):$PATH"
      echo "$bin"
      return 0
    fi
  done

  return 1
}

ensure_claude() {
  local claude_bin
  if ! claude_bin="$(find_claude_binary)"; then
    warn "Claude Code was not found in this non-login shell. Continuing with Crazyrouter configuration anyway."
    echo ""
    echo "This can happen on Rocky/RHEL/CentOS or other servers when Claude Code works interactively"
    echo "but npm's global bin directory is not loaded by curl | bash."
    echo ""
    echo "Diagnostics:"
    echo "- OS: $(. /etc/os-release 2>/dev/null && echo "${PRETTY_NAME:-unknown}" || uname -a)"
    echo "- shell: ${SHELL:-unknown}"
    echo "- PATH: $PATH"
    if command -v npm >/dev/null 2>&1; then
      echo "- npm prefix: $(npm config get prefix 2>/dev/null || echo unknown)"
      echo "- npm global packages matching claude:"
      npm list -g --depth=0 2>/dev/null | grep -i claude || true
    else
      echo "- npm: not found"
    fi
    echo ""
    echo "The script will still save Crazyrouter variables. After it finishes, run:"
    echo "  source $(pick_shell_rc)"
    echo "  claude"
    echo ""
    echo "If Claude is still not found, use the full installer:"
    echo "  curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh | bash"
    CLAUDE_BIN=""
    CLAUDE_BIN_DIR=""
    return 0
  fi

  CLAUDE_BIN="$claude_bin"
  CLAUDE_BIN_DIR="$(dirname "$claude_bin")"
  ok "Claude Code detected: $($claude_bin --version 2>/dev/null || echo 'present')"
  ok "Claude Code path: $claude_bin"
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
# Keep npm/Claude Code global bin available for non-login shells if we detected it.
if [ -n "${CLAUDE_BIN_DIR:-}" ]; then
  case ":$PATH:" in
    *":$CLAUDE_BIN_DIR:"*) ;;
    *) export PATH="$CLAUDE_BIN_DIR:$PATH" ;;
  esac
fi
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
