#!/bin/bash

# Setup DuckDNS and HTTPS for ColitasGold Website
# Run this ON your Pi

echo "=========================================="
echo "Setting up DuckDNS and HTTPS"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run with sudo: sudo ./setup-duckdns-https.sh"
    exit 1
fi

echo "STEP 1: Setting up DuckDNS"
echo "---------------------------"
echo ""

# Get DuckDNS info from user
read -p "Enter your DuckDNS domain (e.g., colitasgold): " DUCKDNS_DOMAIN
read -p "Enter your DuckDNS token: " DUCKDNS_TOKEN

# Create duckdns directory
mkdir -p ~/duckdns
cd ~/duckdns

# Create update script
cat > duck.sh <<EOF
#!/bin/bash
echo url="https://www.duckdns.org/update?domains=${DUCKDNS_DOMAIN}&token=${DUCKDNS_TOKEN}&ip=" | curl -k -o ~/duckdns/duck.log -K -
EOF

chmod +x duck.sh

# Test DuckDNS update
echo ""
echo "Testing DuckDNS update..."
bash duck.sh
if [ $? -eq 0 ]; then
    echo "✓ DuckDNS update successful"
    cat duck.log
else
    echo "✗ DuckDNS update failed. Check your token and domain."
    exit 1
fi

# Add to crontab for auto-update
echo ""
echo "Setting up automatic DuckDNS updates (every 5 minutes)..."
(crontab -l 2>/dev/null | grep -v "duck.sh"; echo "*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1") | crontab -
echo "✓ Crontab updated"

echo ""
echo "STEP 2: Installing Certbot for SSL Certificate"
echo "-----------------------------------------------"
echo ""

apt update -y
apt install -y certbot python3-certbot-nginx

if command -v certbot &> /dev/null; then
    echo "✓ Certbot installed"
else
    echo "✗ Certbot installation failed"
    exit 1
fi

echo ""
echo "STEP 3: Installing Nginx as Reverse Proxy"
echo "------------------------------------------"
echo ""

apt install -y nginx

echo ""
echo "STEP 4: Configuring Nginx"
echo "-------------------------"
echo ""

# Create Nginx configuration
DOMAIN="${DUCKDNS_DOMAIN}.duckdns.org"

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

# Enable site
ln -sf /etc/nginx/sites-available/colitasgold /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test Nginx config
nginx -t

if [ $? -eq 0 ]; then
    systemctl restart nginx
    systemctl enable nginx
    echo "✓ Nginx configured and started"
else
    echo "✗ Nginx configuration error"
    exit 1
fi

echo ""
echo "STEP 5: Getting SSL Certificate"
echo "--------------------------------"
echo ""

echo "Getting SSL certificate from Let's Encrypt..."
echo "You'll need to verify domain ownership."
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
    echo "Certificate auto-renewal is configured."
    echo ""
else
    echo ""
    echo "✗ SSL certificate setup failed"
    echo "You can try manually:"
    echo "  sudo certbot --nginx -d ${DOMAIN}"
    exit 1
fi

