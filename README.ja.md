# ⚡ Claude Code はインストール済み？Crazyrouter のアドレスとトークンを設定するだけ

[中文](README.md) | [English](README.en.md) | [Русский](README.ru.md) | 日本語

このリポジトリは、**Claude Code + Crazyrouter のかんたん設定ツール**です。

すでに Claude Code をインストール済みのユーザー向けです。Claude Code を入れ直す必要はありません。接続先を Crazyrouter に向けて、Crazyrouter のトークンを保存するだけです。

[Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) は AI API ゲートウェイです。1 つの API キーで、Claude、GPT、Gemini、DeepSeek など多くのモデルにアクセスできます。

---

## 🚀 いちばん速い方法：インストールせず設定だけ

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-configure.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh
bash /tmp/crazyrouter-configure.sh
```

1 行版も使えますが、コマンドの末尾が `|` だけでなく必ず `| bash` で終わるようにしてください：

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

スクリプトは `claude` コマンドがすでに存在するか確認します。Rocky Linux / RHEL / CentOS 系のサーバーでは、`/usr/local/bin`、`~/.local/bin`、`~/.npm-global/bin` といった一般的な npm グローバルパスも追加で読み込みます。これにより、PATH が最小限の非ログインシェルでも `curl | bash` で Claude Code を見つけられます。

その後、次の入力を求められます：

- Crazyrouter のトークン
- ベース URL（デフォルト：`https://cn.crazyrouter.com`）
- デフォルトの Claude モデル（デフォルト：`claude-opus-4-8`）

完了したら、新しいターミナルを開いて実行します：

```bash
claude
```

---

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex"
```

短縮版：

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex
```

完了したら、新しい PowerShell ウィンドウを開いて実行します：

```powershell
claude
```

---

## 🔑 必要なものは？

必要なのは次の 2 つだけです：

- インストール済みの **Claude Code**
- **Crazyrouter の API キー / トークン**

トークンの取得はこちら：

- <https://cn.crazyrouter.com>
- <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>

---

## 🧩 スクリプトは何を設定する？

### Anthropic / Claude Code 用の変数

```bash
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=あなたのトークン
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8
```

### ほかの AI コーディングツールでも使える OpenAI 互換の変数

```bash
OPENAI_API_KEY=あなたのトークン
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

注意：API エンドポイントに UTM パラメータを含めないでください。`?utm_source=...` 付きの URL ではなく、`https://cn.crazyrouter.com/v1` を使ってください。

---

## 🛠️ 手動設定

スクリプトを実行したくない場合は、変数を手動で設定できます。

### macOS / Linux

次の内容を `~/.zshrc`、`~/.bashrc`、または `~/.profile` に追加します：

```bash
export ANTHROPIC_BASE_URL="https://cn.crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="あなたのトークン"
export OPENAI_API_KEY="あなたのトークン"
export OPENAI_BASE_URL="https://cn.crazyrouter.com/v1"
export ANTHROPIC_MODEL="claude-opus-4-8"
export CLAUDE_MODEL="claude-opus-4-8"
```

その後、実行します：

```bash
source ~/.zshrc   # zsh を使っている場合
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

その後、新しい PowerShell ウィンドウを開きます：

```powershell
claude
```

---

## ✅ 確認方法

```bash
claude --version
claude
```

Claude Code が正常に起動し、リクエストが Crazyrouter を経由していれば設定完了です。

---

## 📦 まだ Claude Code をインストールしていない場合

このリポジトリには、ワンクリックのフルインストーラーも含まれています。Git、Node.js、Claude Code をインストールし、続けて Crazyrouter を設定します。

### macOS / Linux のフルインストール

```bash
curl -fsSL -o /tmp/crazyrouter-setup.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh
bash /tmp/crazyrouter-setup.sh
```

### Windows のフルインストール

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex"
```

---

## 📁 リポジトリ構成

```text
crazyrouter-claude-code/
├── README.md              # 中国語版
├── README.en.md           # 英語版
├── README.ru.md           # ロシア語版
├── README.ja.md           # 日本語版
├── .env.example           # 環境変数のサンプル
├── configure.sh           # macOS / Linux：設定のみ、インストールなし
├── setup.sh               # macOS / Linux：フルインストール + 設定
└── windows/
    ├── configure.ps1      # Windows：設定のみ、インストールなし
    └── setup.ps1          # Windows：フルインストール + 設定
```

---

## ❓ よくある質問

### このリポジトリは Claude Code をインストールしますか？

推奨される `configure.sh` / `configure.ps1` スクリプトは Claude Code を**インストールしません**。これらは Claude Code をすでにインストール済みのユーザー向けです。

まだインストールしていない場合は、`setup.sh` / `setup.ps1` を使ってください。

### Anthropic の API キーは必要ですか？

いいえ。目的は、Crazyrouter のトークンで Claude Code を設定することです。

### なぜ `ANTHROPIC_*` と `OPENAI_*` の両方を設定するのですか？

Claude Code は通常 Anthropic スタイルの変数を使います。ほかの AI コーディングツールは OpenAI 互換の変数を使うことが多いです。両方を保存しておくと、同じ Crazyrouter トークンを使い回せます。

### デフォルトのモデルは何ですか？

デフォルト：`claude-opus-4-8`。

Crazyrouter が対応するほかの Claude モデルに変更することもできます。例：

```bash
CLAUDE_MODEL=claude-sonnet-4
CLAUDE_MODEL=claude-haiku-4.5
```

### これは Claude Code の公式プロジェクトですか？

いいえ。Claude Code は Anthropic の CLI ツールです。このリポジトリは、インストール済みの Claude Code を Crazyrouter 用にすばやく設定するのを手助けするだけです。

---

## 🔗 関連リンク

- 🌐 Crazyrouter 公式サイト：<https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 API ドキュメント：<https://docs.crazyrouter.com>
- 💬 Telegram：<https://t.me/crzrouter>
- 🐦 Twitter / X：<https://twitter.com/metaviiii>

---

## 📄 ライセンス

MIT ライセンス — 詳細は [LICENSE](LICENSE) を参照してください。
