<div align="center">

# Claude Code × Crazyrouter

<!-- crazyrouter-links -->
> - 📖 **Полное руководство (ручная настройка, Base URL, модели, FAQ)**: https://crazyrouter.com/en/integrations/claude-code?utm_source=github&utm_medium=readme&utm_campaign=claude-code
> - 🧩 **Все модели Claude и актуальные цены**: https://crazyrouter.com/en/models/anthropic?utm_source=github&utm_medium=readme&utm_campaign=claude-code
> - 💰 **Сравнение цен моделей (официальные / Azure / Bedrock / Vertex / Crazyrouter)**: https://crazyrouter.com/ru/pricing?utm_source=github&utm_medium=readme&utm_campaign=claude-code

**Один API-ключ для Claude, GPT, Gemini и DeepSeek.**

Направьте [Claude Code](https://docs.anthropic.com/en/docs/claude-code) на [Crazyrouter](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo) — отдельный аккаунт Anthropic не нужен.

[![License: MIT](https://img.shields.io/badge/License-MIT-22c55e.svg?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-3b82f6?style=flat-square)](#кто-вы)
[![Claude Code](https://img.shields.io/badge/for-Claude%20Code-d97757?style=flat-square)](https://docs.anthropic.com/en/docs/claude-code)
[![Crazyrouter](https://img.shields.io/badge/gateway-Crazyrouter-8b5cf6?style=flat-square)](https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo)

[中文](README.md) · [English](README.en.md) · Русский · [日本語](README.ja.md)

</div>

> ℹ️ Все подсказки и логи скриптов выводятся на **английском** / 脚本提示均为**英文** / All prompts are in **English** / スクリプトの表示は**英語**です。

---

## Кто вы?

В репозитории два скрипта для двух типов пользователей. Найдите свою строку и скопируйте нужную команду:

| Ваша ситуация | Какой скрипт | Что он делает |
| --- | --- | --- |
| **Claude Code уже установлен**, нужно лишь направить его на Crazyrouter | `configure` (рекомендуется) | Записывает только токен и адрес. Несколько секунд, **не трогает ваш Claude Code** |
| **Claude Code ещё не установлен**, хотите всё сразу | `setup` | Устанавливает Git + Node.js + Claude Code, затем записывает настройки Crazyrouter |

> Не уверены, установлен ли он? Выполните `claude --version`. Номер версии — используйте `configure`; «command not found» — используйте `setup`.

Перед началом получите **API-ключ Crazyrouter**: <https://cn.crazyrouter.com>

---

## Вариант 1 — Claude Code установлен: только настройка (рекомендуется)

Записывает адрес и токен. Ничего не устанавливает и не переустанавливает.

### macOS / Linux

```bash
curl -fsSL -o /tmp/crazyrouter-configure.sh https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh
bash /tmp/crazyrouter-configure.sh
```

Однострочный вариант (команда должна заканчиваться на `bash`, а не просто на `|`):

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/windows/configure.ps1 | iex
```

### Скрипт задаёт три вопроса (Enter — значение по умолчанию)

| Запрос | По умолчанию | Примечание |
| --- | --- | --- |
| Токен Crazyrouter | нет (обязательно) | Ввод скрыт, на экране не отображается |
| Base URL | `https://cn.crazyrouter.com` | Обычно оставьте как есть |
| Модель Claude по умолчанию | `claude-opus-4-8` | Можно сменить на поддерживаемую модель ниже |

---

## Вариант 2 — Claude Code не установлен: полная установка

Устанавливает Git, Node.js и Claude Code, затем записывает настройки Crazyrouter.

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

## Проверка после запуска

**Примените настройки**, затем запустите `claude`:

- **Windows**: закройте текущий PowerShell и **откройте новое окно** (переменные среды действуют только в новых окнах).
- **macOS / Linux**: скрипт записал настройки в `~/.crazyrouter-claude-code.env` и добавил строку автозагрузки в файл запуска оболочки. **Откройте новый терминал** или выполните `source ~/.crazyrouter-claude-code.env` в текущем.

```bash
claude --version   # показывает номер версии
claude             # запускается и идёт через Crazyrouter
```

> `claude: command not found` в старом окне — это нормально: настройки действуют только в новом окне или после `source`.

---

## Что именно меняют скрипты

Оба скрипта записывают эти шесть пользовательских переменных среды. Набор `ANTHROPIC_*` и `OPENAI_*` задаётся вместе, чтобы один токен работал и в Claude Code, и в других OpenAI-совместимых инструментах.

```bash
# Для Claude Code (стиль Anthropic)
ANTHROPIC_BASE_URL=https://cn.crazyrouter.com
ANTHROPIC_AUTH_TOKEN=<ваш токен>
ANTHROPIC_MODEL=claude-opus-4-8
CLAUDE_MODEL=claude-opus-4-8

# Для других инструментов (OpenAI-совместимые)
OPENAI_API_KEY=<ваш токен>
OPENAI_BASE_URL=https://cn.crazyrouter.com/v1
```

> ⚠️ При вызове API из кода используйте чистый адрес `https://cn.crazyrouter.com/v1` — без `?utm_source=...`.

---

## Не хотите запускать скрипт? Настройте вручную

Результат тот же, что у скриптов. Задайте переменные и откройте новое окно.

### macOS / Linux

Добавьте в `~/.zshrc`, `~/.bashrc` или `~/.profile`:

```bash
export ANTHROPIC_BASE_URL="https://cn.crazyrouter.com"
export ANTHROPIC_AUTH_TOKEN="ваш_токен"
export OPENAI_API_KEY="ваш_токен"
export OPENAI_BASE_URL="https://cn.crazyrouter.com/v1"
export ANTHROPIC_MODEL="claude-opus-4-8"
export CLAUDE_MODEL="claude-opus-4-8"
```

```bash
source ~/.zshrc   # если используете zsh
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

Откройте новое окно PowerShell и выполните `claude`.

---

## Опционально: смена модели

По умолчанию `claude-opus-4-8`. Чтобы переключиться на другую модель Claude, поддерживаемую Crazyrouter, измените `CLAUDE_MODEL`:

```bash
CLAUDE_MODEL=claude-sonnet-4     # быстрее, дешевле
CLAUDE_MODEL=claude-haiku-4.5    # самая лёгкая
```

---

## Опционально: установка на сервере / без участия пользователя

`configure.sh` поддерживает неинтерактивный режим. Заранее задайте переменные среды — и скрипт перестаёт спрашивать. Удобно для `curl | bash` на серверах Rocky/RHEL/CentOS:

```bash
export CRAZYROUTER_TOKEN="ваш_токен"
export CRAZYROUTER_BASE_URL="https://cn.crazyrouter.com"   # необязательно
export CLAUDE_MODEL="claude-opus-4-8"                      # необязательно
curl -fsSL https://raw.githubusercontent.com/xujfcn/crazyrouter-claude-code/main/configure.sh | bash
```

> На серверах `curl | bash` часто запускается в non-login shell, который не находит установленный `claude`. Скрипт автоматически добавляет типичные глобальные пути npm (`/usr/local/bin`, `~/.local/bin`, `~/.npm-global/bin`). Даже если найти не удалось, он всё равно записывает настройки Crazyrouter и печатает диагностику со следующими шагами.

---

## Частые вопросы

**В: `claude` всё ещё не найден после запуска.**
Переменные действуют только в новых окнах. Закройте терминал и откройте новый.

**В: Чем отличаются `configure` и `setup`?**
`configure` только записывает настройки и требует уже установленный Claude Code; `setup` сначала ставит Git / Node.js / Claude Code, затем записывает настройки.

**В: Нужен ли аккаунт или ключ Anthropic?**
Нет. Весь смысл — запускать Claude Code с одним токеном Crazyrouter.

**В: Зачем задавать и `ANTHROPIC_*`, и `OPENAI_*`?**
Claude Code читает переменные в стиле Anthropic; многие другие инструменты — OpenAI-совместимые. Задайте оба — и один токен покрывает всё.

**В: Это официальный проект Claude Code?**
Нет. Claude Code — это CLI-инструмент Anthropic. Этот репозиторий лишь помогает быстрее направить его на Crazyrouter.

---

## Структура репозитория

```text
crazyrouter-claude-code/
├── README.md              # китайский
├── README.en.md           # английский
├── README.ru.md           # русский (этот файл)
├── README.ja.md           # японский
├── .env.example           # пример переменных среды
├── configure.sh           # macOS / Linux: только настройка
├── setup.sh               # macOS / Linux: полная установка + настройка
└── windows/
    ├── configure.ps1      # Windows: только настройка
    └── setup.ps1          # Windows: полная установка + настройка
```

---

## Ссылки

- 🌐 Сайт: <https://crazyrouter.com?utm_source=github&utm_medium=github&utm_campaign=claude_code_repo>
- 📖 Документация API: <https://docs.crazyrouter.com>
- 💬 Telegram: <https://t.me/crzrouter>
- 🐦 Twitter / X: <https://twitter.com/metaviiii>

---

## Лицензия

MIT License — см. [LICENSE](LICENSE).
