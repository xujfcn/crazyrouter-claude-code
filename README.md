# 🚀 用 Crazyrouter 一键配置 Claude Code

[English README](README.en.md) | 中文说明

> **只需要一个 Crazyrouter Token**，即可快速安装并配置 Claude Code。适合直接给用户复制命令使用。

[Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) 是一个 AI API 网关。你可以通过一个 API Key 访问 Claude、GPT、Gemini、DeepSeek 等多种模型，并统一走一个接口。

这个仓库的目标很简单：

- 自动安装 **Claude Code**
- 自动配置 **Crazyrouter** 所需环境变量
- 用户只需要 **粘贴一条命令 + 输入 Crazyrouter Token**

---

## ⚡ 一键安装

### Windows（PowerShell）
复制后直接运行：

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex"
```

更短版本：

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex
```

这个脚本会自动完成：
- 安装 Git
- 安装 Node.js LTS
- 安装 Claude Code
- 提示输入 Crazyrouter Token
- 自动保存环境变量
- 自动创建测试目录

---

### macOS / Linux
复制后直接运行：

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh | bash
```

这个脚本会自动完成：
- 安装 Git（如未安装）
- 安装 Node.js（如未安装）
- 安装 Claude Code
- 提示输入 Crazyrouter Token
- 自动写入 shell 配置文件

---

## 🔑 我需要准备什么？

你只需要准备：

- **一个 Crazyrouter API Key / Token**

获取地址：
- <https://crazyrouter.com>

运行安装脚本后，按提示粘贴 Token 即可。

---

## 🧩 脚本会写入哪些环境变量？

为了兼容 Claude Code 以及其他 AI 编程工具，脚本会同时保存两套变量：

### Anthropic 风格变量
```bash
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=你的_token
```

### OpenAI 风格变量
```bash
OPENAI_API_KEY=你的_token
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

这样做的好处：
- Claude Code 更容易直接接上 Crazyrouter
- 其他工具（如部分 OpenAI 兼容工具）也能直接复用
- 用户不用理解太多底层差异

---

## ✅ 安装完成后怎么验证？

安装结束后，打开一个**新的终端窗口**，执行：

```bash
claude --version
```

然后进入任意项目目录执行：

```bash
claude
```

如果能正常启动，就说明已经基本配置完成。

---

## 📦 如果不想远程执行，也可以手动跑

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

## 📁 仓库结构

```text
crazyrouter-claude-code/
├── README.md            # 中文说明
├── .env.example         # 环境变量示例
├── setup.sh             # macOS / Linux 一键脚本
└── windows/
    └── setup.ps1        # Windows PowerShell 一键脚本
```

---

## ❓常见问题

### 1）这是 Claude Code 官方项目吗？
不是。

Claude Code 本身是 Anthropic 的 CLI 工具。这个仓库的作用是：
**帮助用户更快地安装 Claude Code，并配置成走 Crazyrouter。**

### 2）必须要 Anthropic 的 Key 吗？
不需要。

这个仓库的目标就是：
**尽量让用户只输入 Crazyrouter Token 就能完成配置。**

### 3）会影响 Claude Code 原有功能吗？
一般不会。

这个仓库主要做的是：
- 安装工具
- 写环境变量
- 降低配置门槛

### 4）为什么同时写 `ANTHROPIC_*` 和 `OPENAI_*` 变量？
因为不同工具的识别方式不完全一样。

保存两套变量可以减少兼容问题，也方便后续扩展到其他 AI Coding Tools。

### 5）现在推荐的模型名怎么写？
脚本默认会设置 `claude-opus-4-8`。如果你后续想自己指定模型，可以改环境变量。

例如（2026 年 6 月推荐写法）：

```bash
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-sonnet-4
CLAUDE_MODEL=claude-haiku-4.5
```

---

## 🔗 相关链接

- 🌐 Crazyrouter 官网：<https://crazyrouter.com>
- 📖 API 文档：<https://docs.crazyrouter.com>
- 💬 Telegram：<https://t.me/crzrouter>
- 🐦 Twitter / X：<https://twitter.com/metaviiii>

---

## 📄 License

MIT License — 详见 [LICENSE](LICENSE)
