#!/bin/bash

# Start Python Server on Port 8081 in Background
# Run this ON your Pi with: sudo ./START-BACKGROUND-8081.sh

PORT=8081
WEBSITE_DIR="/var/www/html/cg"

echo "=========================================="
echo "Starting ColitasGold Website Server (Background)"
echo "=========================================="
echo ""

# Check if website directory exists
if [ ! -d "$WEBSITE_DIR" ]; then
    echo "ERROR: Website directory not found: $WEBSITE_DIR"
    exit 1
fi

# Check if port is in use
if sudo lsof -i :$PORT 2>/dev/null; then
    echo "Port $PORT is in use, trying 8082..."
    PORT=8082
fi

if sudo lsof -i :$PORT 2>/dev/null; then
    echo "Port $PORT is also in use, trying 8083..."
    PORT=8083
fi

# Change to website directory
cd "$WEBSITE_DIR"

# Kill any existing server on this port
sudo pkill -f "python3 -m http.server $PORT" 2>/dev/null

# Start server in background
echo "Starting server on port $PORT in background..."
nohup sudo python3 -m http.server $PORT > /tmp/colitasgold-server.log 2>&1 &

# Wait a moment
sleep 2

# Check if it's running
if sudo lsof -i :$PORT > /dev/null 2>&1; then
    echo ""
    echo "=========================================="
    echo "✓ Server Started Successfully!"
    echo "=========================================="
    echo ""
    echo "Website URL: http://192.168.50.243:$PORT/"
    echo ""
    echo "Server is running in background."
    echo "Log file: /tmp/colitasgold-server.log"
    echo ""
    echo "To stop the server, run:"
    echo "  sudo pkill -f 'python3 -m http.server $PORT'"
    echo ""
    echo "To check if it's running:"
    echo "  sudo lsof -i :$PORT"
    echo ""
else
    echo ""
    echo "✗ Server failed to start"
    echo "Check log: cat /tmp/colitasgold-server.log"
fi

