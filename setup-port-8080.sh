#!/bin/bash

# Setup ColitasGold on Port 8080
# Run this ON your Pi with: sudo ./setup-port-8080.sh

echo "=========================================="
echo "Setting up ColitasGold on Port 8080"
echo "=========================================="
echo ""

# Copy website files if not already there
if [ ! -d "/var/www/html/cg" ]; then
    echo "Copying website files..."
    if [ -d "/home/ian/colitasgold-website" ]; then
        sudo cp -r /home/ian/colitasgold-website /var/www/html/cg
        sudo chown -R www-data:www-data /var/www/html/cg
        sudo chmod -R 755 /var/www/html/cg
        echo "✓ Files copied"
    else
        echo "ERROR: Website files not found in /home/ian/colitasgold-website"
        exit 1
    fi
else
    echo "✓ Website files already exist"
fi

# Add port 8080 to Apache ports configuration
echo ""
echo "Configuring Apache to listen on port 8080..."

# Check if port 8080 is already in ports.conf
if ! grep -q "Listen 8080" /etc/apache2/ports.conf; then
    echo "Listen 8080" | sudo tee -a /etc/apache2/ports.conf > /dev/null
    echo "✓ Added port 8080 to Apache configuration"
else
    echo "✓ Port 8080 already configured"
fi

# Create Apache virtual host for ColitasGold on port 8080
echo ""
echo "Creating Apache virtual host..."

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

echo "✓ Virtual host created"

# Enable the site
echo ""
echo "Enabling site..."
sudo a2ensite colitasgold.conf > /dev/null 2>&1

# Test Apache configuration
echo ""
echo "Testing Apache configuration..."
sudo apache2ctl configtest

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Configuration is valid"
    echo ""
    echo "Restarting Apache..."
    sudo systemctl restart apache2
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "=========================================="
        echo "Setup Complete!"
        echo "=========================================="
        echo ""
        echo "Your ColitasGold website is now available at:"
        echo "  http://192.168.50.243:8080/"
        echo ""
        echo "The website files are in: /var/www/html/cg"
        echo ""
    else
        echo ""
        echo "✗ Apache restart failed"
        echo "Check error: sudo journalctl -xeu apache2.service | tail -30"
    fi
else
    echo ""
    echo "✗ Configuration test failed"
    echo "Check the errors above"
fi

