<div align="center">

# Claude Code × Crazyrouter

<!-- crazyrouter-links -->
> - 📖 **完整接入指南（手动配置、Base URL 规则、推荐模型、FAQ）**：https://crazyrouter.com/zh/integrations/claude-code?utm_source=github&utm_medium=readme&utm_campaign=claude-code
> - 🧩 **Claude 全部模型与实时价格**：https://crazyrouter.com/zh/models/anthropic?utm_source=github&utm_medium=readme&utm_campaign=claude-code
> - 💰 **模型价格对比（官方 / Azure / Bedrock / Vertex / Crazyrouter，每日核对）**：https://crazyrouter.com/zh/pricing?utm_source=github&utm_medium=readme&utm_campaign=claude-code
> - 🗂 **按厂商浏览全部模型**：https://crazyrouter.com/zh/models?utm_source=github&utm_medium=readme&utm_campaign=claude-code

**一个 API Key，调用 Claude、GPT、Gemini、DeepSeek。**

把 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 接到 [Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) —— 国内可直连，无需单独的 Anthropic 账号。

[![License: MIT](https://img.shields.io/badge/License-MIT-22c55e.svg?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-3b82f6?style=flat-square)](#先确认你属于哪种情况)
[![Claude Code](https://img.shields.io/badge/for-Claude%20Code-d97757?style=flat-square)](https://docs.anthropic.com/en/docs/claude-code)
[![Crazyrouter](https://img.shields.io/badge/gateway-Crazyrouter-8b5cf6?style=flat-square)](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo)

中文说明 · [English](README.en.md) · [Русский](README.ru.md) · [日本語](README.ja.md)

</div>

> ℹ️ 脚本运行时的全部提示与日志均为**英文** / All script prompts are in **English** / Все подсказки на **английском** / スクリプトの表示はすべて**英語**です。

---

## 先确认你属于哪种情况

本仓库提供两套脚本，对应两类用户。先对号入座，再复制下面对应的命令：

| 你的情况 | 用哪个脚本 | 它做什么 |
| --- | --- | --- |
| **已经装好 Claude Code**，只想接到 Crazyrouter | `configure`（推荐） | 只写入 Token 和接入地址，几秒完成，**不动你的 Claude Code** |
| **还没装 Claude Code**，想一步到位 | `setup` | 安装 Git + Node.js + Claude Code，再写入 Crazyrouter 配置 |

> 不确定装没装？在终端运行 `claude --version`。能看到版本号就用 `configure`，提示找不到命令就用 `setup`。

开始前请准备一个 **Crazyrouter API Key**：<https://cn.crazyrouter.com>

---

## 方式一：已装 Claude Code —— 只配置（推荐）

只写入接入地址和 Token，不安装、不重装任何东西。

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-configure.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh
bash /tmp/crazyrouter-configure.sh
```

一行版（注意结尾必须是 `bash`，不能只到 `|`）：

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex
```

### 脚本会问你三个问题（都可直接回车用默认值）

| 提示 | 默认值 | 说明 |
| --- | --- | --- |
| Crazyrouter Token | 无（必填） | 输入时隐藏，不会显示在屏幕上 |
| Base URL | `https://cn.crazyrouter.com` | 一般不用改 |
| 默认 Claude 模型 | `claude-opus-4-8` | 可改成下方支持的其他模型 |

---

## 方式二：还没装 Claude Code —— 完整安装

会自动安装 Git、Node.js、Claude Code，最后写入 Crazyrouter 配置。

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

## 跑完之后怎么验证

**让配置生效**，再运行 `claude`：

- **Windows**：关掉当前 PowerShell，**开一个新窗口**（环境变量只在新窗口生效）。
- **macOS / Linux**：脚本已把配置写入 `~/.crazyrouter-claude-code.env` 并在你的 shell 启动文件里加了一行自动加载。**开一个新终端**即可，或在当前终端直接运行 `source ~/.crazyrouter-claude-code.env`。

```bash
claude --version   # 能看到版本号
claude             # 正常进入对话，且请求走 Crazyrouter，即配置成功
```

> 在旧窗口里 `claude` 命令找不到是正常的——配置只在新窗口或 `source` 之后才生效。

---

## 脚本到底改了什么

两个脚本都会写入下面这 6 个用户级环境变量。同时写 `ANTHROPIC_*` 和 `OPENAI_*` 两套，是为了让同一个 Token 既能喂 Claude Code，也能喂其他 OpenAI 兼容的编程工具。

```bash
# 给 Claude Code（Anthropic 风格）
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=<你的 Token>
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8

# 给其他工具复用（OpenAI 兼容）
OPENAI_API_KEY=<你的 Token>
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

> ⚠️ 在代码里调用 API 时用纯净地址 `https://cn.crazyrouter.com/v1`，不要带 `?utm_source=...` 参数。

---

## 不想跑脚本？手动配置

效果和脚本完全一样，把变量写进去再开新窗口即可。

### macOS / Linux

加入 `~/.zshrc`、`~/.bashrc` 或 `~/.profile`：

```bash
export ANTHROPIC_BASE_URL="https://cn.crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="你的_token"
export OPENAI_API_KEY="你的_token"
export OPENAI_BASE_URL="https://cn.crazyrouter.com/v1"
export ANTHROPIC_MODEL="claude-opus-4-8"
export CLAUDE_MODEL="claude-opus-4-8"
```

```bash
source ~/.zshrc   # 用 zsh 的话
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

开新 PowerShell 窗口后运行 `claude`。

---

## 可选：换模型

默认 `claude-opus-4-8`。想换成其他 Crazyrouter 支持的 Claude 模型，改 `CLAUDE_MODEL` 即可：

```bash
CLAUDE_MODEL=claude-sonnet-4     # 更快、更省
CLAUDE_MODEL=claude-haiku-4.5    # 最轻量
```

---

## 可选：服务器 / 无人值守安装

`configure.sh` 支持非交互模式。预先设好环境变量，脚本就不会再提示输入，适合在 Rocky/RHEL/CentOS 等服务器上用 `curl | bash` 一键部署：

```bash
export CRAZYROUTER_TOKEN="你的_token"
export CRAZYROUTER_BASE_URL="https://cn.crazyrouter.com"   # 可选
export CLAUDE_MODEL="claude-opus-4-8"                      # 可选
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

> 服务器上常见 `curl | bash` 是非登录 shell，可能找不到已装的 `claude`。脚本会自动补上 `/usr/local/bin`、`~/.local/bin`、`~/.npm-global/bin` 等常见 npm 全局路径；即便仍找不到，也会照常写入 Crazyrouter 配置，并打印诊断信息提示后续步骤。

---

## 常见问题

**Q：跑完 `claude` 还是找不到命令？**
环境变量只在新窗口生效。关掉当前终端，重新开一个再试。

**Q：`configure` 和 `setup` 有什么区别？**
`configure` 只写配置，要求你已经装好 Claude Code；`setup` 会先帮你把 Git / Node.js / Claude Code 都装上，再写配置。

**Q：必须有 Anthropic 账号或 Key 吗？**
不需要。整个流程就是为了让你只用一个 Crazyrouter Token 跑 Claude Code。

**Q：为什么要同时写 `ANTHROPIC_*` 和 `OPENAI_*`？**
Claude Code 读 Anthropic 风格变量，很多其他编程工具读 OpenAI 兼容变量。两套都写，一个 Token 通吃。

**Q：这是 Claude Code 官方项目吗？**
不是。Claude Code 是 Anthropic 的 CLI 工具，本仓库只是帮你把它更快接到 Crazyrouter。

---

## 仓库结构

```text
crazyrouter-claude-code/
├── README.md              # 中文说明（本文件）
├── README.en.md           # English
├── README.ru.md           # Русский
├── README.ja.md           # 日本語
├── .env.example           # 环境变量示例
├── configure.sh           # macOS / Linux：只配置
├── setup.sh               # macOS / Linux：完整安装 + 配置
└── windows/
    ├── configure.ps1      # Windows：只配置
    └── setup.ps1          # Windows：完整安装 + 配置
```

---

## 相关链接

- 🌐 官网：<https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 API 文档：<https://docs.crazyrouter.com>
- 💬 Telegram：<https://t.me/crzrouter>
- 🐦 Twitter / X：<https://twitter.com/metaviiii>

---

## License

MIT License — 详见 [LICENSE](LICENSE)
