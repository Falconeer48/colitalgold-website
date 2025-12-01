#!/bin/bash

# Quick Deploy Script - Run this from your Mac
# Username: ian
# It will prompt you for your Pi password

echo "=========================================="
echo "Deploying ColitasGold Website to Pi"
echo "Pi IP: 192.168.50.243"
echo "Username: ian"
echo "=========================================="
echo ""
echo "You will be prompted for your Pi password"
echo ""

# Transfer files
scp -r "/Volumes/M2 Drive/colitasgold-website" ian@192.168.50.243:/home/ian/

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Files transferred successfully!"
    echo ""
    echo "Next step: SSH into your Pi and run setup:"
    echo ""
    echo "  ssh ian@192.168.50.243"
    echo "  cd ~/colitasgold-website"
    echo "  chmod +x setup-on-pi.sh"
    echo "  sudo ./setup-on-pi.sh"
    echo ""
else
    echo ""
    echo "✗ Transfer failed. Please check:"
    echo "  - Pi is powered on"
    echo "  - Pi is connected to network"
    echo "  - SSH is enabled on Pi"
    echo "  - Password is correct (you entered it when prompted)"
    echo ""
fi
