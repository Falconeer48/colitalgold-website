#!/bin/bash

# Start Python Server on Port 8081
# Run this ON your Pi

PORT=8081
WEBSITE_DIR="/var/www/html/cg"

echo "=========================================="
echo "Starting ColitasGold Website Server"
echo "Port: $PORT"
echo "=========================================="
echo ""

# Check if website directory exists
if [ ! -d "$WEBSITE_DIR" ]; then
    echo "ERROR: Website directory not found: $WEBSITE_DIR"
    exit 1
fi

# Check if port is in use
if sudo lsof -i :$PORT 2>/dev/null; then
    echo "⚠️  Port $PORT is already in use!"
    echo "Trying port 8082 instead..."
    PORT=8082
fi

if sudo lsof -i :$PORT 2>/dev/null; then
    echo "⚠️  Port $PORT is also in use!"
    echo "Trying port 8083 instead..."
    PORT=8083
fi

# Change to website directory
cd "$WEBSITE_DIR"

echo "Starting server on port $PORT..."
echo ""
echo "Your website will be available at:"
echo "  http://192.168.50.243:$PORT/"
echo ""
echo "Press Ctrl+C to stop the server"
echo "=========================================="
echo ""

# Start the server
sudo python3 -m http.server $PORT

