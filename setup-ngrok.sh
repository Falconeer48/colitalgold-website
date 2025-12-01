#!/bin/bash

# Setup ngrok for External Access
# Run this ON your Pi

echo "=========================================="
echo "Setting up ngrok for External Access"
echo "=========================================="
echo ""

# Check if ngrok is already installed
if command -v ngrok &> /dev/null; then
    echo "✓ ngrok is already installed"
    echo ""
    echo "To start ngrok tunnel, run:"
    echo "  ngrok http 8081"
    echo ""
    exit 0
fi

# Download ngrok
echo "Downloading ngrok..."
cd ~
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz

if [ $? -ne 0 ]; then
    echo "✗ Download failed. Trying alternative URL..."
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.tgz
    ARCHIVE="ngrok-stable-linux-arm64.tgz"
else
    ARCHIVE="ngrok-v3-stable-linux-arm64.tgz"
fi

# Extract
echo "Extracting ngrok..."
tar xvzf $ARCHIVE

# Install
echo "Installing ngrok..."
sudo mv ngrok /usr/local/bin/
chmod +x /usr/local/bin/ngrok

# Clean up
rm -f $ARCHIVE

echo ""
echo "=========================================="
echo "ngrok Installation Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Sign up for free account at: https://ngrok.com/"
echo ""
echo "2. Get your authtoken from the dashboard"
echo ""
echo "3. Configure ngrok:"
echo "   ngrok config add-authtoken YOUR_AUTH_TOKEN"
echo ""
echo "4. Start tunnel:"
echo "   ngrok http 8081"
echo ""
echo "5. Share the URL (like https://abc123.ngrok-free.app)"
echo "   with anyone who wants to access your website!"
echo ""

