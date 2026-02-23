#!/bin/bash
# Crazyrouter + Claude Code Setup Script
# Usage: curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh | bash

set -e

echo "🚀 Crazyrouter + Claude Code Setup"
echo "===================================="
echo ""

# Detect shell
SHELL_RC=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.profile"
fi

echo "Detected shell config: $SHELL_RC"
echo ""

# Get API key
read -p "Enter your Crazyrouter API key (sk-...): " API_KEY

if [ -z "$API_KEY" ]; then
    echo "❌ No API key provided. Get one at https://crazyrouter.com"
    exit 1
fi

# Write config
echo "" >> "$SHELL_RC"
echo "# Crazyrouter Configuration (Claude Code)" >> "$SHELL_RC"
echo "export ANTHROPIC_BASE_URL=https://crazyrouter.com" >> "$SHELL_RC"
echo "export ANTHROPIC_API_KEY=$API_KEY" >> "$SHELL_RC"

# Apply
export ANTHROPIC_BASE_URL=https://crazyrouter.com
export ANTHROPIC_API_KEY=$API_KEY

echo ""
echo "✅ Configuration saved to $SHELL_RC"
echo ""
echo "Run 'source $SHELL_RC' or open a new terminal, then use 'claude' as normal."
echo ""
echo "💰 You're now saving 45% on Claude API costs!"
echo "📖 More info: https://crazyrouter.com?ref=github"
