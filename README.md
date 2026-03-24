# 🚀 Use Claude Code with Crazyrouter

> **Use Claude Code with one Crazyrouter token** — lower cost, one API key, simple setup.

[Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) is an AI API gateway that gives you access to Claude, GPT, Gemini, DeepSeek, and many other models through a single API key.

This repo is for one thing:

- install **Claude Code** fast
- configure it to use **Crazyrouter**
- let the user paste **one token** and start using it

---

## ⚡ One-Click Install

### Windows PowerShell

Copy and run:

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex"
```

Short version:

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex
```

What it does:
- installs Git
- installs Node.js LTS
- installs Claude Code
- asks for your Crazyrouter token
- saves environment variables automatically
- creates a small test repo

---

### macOS / Linux

Copy and run:

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh | bash
```

What it does:
- installs Node.js if needed
- installs Claude Code
- asks for your Crazyrouter token
- saves environment variables into your shell profile

---

## 💡 What token do I need?

You only need a **Crazyrouter API key**.

Get one here:
- <https://crazyrouter.com>

The installer will ask you to paste it.

---

## 🔧 Environment Variables Used

The installers save both Anthropic-style and OpenAI-style variables.

### Anthropic-style
```bash
ANTHROPIC_BASE_URL=https://crazyrouter.com
ANTHROPIC_AUTH_TOKEN=your_token
```

### OpenAI-style
```bash
OPENAI_API_KEY=your_token
OPENAI_BASE_URL=https://crazyrouter.com/v1
```

This makes the setup more flexible for Claude Code and other coding tools.

---

## ✅ After Installation

Open a **new terminal** and test:

```bash
claude --version
```

Then inside a project:

```bash
claude
```

---

## 📦 Manual Setup (if you do not want remote-exec)

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

## ❓ FAQ

### Is this officially Claude Code?
No. Claude Code itself is published by Anthropic. This repo is an installer/config helper that sets Claude Code up to use Crazyrouter.

### Do I need an Anthropic key?
No. The goal here is to let you use a **Crazyrouter token only**.

### Does this also work for other tools?
Yes. Because the installer also saves OpenAI-compatible variables, it can help with other AI coding tools too.

### Why both `ANTHROPIC_*` and `OPENAI_*` vars?
Different tools expect different naming. Saving both reduces setup friction.

---

## 🔗 Links

- 🌐 [Crazyrouter Website](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo)
- 📖 [API Documentation](https://docs.crazyrouter.com)
- 💬 [Telegram Community](https://t.me/crzrouter)
- 🐦 [Twitter @metaviiii](https://twitter.com/metaviiii)

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.
