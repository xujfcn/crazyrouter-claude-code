# ⚡ 已安装 Claude Code？只需配置 Crazyrouter 地址和 Token

[English README](README.en.md) | 中文说明

这个仓库提供一个**简化版 Claude Code + Crazyrouter 配置工具**。

适合已经安装好 Claude Code 的用户：不用重装 Claude Code，只需要把 Claude Code 的接入地址改成 Crazyrouter，并保存你的 Crazyrouter Token。

[Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) 是 AI API 网关。你可以用一个 API Key 访问 Claude、GPT、Gemini、DeepSeek 等多种模型。

---

## 🚀 最快用法：只配置，不安装

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-configure.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh
bash /tmp/crazyrouter-configure.sh
```

也可以用一行版，但注意最后必须有 `bash`，不要只输入到 `|`：

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

脚本会检查本机是否已有 `claude` 命令。针对 Rocky Linux / RHEL / CentOS 这类服务器，脚本会额外加载常见 npm 全局路径，例如 `/usr/local/bin`、`~/.local/bin`、`~/.npm-global/bin`，避免 `curl | bash` 非登录 shell 找不到已安装的 Claude Code。

然后提示你输入：

- Crazyrouter Token
- Base URL，默认：`https://cn.crazyrouter.com`
- 默认 Claude 模型，默认：`claude-opus-4-8`

完成后打开新终端，运行：

```bash
claude
```

---

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex"
```

短写：

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex
```

完成后打开新的 PowerShell，运行：

```powershell
claude
```

---

## 🔑 你需要准备什么？

只需要：

- 已安装好的 **Claude Code**
- 一个 **Crazyrouter API Key / Token**

获取 Token：

- <https://cn.crazyrouter.com>
- <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>

---

## 🧩 脚本会配置什么？

### Anthropic / Claude Code 相关变量

```bash
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=你的_token
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8
```

### OpenAI 兼容变量，方便其他 AI Coding Tools 复用

```bash
OPENAI_API_KEY=你的_token
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

注意：代码里的 API endpoint 不要加 UTM 参数。应该使用 `https://cn.crazyrouter.com/v1`，不要使用带 `?utm_source=...` 的 URL。

---

## 🛠️ 手动配置

如果不想运行脚本，也可以手动配置。

### macOS / Linux

把下面内容加入 `~/.zshrc`、`~/.bashrc` 或 `~/.profile`：

```bash
export ANTHROPIC_BASE_URL="https://cn.crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="你的_token"
export OPENAI_API_KEY="你的_token"
export OPENAI_BASE_URL="https://cn.crazyrouter.com/v1"
export ANTHROPIC_MODEL="claude-opus-4-8"
export CLAUDE_MODEL="claude-opus-4-8"
```

然后执行：

```bash
source ~/.zshrc   # 如果你用 zsh
claude
```

### Windows PowerShell

```powershell
[Environment]::SetEnvironmentVariable('ANTHROPIC_BASE_URL', 'https://cn.crazyrouter.com', 'User')
[Environment]::SetEnvironmentVariable('ANTHROPIC_AUTH_TOKEN', '你的_token', 'User')
[Environment]::SetEnvironmentVariable('OPENAI_API_KEY', '你的_token', 'User')
[Environment]::SetEnvironmentVariable('OPENAI_BASE_URL', 'https://cn.crazyrouter.com/v1', 'User')
[Environment]::SetEnvironmentVariable('ANTHROPIC_MODEL', 'claude-opus-4-8', 'User')
[Environment]::SetEnvironmentVariable('CLAUDE_MODEL', 'claude-opus-4-8', 'User')
```

然后打开新的 PowerShell：

```powershell
claude
```

---

## ✅ 怎么验证？

```bash
claude --version
claude
```

如果 Claude Code 能正常启动，并且请求走 Crazyrouter，就配置完成。

---

## 📦 如果你还没安装 Claude Code

本仓库也保留了完整一键安装脚本，会安装 Git、Node.js、Claude Code，并写入 Crazyrouter 配置。

### macOS / Linux 完整安装

```bash
curl -fsSL -o /tmp/crazyrouter-setup.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh
bash /tmp/crazyrouter-setup.sh
```

### Windows 完整安装

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex"
```

---

## 📁 仓库结构

```text
crazyrouter-claude-code/
├── README.md              # 中文说明
├── README.en.md           # English README
├── .env.example           # 环境变量示例
├── configure.sh           # macOS / Linux：只配置，不安装
├── setup.sh               # macOS / Linux：完整安装 + 配置
└── windows/
    ├── configure.ps1      # Windows：只配置，不安装
    └── setup.ps1          # Windows：完整安装 + 配置
```

---

## ❓常见问题

### 1）这个仓库会安装 Claude Code 吗？

默认推荐的 `configure.sh` / `configure.ps1` **不会安装** Claude Code。它只适合已经安装 Claude Code 的用户。

如果你还没安装，可以使用 `setup.sh` / `setup.ps1` 完整安装脚本。

### 2）必须要 Anthropic Key 吗？

不需要。目标就是让你用 Crazyrouter Token 配置 Claude Code。

### 3）为什么同时写 `ANTHROPIC_*` 和 `OPENAI_*`？

Claude Code 更偏 Anthropic 风格变量，其他 AI Coding Tools 常用 OpenAI 兼容变量。两套都写，方便复用同一个 Crazyrouter Token。

### 4）默认模型是什么？

默认：`claude-opus-4-8`。

你也可以改成 Crazyrouter 支持的其他 Claude 模型，例如：

```bash
CLAUDE_MODEL=claude-sonnet-4
CLAUDE_MODEL=claude-haiku-4.5
```

### 5）这个仓库是 Claude Code 官方项目吗？

不是。Claude Code 是 Anthropic 的 CLI 工具。本仓库只是帮助用户把已安装的 Claude Code 更快配置到 Crazyrouter。

---

## 🔗 相关链接

- 🌐 Crazyrouter 官网：<https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 API 文档：<https://docs.crazyrouter.com>
- 💬 Telegram：<https://t.me/crzrouter>
- 🐦 Twitter / X：<https://twitter.com/metaviiii>

---

## 📄 License

MIT License — 详见 [LICENSE](LICENSE)
