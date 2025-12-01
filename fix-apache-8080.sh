#!/bin/bash

# Fix Apache Port 8080 Issue
# Run this ON your Pi with: sudo ./fix-apache-8080.sh

echo "=========================================="
echo "Diagnosing Apache Port 8080 Issue"
echo "=========================================="
echo ""

# Check what's using port 8080
echo "1. Checking if port 8080 is in use..."
if sudo lsof -i :8080 2>/dev/null; then
    echo "   ⚠️  Port 8080 is already in use!"
    echo "   We'll need to stop that service or use a different port"
else
    echo "   ✓ Port 8080 is available"
fi

echo ""
echo "2. Checking Apache error log..."
echo "--- Recent errors ---"
sudo tail -30 /var/log/apache2/error.log

echo ""
echo "3. Checking Apache status..."
sudo systemctl status apache2 | head -20

echo ""
echo "4. Checking if another Apache instance is running..."
ps aux | grep apache2 | grep -v grep

echo ""
echo "5. Testing Apache configuration again..."
sudo apache2ctl configtest

echo ""
echo "=========================================="
echo "Trying to fix common issues..."
echo "=========================================="
echo ""

# Try stopping Apache completely first
echo "Stopping Apache..."
sudo systemctl stop apache2
sleep 2

# Kill any stuck Apache processes
echo "Killing any stuck Apache processes..."
sudo pkill -9 apache2 2>/dev/null
sleep 2

# Check for port conflicts
echo ""
echo "Checking ports..."
sudo netstat -tlnp | grep -E ':(80|8080)'

echo ""
echo "=========================================="
echo "Now try starting Apache:"
echo "=========================================="
echo ""
echo "Run: sudo systemctl start apache2"
echo "Then: sudo systemctl status apache2"
echo ""

