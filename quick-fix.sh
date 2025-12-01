#!/bin/bash

# Quick Fix Script - Run this ON your Pi
# This will install ColitasGold at a new path to avoid conflicts

echo "=========================================="
echo "Installing ColitasGold Website"
echo "=========================================="
echo ""

# Check if files exist in home directory
if [ ! -d "/home/ian/colitasgold-website" ]; then
    echo "ERROR: Website files not found in /home/ian/colitasgold-website"
    echo "Please transfer files first using DEPLOY-NOW.sh from your Mac"
    exit 1
fi

# Copy to web directory with different name to avoid conflict
echo "Copying website files..."
sudo cp -r /home/ian/colitasgold-website /var/www/html/cg

# Set permissions
echo "Setting permissions..."
sudo chown -R www-data:www-data /var/www/html/cg
sudo chmod -R 755 /var/www/html/cg

# Restart Apache
echo "Restarting Apache..."
sudo systemctl restart apache2

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "Your ColitasGold website is now available at:"
echo "  http://192.168.50.243/cg/"
echo ""
echo "Or if you prefer a different path, we can change it."
echo ""

