<div align="center">

# Claude Code × Crazyrouter

**1 つの API キーで Claude・GPT・Gemini・DeepSeek を。**

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) を [Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) に接続 — 個別の Anthropic アカウントは不要です。

[![License: MIT](https://img.shields.io/badge/License-MIT-22c55e.svg?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-3b82f6?style=flat-square)](#あなたはどちらですか)
[![Claude Code](https://img.shields.io/badge/for-Claude%20Code-d97757?style=flat-square)](https://docs.anthropic.com/en/docs/claude-code)
[![Crazyrouter](https://img.shields.io/badge/gateway-Crazyrouter-8b5cf6?style=flat-square)](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo)

[中文](README.md) · [English](README.en.md) · [Русский](README.ru.md) · 日本語

</div>

> ℹ️ スクリプト実行中の表示・ログはすべて**英語**です / 脚本提示均为**英文** / All prompts are in **English** / Все подсказки на **английском**.

---

## あなたはどちらですか？

このリポジトリには 2 種類のユーザー向けに 2 つのスクリプトがあります。自分の行を見つけて、対応するコマンドをコピーしてください：

| あなたの状況 | 使うスクリプト | 何をするか |
| --- | --- | --- |
| **Claude Code はインストール済み**で、接続先を Crazyrouter に向けたいだけ | `configure`（推奨） | トークンと接続先だけを書き込む。数秒で完了、**Claude Code 本体には触れない** |
| **Claude Code が未インストール**で、一気に済ませたい | `setup` | Git + Node.js + Claude Code をインストールし、Crazyrouter 設定を書き込む |

> 入っているか不明な場合は `claude --version` を実行。バージョン番号が出れば `configure`、「command not found」なら `setup` を使います。

始める前に **Crazyrouter の API キー**を取得してください：<https://cn.crazyrouter.com>

---

## 方法 1 — Claude Code 導入済み：設定のみ（推奨）

接続先とトークンを書き込みます。インストールや再インストールは行いません。

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-configure.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh
bash /tmp/crazyrouter-configure.sh
```

ワンライナー版（コマンドの末尾は `|` だけでなく `bash` で終える必要があります）：

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex
```

### スクリプトは 3 つ質問します（Enter で既定値）

| 質問 | 既定値 | 備考 |
| --- | --- | --- |
| Crazyrouter トークン | なし（必須） | 入力は非表示。画面には出ません |
| Base URL | `https://cn.crazyrouter.com` | 通常はそのままで可 |
| 既定の Claude モデル | `claude-opus-4-8` | 下記の対応モデルに変更可 |

---

## 方法 2 — Claude Code 未導入：フルインストール

Git・Node.js・Claude Code をインストールし、Crazyrouter 設定を書き込みます。

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

## 実行後の確認

**設定を反映**してから `claude` を実行します：

- **Windows**：現在の PowerShell を閉じ、**新しいウィンドウを開く**（環境変数は新しいウィンドウでのみ有効）。
- **macOS / Linux**：スクリプトは設定を `~/.crazyrouter-claude-code.env` に書き込み、シェル起動ファイルに自動読み込み行を追加済みです。**新しいターミナルを開く**か、現在のターミナルで `source ~/.crazyrouter-claude-code.env` を実行します。

```bash
claude --version   # バージョン番号が表示される
claude             # 正常に起動し、リクエストが Crazyrouter 経由になる
```

> 古いウィンドウで `claude: command not found` になるのは正常です。設定は新しいウィンドウまたは `source` 後にのみ有効になります。

---

## スクリプトが実際に変更する内容

どちらのスクリプトも次の 6 つのユーザー環境変数を書き込みます。同じトークンを Claude Code でも他の OpenAI 互換ツールでも使えるよう、`ANTHROPIC_*` と `OPENAI_*` の両方を設定します。

```bash
# Claude Code 用（Anthropic 形式）
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=<あなたのトークン>
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8

# 他ツール用（OpenAI 互換）
OPENAI_API_KEY=<あなたのトークン>
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

> ⚠️ コードから API を呼ぶときはクリーンな `https://cn.crazyrouter.com/v1` を使い、`?utm_source=...` 付きの URL は使わないでください。

---

## スクリプトを使いたくない場合：手動設定

スクリプトと同じ結果になります。変数を設定してから新しいウィンドウを開きます。

### macOS / Linux

`~/.zshrc`、`~/.bashrc`、または `~/.profile` に追加：

```bash
export ANTHROPIC_BASE_URL="https://cn.crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="あなたのトークン"
export OPENAI_API_KEY="あなたのトークン"
export OPENAI_BASE_URL="https://cn.crazyrouter.com/v1"
export ANTHROPIC_MODEL="claude-opus-4-8"
export CLAUDE_MODEL="claude-opus-4-8"
```

```bash
source ~/.zshrc   # zsh を使う場合
claude
```

### Windows PowerShell

```powershell
[Environment]::SetEnvironmentVariable('ANTHROPIC_BASE_URL', 'https://cn.crazyrouter.com', 'User')
[Environment]::SetEnvironmentVariable('ANTHROPIC_AUTH_TOKEN', 'あなたのトークン', 'User')
[Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'あなたのトークン', 'User')
[Environment]::SetEnvironmentVariable('OPENAI_BASE_URL', 'https://cn.crazyrouter.com/v1', 'User')
[Environment]::SetEnvironmentVariable('ANTHROPIC_MODEL', 'claude-opus-4-8', 'User')
[Environment]::SetEnvironmentVariable('CLAUDE_MODEL', 'claude-opus-4-8', 'User')
```

新しい PowerShell ウィンドウを開き、`claude` を実行します。

---

## 任意：モデルの変更

既定は `claude-opus-4-8` です。Crazyrouter が対応する別の Claude モデルに切り替えるには `CLAUDE_MODEL` を変更します：

```bash
CLAUDE_MODEL=claude-sonnet-4     # 高速・低コスト
CLAUDE_MODEL=claude-haiku-4.5    # 最軽量
```

---

## 任意：サーバー / 無人インストール

`configure.sh` は非対話モードに対応します。事前に環境変数を設定すればスクリプトは質問しなくなり、Rocky/RHEL/CentOS などのサーバーで `curl | bash` を使う際に便利です：

```bash
export CRAZYROUTER_TOKEN="あなたのトークン"
export CRAZYROUTER_BASE_URL="https://cn.crazyrouter.com"   # 任意
export CLAUDE_MODEL="claude-opus-4-8"                      # 任意
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

> サーバーでは `curl | bash` が非ログインシェルで動き、インストール済みの `claude` を見つけられないことがあります。スクリプトは一般的な npm グローバルパス（`/usr/local/bin`、`~/.local/bin`、`~/.npm-global/bin`）を自動で追加します。それでも見つからない場合も、Crazyrouter 設定は書き込み、次の手順を示す診断情報を表示します。

---

## よくある質問

**Q：実行後も `claude` が見つかりません。**
環境変数は新しいウィンドウでのみ有効です。ターミナルを閉じて新しく開いてください。

**Q：`configure` と `setup` の違いは？**
`configure` は設定のみで、Claude Code が導入済みであることが前提。`setup` は先に Git / Node.js / Claude Code を入れてから設定を書き込みます。

**Q：Anthropic のアカウントやキーは必要？**
不要です。目的は 1 つの Crazyrouter トークンで Claude Code を動かすことです。

**Q：なぜ `ANTHROPIC_*` と `OPENAI_*` の両方を設定するの？**
Claude Code は Anthropic 形式の変数を読み、他の多くのツールは OpenAI 互換の変数を読みます。両方設定すれば 1 つのトークンで両対応できます。

**Q：これは Claude Code の公式プロジェクト？**
いいえ。Claude Code は Anthropic の CLI ツールです。本リポジトリは、それをより速く Crazyrouter に接続する手助けをするだけです。

---

## リポジトリ構成

```text
crazyrouter-claude-code/
├── README.md              # 中国語
├── README.en.md           # 英語
├── README.ru.md           # ロシア語
├── README.ja.md           # 日本語（このファイル）
├── .env.example           # 環境変数の例
├── configure.sh           # macOS / Linux：設定のみ
├── setup.sh               # macOS / Linux：フルインストール + 設定
└── windows/
    ├── configure.ps1      # Windows：設定のみ
    └── setup.ps1          # Windows：フルインストール + 設定
```

---

## リンク

- 🌐 公式サイト：<https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 API ドキュメント：<https://docs.crazyrouter.com>
- 💬 Telegram：<https://t.me/crzrouter>
- 🐦 Twitter / X：<https://twitter.com/metaviiii>

---

## ライセンス

MIT License — [LICENSE](LICENSE) を参照。
