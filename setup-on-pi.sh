#!/bin/bash

# Setup script to run ON the Raspberry Pi
# This installs Apache and configures the website

echo "=========================================="
echo "ColitasGold Website Setup"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run with sudo: sudo ./setup-on-pi.sh"
    exit 1
fi

# Update system
echo "Updating system packages..."
apt update -y > /dev/null 2>&1

# Install Apache if not installed
if ! command -v apache2 &> /dev/null; then
    echo "Installing Apache web server..."
    apt install apache2 -y
else
    echo "Apache is already installed"
fi

# Enable and start Apache
echo "Starting Apache..."
systemctl enable apache2 > /dev/null 2>&1
systemctl start apache2

# Check if website folder exists in home directory
WEBSITE_SOURCE="/home/ian/colitasgold-website"
WEBSITE_DEST="/var/www/html/colitasgold"

if [ ! -d "$WEBSITE_SOURCE" ]; then
    echo "ERROR: Website folder not found at $WEBSITE_SOURCE"
    echo "Please make sure files are in: ~/colitasgold-website"
    exit 1
fi

# Remove old version if exists
if [ -d "$WEBSITE_DEST" ]; then
    echo "Removing old website version..."
    rm -rf "$WEBSITE_DEST"
fi

# Copy website to web directory
echo "Copying website files to web directory..."
cp -r "$WEBSITE_SOURCE" "$WEBSITE_DEST"

# Set permissions
echo "Setting permissions..."
chown -R www-data:www-data "$WEBSITE_DEST"
chmod -R 755 "$WEBSITE_DEST"

# Configure firewall
echo "Configuring firewall..."
if command -v ufw &> /dev/null; then
    ufw allow 80/tcp > /dev/null 2>&1
    ufw allow 'Apache Full' > /dev/null 2>&1
fi

# Get Pi's IP address
PI_IP=$(hostname -I | awk '{print $1}')

# Restart Apache
echo "Restarting Apache..."
systemctl restart apache2

# Check Apache status
if systemctl is-active --quiet apache2; then
    APACHE_STATUS="✓ Running"
else
    APACHE_STATUS="✗ Not running"
fi

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Website Status: $APACHE_STATUS"
echo ""
echo "Access your website at:"
echo "  Local:    http://localhost/colitasgold/"
echo "  Network:  http://${PI_IP}/colitasgold/"
echo ""
echo "To make it accessible from the internet:"
echo "  1. Set up port forwarding on router (port 80 → ${PI_IP})"
echo "  2. Or use ngrok: ngrok http 80"
echo ""
echo "Files are located at: $WEBSITE_DEST"
echo ""

