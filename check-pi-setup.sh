#!/bin/bash

# Diagnostic script to check what's on the Pi
# Run this ON your Pi (SSH into it first)

echo "=========================================="
echo "Checking Pi Setup"
echo "=========================================="
echo ""

# Check if website files exist
echo "1. Checking if website files exist..."
if [ -d "/var/www/html/colitasgold" ]; then
    echo "   ✓ Found: /var/www/html/colitasgold"
    ls -la /var/www/html/colitasgold/ | head -10
else
    echo "   ✗ NOT FOUND: /var/www/html/colitasgold"
fi

echo ""
echo "2. Checking home directory..."
if [ -d "/home/ian/colitasgold-website" ]; then
    echo "   ✓ Found: /home/ian/colitasgold-website"
else
    echo "   ✗ NOT FOUND: /home/ian/colitasgold-website"
fi

echo ""
echo "3. Checking Apache document root..."
echo "   Document root:"
ls -la /var/www/html/ | head -15

echo ""
echo "4. Checking Apache status..."
sudo systemctl status apache2 | head -5

echo ""
echo "5. Checking what's at /colitasgold/ path..."
echo "   Files in /var/www/html/colitasgold/:"
if [ -d "/var/www/html/colitasgold" ]; then
    ls -la /var/www/html/colitasgold/
else
    echo "   Directory doesn't exist"
fi

echo ""
echo "=========================================="
echo "Diagnostics Complete"
echo "=========================================="

