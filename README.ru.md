# ⚡ Уже установили Claude Code? Просто укажите адрес Crazyrouter и токен

[中文](README.md) | [English](README.en.md) | Русский | [日本語](README.ja.md)

Этот репозиторий — **простой инструмент для настройки Claude Code + Crazyrouter**.

Он рассчитан на пользователей, у которых Claude Code уже установлен. Переустанавливать ничего не нужно — достаточно перенаправить Claude Code на Crazyrouter и сохранить свой токен Crazyrouter.

[Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) — это шлюз для AI API. С одним API-ключом вы получаете доступ к Claude, GPT, Gemini, DeepSeek и многим другим моделям.

---

## 🚀 Самый быстрый способ: только настройка, без установки

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-configure.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh
bash /tmp/crazyrouter-configure.sh
```

Можно использовать и вариант в одну строку, но команда обязательно должна заканчиваться на `| bash`, а не просто на `|`:

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

Скрипт проверяет, что команда `claude` уже существует. Для серверов на базе Rocky Linux / RHEL / CentOS он дополнительно подгружает типичные глобальные пути npm, такие как `/usr/local/bin`, `~/.local/bin` и `~/.npm-global/bin`, чтобы вариант `curl | bash` мог найти Claude Code даже в нелогинной оболочке с минимальным PATH.

Затем скрипт запросит:

- ваш токен Crazyrouter
- базовый URL, по умолчанию: `https://cn.crazyrouter.com`
- модель Claude по умолчанию: `claude-opus-4-8`

После завершения откройте новый терминал и выполните:

```bash
claude
```

---

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex"
```

Короткий вариант:

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex
```

После завершения откройте новое окно PowerShell и выполните:

```powershell
claude
```

---

## 🔑 Что вам понадобится?

Нужно только:

- уже установленный **Claude Code**
- **API-ключ / токен Crazyrouter**

Получить токен можно здесь:

- <https://cn.crazyrouter.com>
- <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>

---

## 🧩 Что настраивает скрипт?

### Переменные Anthropic / Claude Code

```bash
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=ваш_токен
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8
```

### Переменные, совместимые с OpenAI, для других AI-инструментов кодинга

```bash
OPENAI_API_KEY=ваш_токен
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

Важно: в API-эндпоинтах не должно быть UTM-параметров. Используйте `https://cn.crazyrouter.com/v1`, а не URL с `?utm_source=...`.

---

## 🛠️ Ручная настройка

Если вы не хотите запускать скрипт, настройте переменные вручную.

### macOS / Linux

Добавьте это в `~/.zshrc`, `~/.bashrc` или `~/.profile`:

```bash
export ANTHROPIC_BASE_URL="https://cn.crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="ваш_токен"
export OPENAI_API_KEY="ваш_токен"
export OPENAI_BASE_URL="https://cn.crazyrouter.com/v1"
export ANTHROPIC_MODEL="claude-opus-4-8"
export CLAUDE_MODEL="claude-opus-4-8"
```

Затем выполните:

```bash
source ~/.zshrc   # если вы используете zsh
claude
```

### Windows PowerShell

```powershell
[Environment]::SetEnvironmentVariable('ANTHROPIC_BASE_URL', 'https://cn.crazyrouter.com', 'User')
[Environment]::SetEnvironmentVariable('ANTHROPIC_AUTH_TOKEN', 'ваш_токен', 'User')
[Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'ваш_токен', 'User')
[Environment]::SetEnvironmentVariable('OPENAI_BASE_URL', 'https://cn.crazyrouter.com/v1', 'User')
[Environment]::SetEnvironmentVariable('ANTHROPIC_MODEL', 'claude-opus-4-8', 'User')
[Environment]::SetEnvironmentVariable('CLAUDE_MODEL', 'claude-opus-4-8', 'User')
```

Затем откройте новое окно PowerShell:

```powershell
claude
```

---

## ✅ Как проверить?

```bash
claude --version
claude
```

Если Claude Code запускается нормально и запросы идут через Crazyrouter, настройка завершена.

---

## 📦 Если Claude Code ещё не установлен

В репозитории также есть полные скрипты установки в один клик. Они устанавливают Git, Node.js, Claude Code, а затем настраивают Crazyrouter.

### Полная установка для macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-setup.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/setup.sh
bash /tmp/crazyrouter-setup.sh
```

### Полная установка для Windows

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/setup.ps1 | iex"
```

---

## 📁 Структура репозитория

```text
crazyrouter-claude-code/
├── README.md              # Китайская версия
├── README.en.md           # Английская версия
├── README.ru.md           # Русская версия
├── README.ja.md           # Японская версия
├── .env.example           # пример переменных окружения
├── configure.sh           # macOS / Linux: только настройка, без установки
├── setup.sh               # macOS / Linux: полная установка + настройка
└── windows/
    ├── configure.ps1      # Windows: только настройка, без установки
    └── setup.ps1          # Windows: полная установка + настройка
```

---

## ❓ Частые вопросы

### Устанавливает ли этот репозиторий Claude Code?

Рекомендуемые скрипты `configure.sh` / `configure.ps1` **не** устанавливают Claude Code. Они предназначены для пользователей, у которых Claude Code уже установлен.

Если вы ещё не установили Claude Code, используйте `setup.sh` / `setup.ps1`.

### Нужен ли мне API-ключ Anthropic?

Нет. Цель — настроить Claude Code с вашим токеном Crazyrouter.

### Зачем задавать одновременно переменные `ANTHROPIC_*` и `OPENAI_*`?

Claude Code обычно использует переменные в стиле Anthropic. Другие AI-инструменты кодинга часто используют переменные, совместимые с OpenAI. Если задать оба набора, один и тот же токен Crazyrouter можно переиспользовать.

### Какая модель используется по умолчанию?

По умолчанию: `claude-opus-4-8`.

Вы можете заменить её на другую модель Claude, поддерживаемую Crazyrouter, например:

```bash
CLAUDE_MODEL=claude-sonnet-4
CLAUDE_MODEL=claude-haiku-4.5
```

### Это официальный проект Claude Code?

Нет. Claude Code — это CLI-инструмент от Anthropic. Этот репозиторий лишь помогает быстрее настроить уже установленный Claude Code на работу с Crazyrouter.

---

## 🔗 Полезные ссылки

- 🌐 Сайт Crazyrouter: <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 Документация API: <https://docs.crazyrouter.com>
- 💬 Telegram: <https://t.me/crzrouter>
- 🐦 Twitter / X: <https://twitter.com/metaviiii>

---

## 📄 Лицензия

Лицензия MIT — подробнее см. [LICENSE](LICENSE).
