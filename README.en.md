# 🚀 One-Command Claude Code Setup with Crazyrouter

> Configure Claude Code to use Crazyrouter with one command. Users only need a Crazyrouter API key.

[Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) is an AI API gateway. With one API key, you can access Claude, GPT, Gemini, DeepSeek, and many other models through a unified interface.

This repository helps users:

- install **Claude Code**
- configure Claude Code to use **Crazyrouter**
- save the required environment variables automatically
- start using Claude Code with minimal setup

---

## ⚡ One-command install

### Windows PowerShell

Copy and run:

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex"
```

Short version:

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex
```

The script will:

- install Git if needed
- install Node.js LTS if needed
- install Claude Code
- ask for your Crazyrouter API key
- save environment variables
- create a test workspace

---

### macOS / Linux

Copy and run:

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh | bash
```

The script will:

- install Git if needed
- install Node.js if needed
- install Claude Code
- ask for your Crazyrouter API key
- write environment variables to your shell profile

---

## 🔑 What do I need?

You only need:

- a **Crazyrouter API key / token**

Get one here:

- <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>

After running the installer, paste your token when prompted.

---

## 🧩 What environment variables are configured?

The installer writes both Anthropic-style and OpenAI-compatible variables for better tool compatibility.

### Anthropic-style variables

```bash
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=your_token
```

### OpenAI-compatible variables

```bash
OPENAI_API_KEY=your_token
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

Why both?

- Claude Code can use Anthropic-style settings.
- Other AI coding tools often use OpenAI-compatible settings.
- Saving both reduces setup friction for users.

> Important: API endpoints should not include UTM parameters. Use `https://cn.crazyrouter.com/v1`, not a URL with `?utm_source=...`.

---

## ✅ Verify installation

After installation, open a **new terminal window** and run:

```bash
claude --version
```

Then go into any project folder and run:

```bash
claude
```

If Claude Code starts normally, the setup is complete.

---

## 📦 Manual install

If you do not want to run a remote script, clone this repository and run the installer locally.

### Windows

```powershell
git clone https://github.com/xujfcn/crazyrouter-claude-code.git
cd crazyrouter-claude-code
powershell -ExecutionPolicy Bypass -File .\windows\setup.ps1
```

### macOS / Linux

```bash
git clone https://github.com/xujfcn/crazyrouter-claude-code.git
cd crazyrouter-claude-code
chmod +x setup.sh
./setup.sh
```

---

## 📁 Repository structure

```text
crazyrouter-claude-code/
├── README.md            # Chinese README
├── README.en.md         # English README
├── .env.example         # environment variable example
├── setup.sh             # macOS / Linux setup script
└── windows/
    └── setup.ps1        # Windows PowerShell setup script
```

---

## ❓ FAQ

### Is this the official Claude Code project?

No.

Claude Code is Anthropic's CLI tool. This repository simply helps users install Claude Code and configure it to use Crazyrouter faster.

### Do I need an Anthropic API key?

No.

The goal of this repository is to let users configure Claude Code with a Crazyrouter token.

### Will this break my existing Claude Code setup?

The script mainly installs tools and writes environment variables. If you already have a custom setup, review the script before running it.

### Why does the script set both `ANTHROPIC_*` and `OPENAI_*` variables?

Different AI coding tools read different environment variable names. Setting both improves compatibility and makes it easier to reuse the same Crazyrouter token across tools.

### What model name should I use?

The installer sets `claude-opus-4-8` by default. You can override the model later through environment variables.

Examples:

```bash
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-sonnet-4
CLAUDE_MODEL=claude-haiku-4.5
```

Check Crazyrouter's model list before using a model in production.

---

## 🔗 Links

- 🌐 Crazyrouter: <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 API docs: <https://docs.crazyrouter.com>
- 💬 Telegram: <https://t.me/crzrouter>
- 🐦 Twitter / X: <https://twitter.com/metaviiii>

---

## 📄 License

MIT License — see [LICENSE](LICENSE).
