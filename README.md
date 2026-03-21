# 🎯 OneTask

**Stop managing tasks. Start finishing them.**

[![Notion API](https://img.shields.io/badge/Notion-API-black?logo=notion)](https://developers.notion.com)
[![Python](https://img.shields.io/badge/Python-3.11+-blue?logo=python)](https://python.org)
[![Gemini](https://img.shields.io/badge/AI-Gemini%202.5%20Flash-orange?logo=google)](https://ai.google.dev)

---

## Demo

> 🎬 [▶ Watch OneTask Demo on YouTube](https://youtu.be/NnrM6ALD79Y)

> ![Image](https://github.com/user-attachments/assets/6b6e4f5f-35d5-4635-b781-013390e070c1)

---

## The Problem

Every Monday you open Notion and see 15 tasks. By Friday, you've touched 8 and finished 0.

The problem isn't time management. It's **too many open loops at once.**

```
BEFORE OneTask                    AFTER OneTask
──────────────────                ─────────────────
□ Learn Python                    ✅ Learn Python
□ Build landing page                 │
□ Write business plan                ├─ Wednesday: Read chapters 1-3
□ Fix the API bug                    ├─ Thursday: Build first script
□ Update portfolio                   ├─ Friday: Practice with exercises
□ Reply to emails                    └─ Saturday: Mini project
□ ...7 more
```

**You choose one focus. OneTask plans the week, writes it to Notion, and guards your focus.**

---

## What OneTask Does

You define the goal. OneTask turns it into a focused weekly execution plan.

1. **Reads your Notion workspace** — understands what else you have going on
2. **Plans your week** — breaks the task into specific daily steps
3. **Writes to Notion** — real checkboxes in your actual task page
4. **Guards your focus** — challenges you if you try to switch mid-week

---

## The Focus Guardian

This is the feature that makes OneTask different.

Most apps let you abandon tasks silently. OneTask pushes back.

When you try to change your focus on Day 3:

```
You:   "I want to work on something else"

Agent: "You're on Day 3 of 7. You've done 1 out of 5 steps.
        What's the real reason?"

You:   "I feel like working on a different project"

Agent: "That sounds more like avoidance than necessity.
        I recommend staying with your current focus."

You:   "My client moved a deadline to tomorrow morning"

Agent: "External deadline conflict detected.
        You're clear to switch."
```

Momentum protection. Built in.

---

## How It Works

```
You type: "Learn Python"
              │
              ▼
   ┌──────────────────────┐
   │  Notion MCP layer    │  ← reads your workspace
   │  reads your tasks    │
   └──────────┬───────────┘
              │
              ▼
   ┌──────────────────────┐
   │  Gemini 2.5 Flash    │  ← plans your week
   │  builds daily steps  │
   └──────────┬───────────┘
              │
              ▼
   ┌──────────────────────┐
   │  Notion MCP + API    │  ← writes to your workspace
   │  writes to your page │     Status → In progress
   │                      │     Priority → Week Focus
   │                      │     Notes → AI motivation
   │                      │     ☐ Wednesday: Read ch. 1-3
   │                      │     ☐ Thursday: Build script
   │                      │     ☐ Friday: Practice
   └──────────────────────┘
              │
              ▼
        Your dashboard
        shows today's step
```

---

## Features

| | |
|---|---|
| **One focus, one week** | Commit to a single weekly goal — the app is built around that constraint |
| **AI week planning** | Gemini breaks your task into specific daily steps |
| **Real Notion checkboxes** | `to_do` blocks written directly into your task page |
| **Real-time Notion writes** | Actions in the app update your Notion task page immediately |
| **Focus guardian** | AI reviews change requests and recommends staying on track |
| **Adapt your plan** | Too hard? Too easy? Rewrite the plan for your real level mid-week |
| **Ready-to-use template** | Duplicate the Notion template and skip manual database setup |
| **Dark mode** | Auto-detects system preference via `prefers-color-scheme` |

---

## Tech Stack

- **Backend:** Python, FastAPI
- **Frontend:** HTML, CSS, Vanilla JavaScript (single file, no build step)
- **AI:** Gemini 2.5 Flash (native JSON output mode)
- **Workspace Integration:** Notion REST API + Notion MCP tooling layer

---

## Quick Start

### Requirements

- Python 3.11+
- Node.js 20+ *(required by the Notion MCP server)*
- Notion account
- Google AI Studio key (free tier works)

### 1. Install

```bash
git clone https://github.com/bilalmez/onetask.git
cd onetask
pip install -r requirements.txt
```

### 2. Set up Notion

#### Recommended: duplicate the OneTask template

To get started quickly, use the provided Notion template instead of building the database manually.

**Template:** [Duplicate the OneTask Notion template](https://spectacled-myrtle-6ae.notion.site/One-Task-e8178c86dfb78328b9e481d28ef119bf)

The template already includes the required database structure with the correct columns, Priority options, and a Board view pre-configured.

> 💡 **New to Notion integrations?** Click **📖 Setup Guide** inside the app — it walks you through the template, integration, and database ID step by step.

---

#### Create a Notion integration

1. Go to [notion.so/my-integrations](https://notion.so/my-integrations)
2. Click **New integration** → give it a name (e.g. `OneTask`)
3. Copy the internal integration token

---

#### Connect the integration to your database

After duplicating the template:

1. Open the Notion page that contains your OneTask database
2. Click **⋯ (top right)** → **Connections**
3. Search for your integration and select it
4. Confirm access

> If the integration is not added under **Connections**, the app may start normally but fail to find or update your tasks.

---

#### Get your database ID

Open the database in Notion and copy the ID from the URL:

```
https://www.notion.so/your-workspace/abc123def456...?v=...
                                     ↑ this is your database ID
```

---

#### Manual setup (optional)

If you prefer not to use the template, create a database manually with this schema:

| Column | Type | Options |
|---|---|---|
| Name | Title | — |
| Status | Status | Not started, In progress, Done |
| Priority | Select | Week Focus, High, Medium, Low |
| Notes | Text | — |

### 3. Configure

```bash
cp .env.example .env
```

```env
NOTION_TOKEN=ntn_...
NOTION_DATABASE_ID=...
GEMINI_API_KEY=AIza...
PORT=3001
```

> Your database ID is in the URL: `notion.so/`**`abc123...`**`?v=...`
> Keep your `.env` local only — never commit API keys.

### 4. Run

```bash
start.bat
```

> `start.bat` launches both the Notion MCP helper process and the FastAPI server. Requires Windows and Node.js in PATH.

→ [http://localhost:3001](http://localhost:3001)

---

## Backend Endpoints

| Method | Path | Description |
|---|---|---|
| `GET` | `/` | Frontend UI |
| `GET` | `/health` | Check MCP + DB status |
| `POST` | `/set-focus` | Set weekly focus + generate plan |
| `POST` | `/confirm-overwrite` | Replace an existing weekly plan |
| `POST` | `/sync` | Pull latest task state from Notion |
| `POST` | `/mark-done` | Check off a daily step |
| `POST` | `/adapt-steps` | Rewrite the plan for your level |
| `POST` | `/request-change` | Review and approve/reject a focus switch |
| `POST` | `/finish-week` | Mark the week complete in Notion |

---

## Project Structure

```
onetask/
├── agent.py         ← FastAPI backend + Gemini + MCP hybrid engine
├── index.html       ← Frontend (single file, no build step)
├── start.bat        ← Starts Notion MCP server + Python backend
├── .env.example     ← Config template (copy to .env)
├── .gitignore
├── requirements.txt
└── README.md
```

---

## Why Use a Notion MCP Layer?

OneTask uses a Notion MCP integration layer alongside the Notion REST API. The MCP layer gives the AI agent tool-based access to read page content, write daily checklist blocks, and clean up old plans. The REST API handles database property updates (Status, Priority, Notes) where the MCP layer can hit validation edge cases.

In practice, OneTask uses a hybrid strategy: try MCP first, fall back to REST if needed, return a unified result either way.

---

## Current Limitations

- Built for a specific Notion database schema (`Name`, `Status`, `Priority`, `Notes`)
- Single-user local setup — not a hosted service
- Focus switching logic is LLM-guided, not deterministic policy enforcement
- Changes made inside the app are written to Notion immediately, but external edits in Notion require a manual sync
- Windows only (`start.bat`) — Mac/Linux require manual setup

---

## License

MIT

---

*Submitted to the Notion MCP Challenge — March 2026*
