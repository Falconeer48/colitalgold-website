#!/bin/bash

# Fix Apache Port 80 Conflict - Make Apache only use 8080
# Run this ON your Pi with: sudo ./fix-port-conflict.sh

echo "=========================================="
echo "Fixing Apache Port Conflict"
echo "=========================================="
echo ""

# Check what's using port 80
echo "1. Checking what's using port 80..."
if sudo lsof -i :80 2>/dev/null; then
    echo "   ⚠️  Port 80 is in use (probably your photo portfolio)"
    echo "   We'll configure Apache to only use port 8080"
else
    echo "   ✓ Port 80 is free"
fi

echo ""
echo "2. Configuring Apache to NOT use port 80..."

# Backup original ports.conf
sudo cp /etc/apache2/ports.conf /etc/apache2/ports.conf.backup

# Comment out Listen 80 and only keep 8080
sudo sed -i 's/^Listen 80/#Listen 80/' /etc/apache2/ports.conf

# Make sure 8080 is in the file
if ! grep -q "^Listen 8080" /etc/apache2/ports.conf; then
    echo "Listen 8080" | sudo tee -a /etc/apache2/ports.conf > /dev/null
fi

echo "   ✓ Port 80 disabled, port 8080 enabled"

echo ""
echo "3. Disabling default site (which uses port 80)..."
sudo a2dissite 000-default.conf 2>/dev/null

echo ""
echo "4. Making sure ColitasGold site is enabled..."
sudo a2ensite colitasgold.conf 2>/dev/null

echo ""
echo "5. Testing Apache configuration..."
sudo apache2ctl configtest

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Configuration is valid"
    echo ""
    echo "6. Starting Apache..."
    sudo systemctl start apache2
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "=========================================="
        echo "Success! Apache is now running"
        echo "=========================================="
        echo ""
        echo "Check status:"
        sudo systemctl status apache2 | head -10
        echo ""
        echo "Your ColitasGold website should now be available at:"
        echo "  http://192.168.50.243:8080/"
        echo ""
    else
        echo ""
        echo "✗ Still having issues. Let's check error log:"
        sudo tail -20 /var/log/apache2/error.log
    fi
else
    echo ""
    echo "✗ Configuration test failed"
fi

echo ""
echo "To check what ports Apache is using:"
echo "  sudo netstat -tlnp | grep apache2"

