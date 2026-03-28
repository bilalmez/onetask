@echo off
echo.
echo  ==========================================
echo   OneTask - Notion MCP Edition
echo  ==========================================
echo.

cd /d "%~dp0"

IF NOT EXIST ".env" (
    echo  ERROR: .env file not found!
    echo  Copy .env.example to .env and fill in your keys.
    pause
    exit
)

REM Read NOTION_TOKEN from .env file
for /f "usebackq tokens=1,2 delims==" %%a in (".env") do (
    if "%%a"=="NOTION_TOKEN" set NOTION_TOKEN=%%b
)

IF NOT DEFINED NOTION_TOKEN (
    echo  ERROR: NOTION_TOKEN not found in .env file!
    pause
    exit
)

IF NOT EXIST "venv" (
    echo  Creating virtual environment...
    python -m venv venv
)

call venv\Scripts\activate.bat
pip install -r requirements.txt --quiet

echo.
echo  Starting Notion MCP Server on port 3000...
start "Notion MCP" cmd /c "set NOTION_TOKEN=%NOTION_TOKEN% && npx -y @notionhq/notion-mcp-server --transport http --port 3000 --disable-auth"

echo  Waiting for MCP Server to start...
timeout /t 5 /nobreak >nul

echo  Starting OneTask on port 3001...
echo  Open: http://localhost:3001
echo.
python agent.py
pause
