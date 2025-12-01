#!/bin/bash

# All-in-One HTTPS Setup Commands
# Copy and paste this entire script into your Pi SSH session

DOMAIN="colitasgold.duckdns.org"

echo "=========================================="
echo "Setting up HTTPS for ColitasGold"
echo "=========================================="

# Step 1: Configure Nginx
echo ""
echo "Step 1: Configuring Nginx..."
sudo tee /etc/nginx/sites-available/colitasgold > /dev/null <<EOF
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

# Step 2: Enable site
echo "Step 2: Enabling site..."
sudo ln -sf /etc/nginx/sites-available/colitasgold /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Step 3: Test and restart
echo "Step 3: Testing configuration..."
sudo nginx -t && sudo systemctl restart nginx
echo "✓ Nginx configured"

# Step 4: Install Certbot
echo ""
echo "Step 4: Installing Certbot..."
sudo apt update -qq && sudo apt install -y certbot python3-certbot-nginx -qq
echo "✓ Certbot installed"

# Step 5: Get SSL certificate
echo ""
echo "Step 5: Getting SSL certificate..."
echo "This may take a minute..."
sudo certbot --nginx -d ${DOMAIN} --non-interactive --agree-tos --email admin@${DOMAIN} --redirect

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✓ SUCCESS! HTTPS is now configured!"
    echo "=========================================="
    echo ""
    echo "Your website is available at:"
    echo "  https://${DOMAIN}/"
    echo ""
else
    echo ""
    echo "SSL certificate setup needs manual input."
    echo "Run: sudo certbot --nginx -d ${DOMAIN}"
fi

