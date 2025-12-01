#!/bin/bash

# Configure Nginx for ColitasGold Website with HTTPS
# Run this ON your Pi

echo "=========================================="
echo "Configuring Nginx for ColitasGold HTTPS"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run with sudo: sudo ./configure-nginx-https.sh"
    exit 1
fi

DOMAIN="colitasgold.duckdns.org"

echo "Domain: $DOMAIN"
echo ""

# Step 1: Create Nginx configuration
echo "1. Creating Nginx configuration..."

cat > /etc/nginx/sites-available/colitasgold <<EOF
server {
    listen 80;
    server_name ${DOMAIN};

    location / {
        proxy_pass http://localhost:8081;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

echo "   ✓ Configuration created"

# Step 2: Enable site
echo ""
echo "2. Enabling site..."
ln -sf /etc/nginx/sites-available/colitasgold /etc/nginx/sites-enabled/

# Remove default site if it exists
if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
    echo "   ✓ Removed default site"
fi

# Step 3: Test configuration
echo ""
echo "3. Testing Nginx configuration..."
nginx -t

if [ $? -ne 0 ]; then
    echo "   ✗ Configuration test failed!"
    exit 1
fi

echo "   ✓ Configuration is valid"

# Step 4: Restart Nginx
echo ""
echo "4. Restarting Nginx..."
systemctl restart nginx

if [ $? -eq 0 ]; then
    echo "   ✓ Nginx restarted successfully"
else
    echo "   ✗ Nginx restart failed"
    exit 1
fi

# Step 5: Check status
echo ""
echo "5. Checking Nginx status..."
systemctl status nginx | head -5

echo ""
echo "=========================================="
echo "Nginx Configuration Complete!"
echo "=========================================="
echo ""
echo "Your website should be accessible at:"
echo "  http://${DOMAIN}/"
echo ""
echo "Next step: Get SSL certificate"
echo "  sudo apt install -y certbot python3-certbot-nginx"
echo "  sudo certbot --nginx -d ${DOMAIN}"
echo ""
echo "Make sure:"
echo "  - Port 80 is forwarded in your router"
echo "  - Port 443 is forwarded in your router (for HTTPS)"
echo "  - Python server is running on port 8081"
echo ""

