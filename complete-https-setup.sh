#!/bin/bash

# Complete HTTPS Setup Script for ColitasGold
# Run this ON your Pi with: sudo ./complete-https-setup.sh

echo "=========================================="
echo "Complete HTTPS Setup for ColitasGold"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run with sudo: sudo ./complete-https-setup.sh"
    exit 1
fi

DOMAIN="colitasgold.duckdns.org"

echo "Setting up HTTPS for: $DOMAIN"
echo ""

# Step 1: Update system
echo "Step 1: Updating system..."
apt update -y > /dev/null 2>&1
echo "✓ System updated"

# Step 2: Configure Nginx
echo ""
echo "Step 2: Configuring Nginx..."
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

echo "✓ Configuration file created"

# Step 3: Enable site
echo ""
echo "Step 3: Enabling site..."
ln -sf /etc/nginx/sites-available/colitasgold /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
echo "✓ Site enabled, default site removed"

# Step 4: Test Nginx configuration
echo ""
echo "Step 4: Testing Nginx configuration..."
if nginx -t > /dev/null 2>&1; then
    echo "✓ Configuration is valid"
else
    echo "✗ Configuration test failed!"
    nginx -t
    exit 1
fi

# Step 5: Restart Nginx
echo ""
echo "Step 5: Restarting Nginx..."
systemctl restart nginx
if systemctl is-active --quiet nginx; then
    echo "✓ Nginx restarted successfully"
else
    echo "✗ Nginx restart failed"
    systemctl status nginx | head -10
    exit 1
fi

# Step 6: Check if Certbot is installed
echo ""
echo "Step 6: Checking Certbot installation..."
if ! command -v certbot &> /dev/null; then
    echo "Installing Certbot..."
    apt install -y certbot python3-certbot-nginx > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✓ Certbot installed"
    else
        echo "✗ Certbot installation failed"
        exit 1
    fi
else
    echo "✓ Certbot is already installed"
fi

# Step 7: Get SSL certificate
echo ""
echo "=========================================="
echo "Step 7: Getting SSL Certificate"
echo "=========================================="
echo ""
echo "This will ask you for:"
echo "  - Email address"
echo "  - Agreement to terms"
echo "  - Option to redirect HTTP to HTTPS (choose 2)"
echo ""
read -p "Press Enter to continue with SSL certificate setup..."
echo ""

certbot --nginx -d ${DOMAIN} --non-interactive --agree-tos --email admin@${DOMAIN} --redirect

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✓ HTTPS Setup Complete!"
    echo "=========================================="
    echo ""
    echo "Your website is now available at:"
    echo "  https://${DOMAIN}/"
    echo ""
    echo "HTTP will automatically redirect to HTTPS"
    echo ""
    echo "Certificate will auto-renew."
    echo ""
    
    # Check certificate
    echo "Certificate status:"
    certbot certificates 2>/dev/null | grep -A 5 "${DOMAIN}" || echo "Checking..."
    
else
    echo ""
    echo "=========================================="
    echo "SSL Certificate Setup Needs Manual Input"
    echo "=========================================="
    echo ""
    echo "Run this command manually:"
    echo "  sudo certbot --nginx -d ${DOMAIN}"
    echo ""
    echo "Follow the prompts to complete setup."
    echo ""
fi

echo ""
echo "Important reminders:"
echo "  ✓ Port 80 forwarded in router"
echo "  ✓ Port 443 forwarded in router"
echo "  ✓ Python server running on port 8081"
echo "  ✓ DuckDNS updating every 5 minutes"
echo ""

