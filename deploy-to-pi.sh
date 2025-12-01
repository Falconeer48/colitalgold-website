#!/bin/bash

# Deploy ColitasGold Website to Raspberry Pi
# Run this from your Mac

PI_IP="192.168.50.243"
PI_USER="ian"
WEBSITE_PATH="/Volumes/M2 Drive/colitasgold-website"
PI_DEST="/home/pi/colitasgold-website"

echo "=========================================="
echo "Deploying ColitasGold Website to Pi"
echo "Pi IP: $PI_IP"
echo "=========================================="
echo ""

# Check if website folder exists
if [ ! -d "$WEBSITE_PATH" ]; then
    echo "ERROR: Website folder not found at: $WEBSITE_PATH"
    exit 1
fi

# Test connection to Pi
echo "Testing connection to Pi..."
if ping -c 1 $PI_IP &> /dev/null; then
    echo "✓ Pi is reachable"
else
    echo "✗ Cannot reach Pi at $PI_IP"
    echo "Please check:"
    echo "  1. Pi is powered on"
    echo "  2. Pi is connected to network"
    echo "  3. IP address is correct"
    exit 1
fi

# Transfer files
echo ""
echo "Transferring website files to Pi..."
echo "You may be prompted for the Pi password..."

scp -r "$WEBSITE_PATH" ${PI_USER}@${PI_IP}:${PI_DEST}

if [ $? -eq 0 ]; then
    echo "✓ Files transferred successfully"
else
    echo "✗ Transfer failed"
    exit 1
fi

echo ""
echo "=========================================="
echo "Files transferred!"
echo "=========================================="
echo ""
echo "Next steps on your Pi:"
echo "1. SSH into your Pi: ssh ${PI_USER}@${PI_IP}"
echo "   (Password: You'll enter it when prompted)"
echo "2. Run the setup script:"
echo "   cd ~/colitasgold-website"
echo "   chmod +x setup-pi.sh"
echo "   sudo ./setup-pi.sh"
echo ""
echo "Or run these commands on your Pi:"
echo "   sudo apt update"
echo "   sudo apt install apache2 -y"
echo "   sudo cp -r ~/colitasgold-website /var/www/html/colitasgold"
echo "   sudo chown -R www-data:www-data /var/www/html/colitasgold"
echo "   sudo chmod -R 755 /var/www/html/colitasgold"
echo "   sudo systemctl restart apache2"
echo ""
echo "Then access at: http://${PI_IP}/colitasgold/"
echo ""

