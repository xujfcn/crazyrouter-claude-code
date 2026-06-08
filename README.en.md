# ⚡ Already Installed Claude Code? Configure Crazyrouter Base URL + Token Only

[中文说明](README.md) | English README

This repository provides a **lightweight Claude Code + Crazyrouter configuration tool**.

It is designed for users who already installed Claude Code. You do not need to reinstall Claude Code. You only need to point Claude Code to Crazyrouter and save your Crazyrouter token.

[Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) is an AI API gateway. With one API key, you can access Claude, GPT, Gemini, DeepSeek, and many other models.

---

## 🚀 Fastest path: configure only, no install

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-configure.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh
bash /tmp/crazyrouter-configure.sh
```

One-line version also works, but make sure the command ends with `| bash`, not just `|`:

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

The script checks that the `claude` command already exists. For Rocky Linux / RHEL / CentOS-style servers, it also loads common npm global paths such as `/usr/local/bin`, `~/.local/bin`, and `~/.npm-global/bin`, so `curl | bash` can find Claude Code even when a non-login shell has a minimal PATH.

Then it asks for:

- your Crazyrouter token
- base URL, default: `https://cn.crazyrouter.com`
- default Claude model, default: `claude-opus-4-8`

After it finishes, open a new terminal and run:

```bash
claude
```

---

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex"
```

Short version:

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex
```

After it finishes, open a new PowerShell window and run:

```powershell
claude
```

---

## 🔑 What do you need?

You only need:

- **Claude Code** already installed
- a **Crazyrouter API key / token**

Get a token here:

- <https://cn.crazyrouter.com>
- <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>

---

## 🧩 What does the script configure?

### Anthropic / Claude Code variables

```bash
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=your_token
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8
```

### OpenAI-compatible variables for other AI coding tools

```bash
OPENAI_API_KEY=your_token
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

Important: API endpoints should not include UTM parameters. Use `https://cn.crazyrouter.com/v1`, not a URL with `?utm_source=...`.

---

## 🛠️ Manual configuration

If you do not want to run a script, configure the variables manually.

### macOS / Linux

Add this to `~/.zshrc`, `~/.bashrc`, or `~/.profile`:

```bash
export ANTHROPIC_BASE_URL="https://cn.crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="your_token"
export OPENAI_API_KEY="your_token"
export OPENAI_BASE_URL="https://cn.crazyrouter.com/v1"
export ANTHROPIC_MODEL="claude-opus-4-8"
export CLAUDE_MODEL="claude-opus-4-8"
```

Then run:

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

Then open a new PowerShell window:

```powershell
claude
```

---

## ✅ Verify

```bash
claude --version
claude
```

If Claude Code starts normally and requests go through Crazyrouter, the setup is done.

---

## 📦 If Claude Code is not installed yet

This repository still includes full one-click installers. They install Git, Node.js, Claude Code, and then configure Crazyrouter.

### macOS / Linux full install

```bash
curl -fsSL -o /tmp/crazyrouter-setup.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh
bash /tmp/crazyrouter-setup.sh
```

### Windows full install

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex"
```

---

## 📁 Repository structure

```text
crazyrouter-claude-code/
├── README.md              # Chinese README
├── README.en.md           # English README
├── .env.example           # environment variable example
├── configure.sh           # macOS / Linux: configure only, no install
├── setup.sh               # macOS / Linux: full install + config
└── windows/
    ├── configure.ps1      # Windows: configure only, no install
    └── setup.ps1          # Windows: full install + config
```

---

## ❓ FAQ

### Does this repository install Claude Code?

The recommended `configure.sh` / `configure.ps1` scripts do **not** install Claude Code. They are for users who already installed Claude Code.

If you have not installed Claude Code yet, use `setup.sh` / `setup.ps1`.

### Do I need an Anthropic API key?

No. The goal is to configure Claude Code with your Crazyrouter token.

### Why set both `ANTHROPIC_*` and `OPENAI_*` variables?

Claude Code commonly uses Anthropic-style settings. Other AI coding tools often use OpenAI-compatible settings. Saving both makes the same Crazyrouter token reusable.

### What is the default model?

Default: `claude-opus-4-8`.

You can change it to another Claude model supported by Crazyrouter, for example:

```bash
CLAUDE_MODEL=claude-sonnet-4
CLAUDE_MODEL=claude-haiku-4.5
```

### Is this the official Claude Code project?

No. Claude Code is Anthropic's CLI tool. This repository only helps users configure an existing Claude Code installation to use Crazyrouter faster.

---

## 🔗 Links

- 🌐 Crazyrouter: <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 API docs: <https://docs.crazyrouter.com>
- 💬 Telegram: <https://t.me/crzrouter>
- 🐦 Twitter / X: <https://twitter.com/metaviiii>

---

## 📄 License

MIT License — see [LICENSE](LICENSE).
