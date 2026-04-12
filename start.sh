#!/usr/bin/env bash

echo ""
echo " =========================================="
echo "   OneTask - Notion MCP Edition"
echo " =========================================="
echo ""

cd "$(dirname "$0")"

if [ ! -f ".env" ]; then
    echo " ERROR: .env file not found!"
    echo " Copy .env.example to .env and fill in your keys."
    exit 1
fi

NOTION_TOKEN=$(grep -E "^NOTION_TOKEN=" .env | cut -d'=' -f2-)

if [ -z "$NOTION_TOKEN" ]; then
    echo " ERROR: NOTION_TOKEN not found in .env file!"
    exit 1
fi

if [ ! -d "venv" ]; then
    echo " Creating virtual environment..."
    python3 -m venv venv
fi

source venv/bin/activate
pip install -r requirements.txt --quiet

echo ""
echo " Starting Notion MCP Server on port 3000..."
export NOTION_TOKEN="$NOTION_TOKEN"
npx -y @notionhq/notion-mcp-server --transport http --port 3000 --disable-auth &
MCP_PID=$!

echo " Waiting for MCP Server to start..."
sleep 5

echo " Starting OneTask on port 3001..."
echo " Open: http://localhost:3001"
echo ""

# Open browser automatically
if command -v open &> /dev/null; then
    # macOS
    sleep 2 && open "http://localhost:3001" &
elif command -v xdg-open &> /dev/null; then
    # Linux
    sleep 2 && xdg-open "http://localhost:3001" &
fi

python3 agent.py

# Cleanup MCP server on exit
kill $MCP_PID 2>/dev/null
