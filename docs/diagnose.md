# Diagnose Claude Code in layers / Claude Code 分层诊断

## 1. Does the executable start?

Run `claude --version` in the same terminal where you will use it. After changing a user-level environment variable on Windows, open a new terminal. An old terminal does not receive new process variables. WSL has its own Linux environment; changing Windows PowerShell variables does not configure an existing WSL shell.

## 2. Are credentials present in that process?

These commands print booleans, not the key:

```bash
python -c "import os; print({n: bool(os.environ.get(n)) for n in ['ANTHROPIC_AUTH_TOKEN','ANTHROPIC_API_KEY','ANTHROPIC_BASE_URL','ANTHROPIC_MODEL']})"
```

If both credential variables are set, identify which one belongs to the intended provider and consult the installed client's authentication rules. Do not publish environment dumps or auth files. A successful account login is not proof that the gateway key was selected.

## 3. Is the API configuration valid?

Messages clients use a root base such as `https://crazyrouter.com` and append `/v1/messages`. They do not use Codex's Responses configuration. Copy the exact Claude model ID from your current catalogue.

Use the [standalone protocol doctor](https://github.com/xujfcn/claude-opus-4.5-gpt-5.2/blob/main/docs/start-here.md): configure its separate CRAZYROUTER_API_KEY locally, then run messages --online and, if desired, --inference. This isolates gateway connectivity from Claude Code's saved configuration. It does not read Claude Code's credentials automatically.

## 4. Does a real local task finish?

Use the [coding-task fixtures and method](https://github.com/xujfcn/claude-code-pricing-guide/tree/main/benchmarks). Begin with a fixed input and a testable output. Record the tool version, exact model, run time, test result, retry count and cost ledger. Test file reading, editing and tool execution separately from plain text generation.

## 5. Does the bill match your expectation?

Input, output, cache creation and cache reads are different components. A reused prompt is not proof of a cache hit; inspect actual usage/account records. [Normalize and calculate a ledger](https://github.com/xujfcn/claude-code-pricing-guide/blob/main/docs/ledger.md). Keep cold- and warm-cache experiments separate.

## Configuration changes and rollback

Before running a configurator, copy the exact files it documents as changing and record which user-level variables you intend to change. Restore only those files/variables. This guide does not claim the existing installer has a universal automatic rollback feature. Never delete the entire ~/.claude directory to fix a provider setting.

中文排查顺序：命令能否启动 → 当前进程能否看到配置 → 网关 Messages 最小请求 → Claude Code 完整任务 → 账单。每层独立验证，避免把根地址 404、GUI 登录成功或一次聊天 200 当作全部功能通过。
