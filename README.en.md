<div align="center">

# Claude Code × Crazyrouter

<!-- crazyrouter-links -->
> - 📖 **Full Claude Code integration guide (manual config, base URL rules, recommended models, FAQ)**: https://crazyrouter.com/en/integrations/claude-code?utm_source=github&utm_medium=readme&utm_campaign=claude-code
> - 🧩 **Every Claude model with live prices**: https://crazyrouter.com/en/models/anthropic?utm_source=github&utm_medium=readme&utm_campaign=claude-code
> - 💰 **Model price comparison (list vs Azure / Bedrock / Vertex vs Crazyrouter, verified daily)**: https://crazyrouter.com/en/pricing?utm_source=github&utm_medium=readme&utm_campaign=claude-code
> - 🗂 **All models by vendor**: https://crazyrouter.com/en/models?utm_source=github&utm_medium=readme&utm_campaign=claude-code

**One API key for Claude, GPT, Gemini, and DeepSeek.**

Point [Claude Code](https://docs.anthropic.com/en/docs/claude-code) at [Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) — no separate Anthropic account required.

[![License: MIT](https://img.shields.io/badge/License-MIT-22c55e.svg?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-3b82f6?style=flat-square)](#which-one-are-you)
[![Claude Code](https://img.shields.io/badge/for-Claude%20Code-d97757?style=flat-square)](https://docs.anthropic.com/en/docs/claude-code)
[![Crazyrouter](https://img.shields.io/badge/gateway-Crazyrouter-8b5cf6?style=flat-square)](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo)

[中文](README.md) · English · [Русский](README.ru.md) · [日本語](README.ja.md)

</div>

> ℹ️ All script prompts and logs are in **English** / 脚本提示均为**英文** / Все подсказки на **английском** / スクリプトの表示は**英語**です。

---

## Which one are you?

This repo ships two scripts for two kinds of users. Find your row, then copy the matching command:

| Your situation | Script to use | What it does |
| --- | --- | --- |
| **Claude Code already installed**, you just want to point it at Crazyrouter | `configure` (recommended) | Writes only the token and base URL. Takes seconds, **does not touch your Claude Code** |
| **Claude Code not installed yet**, you want everything in one go | `setup` | Installs Git + Node.js + Claude Code, then writes the Crazyrouter config |

> Not sure if it is installed? Run `claude --version`. A version number means use `configure`; "command not found" means use `setup`.

Before you start, grab a **Crazyrouter API key**: <https://cn.crazyrouter.com>

---

## Option 1 — Claude Code installed: configure only (recommended)

Writes the base URL and token. Installs and reinstalls nothing.

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-configure.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh
bash /tmp/crazyrouter-configure.sh
```

One-liner (the command must end with `bash`, not just `|`):

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex
```

### The script asks three questions (press Enter to accept the defaults)

| Prompt | Default | Notes |
| --- | --- | --- |
| Crazyrouter token | none (required) | Input is hidden; it never shows on screen |
| Base URL | `https://cn.crazyrouter.com` | Usually leave as is |
| Default Claude model | `claude-opus-4-8` | Can be changed to a supported model below |

---

## Option 2 — Claude Code not installed: full install

Installs Git, Node.js, and Claude Code, then writes the Crazyrouter config.

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-setup.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh
bash /tmp/crazyrouter-setup.sh
```

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex
```

---

## Verify after it runs

**Make the config take effect**, then run `claude`:

- **Windows**: close the current PowerShell and **open a new window** (env vars only apply to new windows).
- **macOS / Linux**: the script wrote the config to `~/.crazyrouter-claude-code.env` and added an auto-load line to your shell startup file. **Open a new terminal**, or run `source ~/.crazyrouter-claude-code.env` in the current one.

```bash
claude --version   # shows a version number
claude             # opens normally and routes through Crazyrouter
```

> `claude: command not found` in the old window is expected — the config only applies in a new window or after `source`.

---

## What the scripts actually change

Both scripts write these six user-level environment variables. Both `ANTHROPIC_*` and `OPENAI_*` are set so the same token works for Claude Code and for other OpenAI-compatible coding tools.

```bash
# For Claude Code (Anthropic-style)
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=<your token>
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8

# For other tools (OpenAI-compatible)
OPENAI_API_KEY=<your token>
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

> ⚠️ When calling the API from code, use the clean URL `https://cn.crazyrouter.com/v1` — never one with `?utm_source=...`.

---

## Prefer not to run a script? Configure manually

Same result as the scripts. Set the variables, then open a new window.

### macOS / Linux

Add to `~/.zshrc`, `~/.bashrc`, or `~/.profile`:

```bash
export ANTHROPIC_BASE_URL="https://cn.crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="your_token"
export OPENAI_API_KEY="your_token"
export OPENAI_BASE_URL="https://cn.crazyrouter.com/v1"
export ANTHROPIC_MODEL="claude-opus-4-8"
export CLAUDE_MODEL="claude-opus-4-8"
```

```bash
source ~/.zshrc   # if you use zsh
claude
```

### Windows PowerShell

```powershell
[Environment]::SetEnvironmentVariable('ANTHROPIC_BASE_URL', 'https://cn.crazyrouter.com', 'User')
[Environment]::SetEnvironmentVariable('ANTHROPIC_AUTH_TOKEN', 'your_token', 'User')
[Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'your_token', 'User')
[Environment]::SetEnvironmentVariable('OPENAI_BASE_URL', 'https://cn.crazyrouter.com/v1', 'User')
[Environment]::SetEnvironmentVariable('ANTHROPIC_MODEL', 'claude-opus-4-8', 'User')
[Environment]::SetEnvironmentVariable('CLAUDE_MODEL', 'claude-opus-4-8', 'User')
```

Open a new PowerShell window, then run `claude`.

---

## Optional: change the model

Default is `claude-opus-4-8`. To switch to another Claude model supported by Crazyrouter, change `CLAUDE_MODEL`:

```bash
CLAUDE_MODEL=claude-sonnet-4     # faster, cheaper
CLAUDE_MODEL=claude-haiku-4.5    # lightest
```

---

## Optional: server / unattended install

`configure.sh` supports a non-interactive mode. Pre-set the environment variables and the script stops prompting — ideal for `curl | bash` on Rocky/RHEL/CentOS servers:

```bash
export CRAZYROUTER_TOKEN="your_token"
export CRAZYROUTER_BASE_URL="https://cn.crazyrouter.com"   # optional
export CLAUDE_MODEL="claude-opus-4-8"                      # optional
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

> On servers, `curl | bash` often runs a non-login shell that cannot find an installed `claude`. The script auto-adds common npm global paths (`/usr/local/bin`, `~/.local/bin`, `~/.npm-global/bin`). Even if it still cannot find it, it writes the Crazyrouter config anyway and prints diagnostics with next steps.

---

## FAQ

**Q: `claude` is still not found after running.**
Env vars only apply to new windows. Close the terminal and open a new one.

**Q: Difference between `configure` and `setup`?**
`configure` only writes config and requires Claude Code to be installed already; `setup` installs Git / Node.js / Claude Code first, then writes config.

**Q: Do I need an Anthropic account or key?**
No. The whole point is to run Claude Code with a single Crazyrouter token.

**Q: Why set both `ANTHROPIC_*` and `OPENAI_*`?**
Claude Code reads Anthropic-style variables; many other coding tools read OpenAI-compatible ones. Set both and one token covers everything.

**Q: Is this the official Claude Code project?**
No. Claude Code is Anthropic's CLI tool. This repo just helps you point it at Crazyrouter faster.

---

## Repository structure

```text
crazyrouter-claude-code/
├── README.md              # Chinese
├── README.en.md           # English (this file)
├── README.ru.md           # Russian
├── README.ja.md           # Japanese
├── .env.example           # environment variable example
├── configure.sh           # macOS / Linux: configure only
├── setup.sh               # macOS / Linux: full install + config
└── windows/
    ├── configure.ps1      # Windows: configure only
    └── setup.ps1          # Windows: full install + config
```

---

## Links

- 🌐 Website: <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 API docs: <https://docs.crazyrouter.com>
- 💬 Telegram: <https://t.me/crzrouter>
- 🐦 Twitter / X: <https://twitter.com/metaviiii>

---

## License

MIT License — see [LICENSE](LICENSE).
