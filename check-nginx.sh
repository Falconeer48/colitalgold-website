#!/bin/bash

# Check if Nginx is installed and running
# Run this ON your Pi

echo "=========================================="
echo "Checking Nginx Installation"
echo "=========================================="
echo ""

# Check if Nginx is installed
echo "1. Checking if Nginx is installed..."
if command -v nginx &> /dev/null; then
    echo "   ✓ Nginx is installed"
    echo "   Version: $(nginx -v 2>&1)"
else
    echo "   ✗ Nginx is NOT installed"
    echo ""
    echo "   To install: sudo apt install -y nginx"
    exit 1
fi

echo ""
echo "2. Checking Nginx status..."
if systemctl is-active --quiet nginx; then
    echo "   ✓ Nginx is RUNNING"
else
    echo "   ✗ Nginx is NOT running"
    echo ""
    echo "   To start: sudo systemctl start nginx"
fi

echo ""
echo "3. Checking if Nginx starts on boot..."
if systemctl is-enabled --quiet nginx; then
    echo "   ✓ Nginx will start on boot"
else
    echo "   ⚠️  Nginx will NOT start on boot"
    echo ""
    echo "   To enable: sudo systemctl enable nginx"
fi

echo ""
echo "4. Checking what ports Nginx is using..."
if sudo netstat -tlnp 2>/dev/null | grep nginx; then
    sudo netstat -tlnp | grep nginx
else
    echo "   No ports found (Nginx may not be running)"
fi

echo ""
echo "5. Checking Nginx configuration files..."
if [ -d "/etc/nginx" ]; then
    echo "   ✓ Nginx config directory exists: /etc/nginx"
    echo ""
    echo "   Sites available:"
    ls -la /etc/nginx/sites-available/ 2>/dev/null | tail -n +2
    echo ""
    echo "   Sites enabled:"
    ls -la /etc/nginx/sites-enabled/ 2>/dev/null | tail -n +2
else
    echo "   ✗ Nginx config directory not found"
fi

echo ""
echo "=========================================="
echo "Quick Commands:"
echo "=========================================="
echo ""
echo "Start Nginx:      sudo systemctl start nginx"
echo "Stop Nginx:       sudo systemctl stop nginx"
echo "Restart Nginx:    sudo systemctl restart nginx"
echo "Status:           sudo systemctl status nginx"
echo "Test config:      sudo nginx -t"
echo ""

