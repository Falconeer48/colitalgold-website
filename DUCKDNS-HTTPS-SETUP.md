# Complete DuckDNS + HTTPS Setup Guide

## Prerequisites
- ✅ Port forwarding set up (port 80 and 443 forwarded to your Pi)
- ✅ DuckDNS account created
- ✅ Website running on port 8081

---

## Step 1: Set Up DuckDNS on Your Pi

### Get Your DuckDNS Info

1. Go to: https://www.duckdns.org/
2. Sign in
3. Note your:
   - **Domain name** (e.g., `colitasgold`)
   - **Token** (long string of characters)

### Install and Configure DuckDNS

On your Pi, run:

```bash
# Create directory
mkdir -p ~/duckdns
cd ~/duckdns

# Create update script (replace YOUR_DOMAIN and YOUR_TOKEN)
nano duck.sh
```

**Paste this (replace YOUR_DOMAIN and YOUR_TOKEN):**

```bash
#!/bin/bash
echo url="https://www.duckdns.org/update?domains=YOUR_DOMAIN&token=YOUR_TOKEN&ip=" | curl -k -o ~/duckdns/duck.log -K -
```

**Save and exit** (Ctrl+X, Y, Enter)

```bash
# Make executable
chmod +x duck.sh

# Test it
./duck.sh

# Check result
cat duck.log
```

Should say: `OK`

### Set Up Auto-Update

```bash
# Add to crontab (updates every 5 minutes)
crontab -e
```

**Add this line:**

```
*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1
```

**Save and exit**

---

## Step 2: Install Nginx (Reverse Proxy)

Python's http.server doesn't support HTTPS easily, so we'll use Nginx as a reverse proxy.

```bash
# Update system
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Check status
sudo systemctl status nginx
```

---

## Step 3: Configure Nginx

### Create Nginx Configuration

```bash
sudo nano /etc/nginx/sites-available/colitasgold
```

**Paste this (replace YOUR_DOMAIN with your DuckDNS domain):**

```nginx
server {
    listen 80;
    server_name YOUR_DOMAIN.duckdns.org;

    location / {
        proxy_pass http://localhost:8081;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

**Save and exit**

### Enable Site

```bash
# Create symlink
sudo ln -s /etc/nginx/sites-available/colitasgold /etc/nginx/sites-enabled/

# Remove default site
sudo rm /etc/nginx/sites-enabled/default

# Test configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx
```

---

## Step 4: Configure Port Forwarding (If Not Done)

**Important:** You need to forward TWO ports:

1. **Port 80** (HTTP) → Your Pi IP (192.168.50.243)
2. **Port 443** (HTTPS) → Your Pi IP (192.168.50.243)

In your router:
- Port 80 → 192.168.50.243:80
- Port 443 → 192.168.50.243:443

---

## Step 5: Get SSL Certificate (Let's Encrypt)

### Install Certbot

```bash
sudo apt install -y certbot python3-certbot-nginx
```

### Get Certificate

```bash
sudo certbot --nginx -d YOUR_DOMAIN.duckdns.org
```

**Follow the prompts:**
- Enter email address
- Agree to terms (Y)
- Share email (optional, N is fine)
- Choose redirect HTTP to HTTPS (2)

### Verify It Works

Check certificate:
```bash
sudo certbot certificates
```

Auto-renewal is set up automatically!

---

## Step 6: Access Your HTTPS Website

Your website is now available at:

```
https://YOUR_DOMAIN.duckdns.org/
```

**Example:**
```
https://colitasgold.duckdns.org/
```

---

## Troubleshooting

### DuckDNS Not Updating

```bash
# Test manually
cd ~/duckdns
./duck.sh
cat duck.log

# Check crontab
crontab -l
```

### SSL Certificate Fails

1. **Check port forwarding:**
   - Port 80 and 443 must be forwarded
   - Can test: `curl http://YOUR_DOMAIN.duckdns.org`

2. **Check Nginx is running:**
   ```bash
   sudo systemctl status nginx
   ```

3. **Check firewall:**
   ```bash
   sudo ufw allow 80/tcp
   sudo ufw allow 443/tcp
   ```

### Website Not Loading Over HTTPS

1. **Check Nginx config:**
   ```bash
   sudo nginx -t
   sudo systemctl restart nginx
   ```

2. **Check Python server is running:**
   ```bash
   ps aux | grep "python3 -m http.server 8081"
   ```

3. **Check logs:**
   ```bash
   sudo tail -f /var/log/nginx/error.log
   ```

---

## Quick Setup Script

I've created a setup script. Transfer it to your Pi and run:

```bash
# From your Mac
scp "/Volumes/M2 Drive/colitasgold-website/setup-duckdns-https.sh" ian@192.168.50.243:/home/ian/

# On Pi
ssh ian@192.168.50.243
chmod +x setup-duckdns-https.sh
sudo ./setup-duckdns-https.sh
```

---

## Summary

After setup, you'll have:

- ✅ DuckDNS domain: `yourdomain.duckdns.org`
- ✅ HTTPS enabled: `https://yourdomain.duckdns.org/`
- ✅ Automatic SSL renewal
- ✅ DuckDNS auto-updates every 5 minutes

**Your website URL:**
```
https://YOUR_DOMAIN.duckdns.org/
```

---

Need help with any step? Let me know!

