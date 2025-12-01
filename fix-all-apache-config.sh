#!/bin/bash

# Complete Apache Fix - Remove ALL port 80 references
# Run this ON your Pi with: sudo ./fix-all-apache-config.sh

echo "=========================================="
echo "Fixing Apache Configuration Completely"
echo "=========================================="
echo ""

# 1. Stop Apache completely
echo "1. Stopping Apache..."
sudo systemctl stop apache2
sudo pkill -9 apache2 2>/dev/null
sleep 2

# 2. Check current ports.conf
echo ""
echo "2. Current ports.conf content:"
cat /etc/apache2/ports.conf
echo ""

# 3. Backup and create new ports.conf with ONLY 8080
echo "3. Creating new ports.conf with only port 8080..."
sudo cp /etc/apache2/ports.conf /etc/apache2/ports.conf.backup2

sudo tee /etc/apache2/ports.conf > /dev/null <<EOF
# Ports configuration - Only 8080 for ColitasGold
Listen 8080

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
EOF

echo "   ✓ ports.conf updated to only use 8080"

# 4. Disable ALL sites
echo ""
echo "4. Disabling all Apache sites..."
for site in /etc/apache2/sites-enabled/*; do
    if [ -f "$site" ]; then
        site_name=$(basename "$site")
        echo "   Disabling: $site_name"
        sudo a2dissite "$site_name" 2>/dev/null
    fi
done

# 5. Enable ONLY ColitasGold site
echo ""
echo "5. Enabling ColitasGold site (port 8080 only)..."
sudo a2ensite colitasgold.conf 2>/dev/null

# 6. Check the ColitasGold virtual host config
echo ""
echo "6. Checking ColitasGold virtual host config..."
if [ -f "/etc/apache2/sites-available/colitasgold.conf" ]; then
    echo "   Current config:"
    cat /etc/apache2/sites-available/colitasgold.conf
    echo ""
    
    # Make sure it ONLY uses 8080
    if grep -q ":80" /etc/apache2/sites-available/colitasgold.conf; then
        echo "   ⚠️  Found port 80 reference, fixing..."
        sudo sed -i 's/:80>/:8080>/g' /etc/apache2/sites-available/colitasgold.conf
    fi
else
    echo "   ⚠️  ColitasGold config not found, creating it..."
    sudo tee /etc/apache2/sites-available/colitasgold.conf > /dev/null <<EOF
<VirtualHost *:8080>
    ServerName 192.168.50.243
    DocumentRoot /var/www/html/cg
    
    <Directory /var/www/html/cg>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog \${APACHE_LOG_DIR}/colitasgold-error.log
    CustomLog \${APACHE_LOG_DIR}/colitasgold-access.log combined
</VirtualHost>
EOF
    sudo a2ensite colitasgold.conf
fi

# 7. Fix ServerName warning
echo ""
echo "7. Fixing ServerName warning..."
if ! grep -q "ServerName" /etc/apache2/apache2.conf; then
    echo "ServerName 192.168.50.243" | sudo tee -a /etc/apache2/apache2.conf > /dev/null
    echo "   ✓ ServerName added"
else
    echo "   ✓ ServerName already exists"
fi

# 8. Test configuration
echo ""
echo "8. Testing Apache configuration..."
sudo apache2ctl configtest

if [ $? -eq 0 ]; then
    echo ""
    echo "9. Starting Apache..."
    sudo systemctl start apache2
    
    sleep 2
    
    # Check status
    if sudo systemctl is-active --quiet apache2; then
        echo ""
        echo "=========================================="
        echo "✓ SUCCESS! Apache is running!"
        echo "=========================================="
        echo ""
        echo "Checking what ports Apache is using:"
        sudo netstat -tlnp | grep apache2
        echo ""
        echo "Apache status:"
        sudo systemctl status apache2 | head -5
        echo ""
        echo "Your website should be available at:"
        echo "  http://192.168.50.243:8080/"
        echo ""
    else
        echo ""
        echo "✗ Apache still not running. Error log:"
        sudo tail -20 /var/log/apache2/error.log
        echo ""
        echo "Full error:"
        sudo journalctl -xeu apache2.service | tail -20
    fi
else
    echo ""
    echo "✗ Configuration test failed"
    sudo apache2ctl configtest
fi

