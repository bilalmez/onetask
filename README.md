# 🎯 OneTask — One Focus. One Week. Everything Else Ignored.

> Submission for the [Notion MCP Challenge](https://dev.to/challenges/notion-2026-03-04)

OneTask connects to your Notion workspace and forces you to focus on **one task per week** — ignoring everything else. It uses AI to break your focus task into daily steps and syncs progress directly to Notion.

---

## How It Works

1. You type your one focus task for the week
2. Gemini AI breaks it into 4 actionable steps
3. Steps are saved to your Notion database automatically
4. Each day, you mark your step as done — Notion updates in real time
5. Everything else in your task list? Ignored completely.

---

## Setup

### 1. Notion Integration Token
- Go to `notion.so/profile/integrations`
- Create a new **Internal Integration** named `OneTask`
- Copy the token (`ntn_...`)

### 2. Notion Database
Create a database with these exact fields:

| Field | Type |
|---|---|
| Task Name | Title |
| Type | Select: `Main Task` / `Subtask` |
| Status | Status: `Not Started` / `In Progress` / `Done` |
| Focus | Checkbox |
| Parent Task | Relation (self-referencing) |
| Week | Date |

Then: open your database → `···` → **Connections** → add `OneTask`

Copy the Database ID from the URL:
```
https://notion.so/YOUR_DATABASE_ID?v=...
```

### 3. Gemini API Key (Free)
- Go to `aistudio.google.com`
- Click **Get API Key** → Create
- Copy the key (`AIza...`)

### 4. Configure `.env`
```bash
cp .env.example .env
```
Fill in your values:
```
NOTION_TOKEN=ntn_...
NOTION_DATABASE_ID=...
GEMINI_API_KEY=AIza...
PORT=3001
```

### 5. Run
```bash
# Create virtual environment
python -m venv venv

# Activate (Windows)
venv\Scripts\activate

# Activate (Mac/Linux)
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Start
python agent.py
```

Open your browser at `http://localhost:3001`

---

## Tech Stack

- **Backend:** Python + FastAPI
- **AI:** Google Gemini 2.5 Flash
- **Database:** Notion via Notion API (MCP)
- **Frontend:** Vanilla HTML/CSS/JS

---

## Notion MCP Integration

This project uses Notion as the single source of truth for all task data:
- Creates Main Tasks with `Focus = true`
- Creates Subtasks linked to the Main Task via Relation
- Updates Status in real time when steps are marked done
- Reads existing tasks to show what's being ignored

*Notion MCP Challenge 2026*
