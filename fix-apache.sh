#!/bin/bash

# Fix Apache Error Script
# Run this ON your Pi with: sudo ./fix-apache.sh

echo "=========================================="
echo "Diagnosing Apache Error"
echo "=========================================="
echo ""

# Check Apache status
echo "1. Checking Apache status..."
sudo systemctl status apache2 | head -20

echo ""
echo "2. Checking Apache error logs..."
echo "--- Last 20 lines of error log ---"
sudo tail -20 /var/log/apache2/error.log

echo ""
echo "3. Testing Apache configuration..."
sudo apache2ctl configtest

echo ""
echo "4. Checking for syntax errors..."
sudo apache2ctl -t

echo ""
echo "=========================================="
echo "Common Fixes:"
echo "=========================================="
echo ""
echo "If you see 'Address already in use':"
echo "  - Another service might be using port 80"
echo "  - Check: sudo lsof -i :80"
echo ""
echo "If you see configuration errors:"
echo "  - Check: sudo apache2ctl configtest"
echo "  - Fix any syntax errors shown"
echo ""
echo "To see full error details, run:"
echo "  sudo journalctl -xeu apache2.service | tail -50"
echo ""

