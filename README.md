# 🚀 Use Claude Code with Crazyrouter

> **Save 45% on Claude API costs** — Use Claude Code through Crazyrouter's OpenAI-compatible API gateway.

[Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=dev_community?ref=github) is an AI API gateway that gives you access to all major models (Claude, GPT, Gemini, etc.) through a single API key — at significantly lower prices.

## 💰 Price Comparison

| Model | Official Price (Input/Output) | Crazyrouter Price | Savings |
|-------|-------------------------------|-------------------|---------|
| Claude Opus 4 | $15 / $75 per 1M tokens | $8.25 / $41.25 | **45%** |
| Claude Sonnet 4 | $3 / $15 per 1M tokens | $1.65 / $8.25 | **45%** |
| Claude Haiku 3.5 | $0.80 / $4 per 1M tokens | $0.44 / $2.20 | **45%** |

## ⚡ Quick Start (3 Steps)

### 1. Get your Crazyrouter API key

Sign up at [crazyrouter.com](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=dev_community?ref=github) and grab your API key.

### 2. Set environment variables

```bash
export ANTHROPIC_BASE_URL=https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=dev_community
export ANTHROPIC_API_KEY=sk-your-crazyrouter-key
```

Or add to your shell profile (`~/.bashrc`, `~/.zshrc`):

```bash
echo 'export ANTHROPIC_BASE_URL=https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=dev_community' >> ~/.zshrc
echo 'export ANTHROPIC_API_KEY=sk-your-crazyrouter-key' >> ~/.zshrc
source ~/.zshrc
```

### 3. Use Claude Code as normal

```bash
claude
```

That's it! Claude Code will now route through Crazyrouter automatically.

## 🔧 One-Click Setup Script

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh | bash
```

Or clone and run:

```bash
git clone https://github.com/xujfcn/crazyrouter-claude-code.git
cd crazyrouter-claude-code
chmod +x setup.sh
./setup.sh
```

## 📋 Detailed Configuration

### Method 1: Environment Variables (Recommended)

```bash
# Required
export ANTHROPIC_BASE_URL=https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=dev_community
export ANTHROPIC_API_KEY=sk-your-crazyrouter-key

# Optional: Set default model
export CLAUDE_MODEL=claude-sonnet-4-20250514
```

### Method 2: Claude Code Settings

Run `claude` and use `/config` to set:

```
API Base URL: https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=dev_community
API Key: sk-your-crazyrouter-key
```

### Available Models

| Model ID | Description |
|----------|-------------|
| `claude-opus-4-20250514` | Most capable, best for complex tasks |
| `claude-sonnet-4-20250514` | Balanced performance and cost |
| `claude-haiku-3-5-20241022` | Fastest, most affordable |

## ❓ FAQ

**Q: Is Crazyrouter compatible with Claude Code?**
A: Yes, 100% compatible. Crazyrouter provides an Anthropic-compatible API endpoint.

**Q: Will I lose any features?**
A: No. All Claude Code features work exactly the same — streaming, tool use, file editing, etc.

**Q: How does Crazyrouter offer lower prices?**
A: Crazyrouter aggregates API usage across users and passes volume discounts to you.

**Q: Can I use other models too?**
A: Yes! With a single Crazyrouter key, you can access GPT-4o, Gemini, Llama, and 200+ other models.

**Q: Is my data safe?**
A: Crazyrouter does not store or log your prompts or completions. All traffic is encrypted via HTTPS.

## 🔗 Links

- 🌐 [Crazyrouter Website](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=dev_community?ref=github)
- 📖 [API Documentation](https://crazyrouter.com/docs?ref=github&utm_source=github&utm_medium=github&utm_campaign=dev_community)
- 💬 [Telegram Community](https://t.me/crazyrouter)
- 🐦 [Twitter @metaviiii](https://twitter.com/metaviiii)

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.
