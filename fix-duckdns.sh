#!/bin/bash

# Fix DuckDNS Setup
# Run this ON your Pi

echo "=========================================="
echo "DuckDNS Troubleshooting"
echo "=========================================="
echo ""

echo "Common reasons for 'KO' response:"
echo "1. Wrong token"
echo "2. Wrong domain name"
echo "3. Domain not created in DuckDNS account"
echo "4. Token doesn't match domain"
echo ""

echo "Let's check your setup..."
echo ""

# Read current script
if [ -f ~/duckdns/duck.sh ]; then
    echo "Current duck.sh content:"
    cat ~/duckdns/duck.sh
    echo ""
    
    # Extract domain and token from script
    DOMAIN=$(grep -o 'domains=[^&]*' ~/duckdns/duck.sh | cut -d= -f2)
    TOKEN=$(grep -o 'token=[^&]*' ~/duckdns/duck.sh | cut -d= -f2)
    
    echo "Current domain: $DOMAIN"
    echo "Current token: ${TOKEN:0:10}..." # Show first 10 chars only
    echo ""
fi

echo "To fix this:"
echo ""
echo "1. Go to: https://www.duckdns.org/"
echo "2. Sign in to your account"
echo "3. Check your domain name (should be without .duckdns.org)"
echo "   Example: If your domain is 'colitasgold.duckdns.org',"
echo "            the domain name is just 'colitasgold'"
echo ""
echo "4. Check your token (long string)"
echo ""
echo "5. Re-create the script with correct info:"
echo ""

read -p "Enter your DuckDNS domain name (without .duckdns.org): " NEW_DOMAIN
read -p "Enter your DuckDNS token: " NEW_TOKEN

# Test the update URL manually first
echo ""
echo "Testing DuckDNS update..."
TEST_URL="https://www.duckdns.org/update?domains=${NEW_DOMAIN}&token=${NEW_TOKEN}&ip="
RESPONSE=$(curl -s "$TEST_URL")

echo "Response: $RESPONSE"

if [ "$RESPONSE" = "OK" ]; then
    echo "✓ DuckDNS update successful!"
    echo ""
    echo "Updating duck.sh script..."
    
    # Create new script
    cat > ~/duckdns/duck.sh <<EOF
#!/bin/bash
echo url="https://www.duckdns.org/update?domains=${NEW_DOMAIN}&token=${NEW_TOKEN}&ip=" | curl -k -o ~/duckdns/duck.log -K -
EOF
    
    chmod +x ~/duckdns/duck.sh
    
    echo "✓ Script updated"
    echo ""
    echo "Test again:"
    echo "  ~/duckdns/duck.sh"
    echo "  cat ~/duckdns/duck.log"
    
else
    echo ""
    echo "✗ Still getting error. Check:"
    echo "  1. Domain name is correct (without .duckdns.org)"
    echo "  2. Token is correct (copy from DuckDNS website)"
    echo "  3. Domain exists in your DuckDNS account"
    echo ""
    echo "Go to: https://www.duckdns.org/domains"
    echo "Make sure your domain is listed there"
fi

