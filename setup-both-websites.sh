#!/bin/bash

# Setup for Both Websites - Photo Portfolio + ColitasGold
# This configures Nginx to serve both websites

echo "=========================================="
echo "Setting up Both Websites on Pi5"
echo "=========================================="
echo ""
echo "Photo Portfolio: Existing setup (keep as-is)"
echo "ColitasGold: HTTPS via DuckDNS"
echo ""

DOMAIN="colitasgold.duckdns.org"

# Check what's currently on port 80
echo "Checking current port 80 setup..."
if sudo netstat -tlnp | grep :80 | grep -q nginx; then
    echo "✓ Nginx is serving on port 80"
elif sudo netstat -tlnp | grep :80 | grep -q apache; then
    echo "✓ Apache is serving on port 80"
else
    echo "⚠️  Something else is using port 80"
fi

echo ""
echo "We'll configure Nginx to handle both:"
echo "  - Photo Portfolio: Existing setup (unchanged)"
echo "  - ColitasGold: https://${DOMAIN}/"
echo ""

# Configure Nginx with both sites
echo "Configuring Nginx for both websites..."

# Create ColitasGold config (HTTPS only, or HTTP that redirects)
cat > /tmp/colitasgold-nginx.conf <<EOF
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

echo ""
echo "Configuration ready!"
echo ""
echo "Your setup options:"
echo ""
echo "Option 1: Photo Portfolio on HTTP, ColitasGold on HTTPS only"
echo "  - Photo portfolio: http://YOUR_IP/ (port 80)"
echo "  - ColitasGold: https://${DOMAIN}/ (port 443)"
echo ""
echo "Option 2: Both accessible via domain routing"
echo "  - Configure Nginx to route by domain name"
echo "  - Photo portfolio on one domain/IP"
echo "  - ColitasGold on ${DOMAIN}"
echo ""
echo "Which photo portfolio setup are you currently using?"
echo "  - Is it served by Apache on port 80?"
echo "  - Is it served by Nginx on port 80?"
echo "  - What's the current setup?"
echo ""

