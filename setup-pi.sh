#!/bin/bash

# ColitasGold Website Setup Script for Raspberry Pi
# Run this script on your Raspberry Pi

echo "=========================================="
echo "ColitasGold Website Setup for Raspberry Pi"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Update system
echo "Updating system packages..."
apt update -y

# Install Apache
echo "Installing Apache web server..."
apt install apache2 -y

# Enable Apache
systemctl enable apache2
systemctl start apache2

# Check if website folder exists
if [ ! -d "colitasgold-website" ]; then
    echo "ERROR: colitasgold-website folder not found!"
    echo "Please make sure you're in the directory containing the website files"
    exit 1
fi

# Copy website to web directory
echo "Copying website files..."
cp -r colitasgold-website /var/www/html/colitasgold

# Set permissions
echo "Setting permissions..."
chown -R www-data:www-data /var/www/html/colitasgold
chmod -R 755 /var/www/html/colitasgold

# Get Pi's IP address
PI_IP=$(hostname -I | awk '{print $1}')

# Restart Apache
systemctl restart apache2

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Your website is now accessible at:"
echo "  Local: http://localhost/colitasgold/"
echo "  Network: http://$PI_IP/colitasgold/"
echo ""
echo "To make it accessible from the internet:"
echo "  1. Set up port forwarding on your router (port 80)"
echo "  2. Or use ngrok: ngrok http 80"
echo ""
echo "Next steps:"
echo "  - Configure firewall: sudo ufw allow 80"
echo "  - Set up SSL: sudo apt install certbot python3-certbot-apache"
echo ""

