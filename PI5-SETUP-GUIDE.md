# Setting Up ColitasGold Website on Raspberry Pi 5

## Overview
This guide will help you host your ColitasGold website on your Raspberry Pi 5 and make it accessible from the internet.

---

## Step 1: Transfer Files to Raspberry Pi

### Option A: Using SCP (Secure Copy)

From your Mac terminal:

```bash
# Replace 'pi' with your Pi username, and '192.168.1.XXX' with your Pi's IP address
scp -r "/Volumes/M2 Drive/colitasgold-website" pi@YOUR_PI_IP:/home/pi/
```

Or if you want to put it in the web directory directly:

```bash
scp -r "/Volumes/M2 Drive/colitasgold-website" pi@YOUR_PI_IP:/var/www/html/
```

### Option B: Using USB Drive
1. Copy the entire `colitasgold-website` folder to a USB drive
2. Plug USB into Pi
3. Copy files: `sudo cp -r /media/pi/USB_NAME/colitasgold-website /var/www/html/`

### Option C: Using Git (Recommended)
1. Create a GitHub repository
2. Push your website files to GitHub
3. On Pi: `git clone https://github.com/YOUR-USERNAME/colitasgold-website.git`

---

## Step 2: Set Up Web Server on Pi

### Option A: Apache (Easiest)

```bash
# Install Apache
sudo apt update
sudo apt install apache2 -y

# Copy website files
sudo cp -r ~/colitasgold-website /var/www/html/colitasgold

# Set permissions
sudo chown -R www-data:www-data /var/www/html/colitasgold
sudo chmod -R 755 /var/www/html/colitasgold

# Restart Apache
sudo systemctl restart apache2
```

**Access locally on Pi:** `http://localhost/colitasgold/`  
**Access from your network:** `http://YOUR_PI_IP/colitasgold/`

### Option B: Nginx (Lightweight)

```bash
# Install Nginx
sudo apt update
sudo apt install nginx -y

# Copy website files
sudo cp -r ~/colitasgold-website /var/www/html/colitasgold

# Set permissions
sudo chown -R www-data:www-data /var/www/html/colitasgold
sudo chmod -R 755 /var/www/html/colitasgold

# Restart Nginx
sudo systemctl restart nginx
```

**Access locally on Pi:** `http://localhost/colitasgold/`  
**Access from your network:** `http://YOUR_PI_IP/colitasgold/`

### Option C: Python Simple Server (Quick Test)

```bash
cd ~/colitasgold-website
python3 -m http.server 8000
```

**Access:** `http://YOUR_PI_IP:8000`

---

## Step 3: Make It Accessible from the Internet

### Option A: Port Forwarding (Full Control)

1. **Find your Pi's local IP:**
   ```bash
   hostname -I
   ```

2. **Configure Router Port Forwarding:**
   - Log into your router (usually 192.168.1.1 or 192.168.0.1)
   - Find "Port Forwarding" or "Virtual Server"
   - Forward port 80 (HTTP) or 443 (HTTPS) to your Pi's IP
   - Example: External Port 80 → Internal IP (Pi) Port 80

3. **Find your public IP:**
   ```bash
   curl ifconfig.me
   ```

4. **Access from anywhere:**
   - `http://YOUR_PUBLIC_IP/colitasgold/`

5. **Set up Dynamic DNS (if IP changes):**
   - Use services like DuckDNS (free) or No-IP
   - Get a domain like: `yourname.duckdns.org`

### Option B: ngrok (Easiest, No Router Config)

```bash
# Install ngrok on Pi
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz
tar xvzf ngrok-v3-stable-linux-arm64.tgz
sudo mv ngrok /usr/local/bin

# Sign up at ngrok.com (free) and get your authtoken
ngrok config add-authtoken YOUR_AUTH_TOKEN

# Start ngrok tunnel
ngrok http 80
# Or if using Python server on port 8000:
ngrok http 8000
```

**Access:** ngrok will give you a URL like `https://abc123.ngrok.io`

### Option C: Cloudflare Tunnel (Free, Secure)

```bash
# Install cloudflared
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 -o cloudflared
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin

# Create tunnel
cloudflared tunnel create colitasgold

# Run tunnel
cloudflared tunnel --url http://localhost:80
```

---

## Step 4: Set Up Domain Name (Optional)

### Free Options:
1. **Freenom** - Free .tk, .ml, .ga domains
2. **DuckDNS** - Free subdomain (yourname.duckdns.org)
3. **No-IP** - Free dynamic DNS

### Paid Options:
- Namecheap, Google Domains, etc.

### Point Domain to Your Pi:
- If using port forwarding: Point A record to your public IP
- If using ngrok: Use ngrok's domain or point your domain to ngrok

---

## Step 5: Set Up HTTPS (SSL Certificate) - Recommended

### Using Let's Encrypt (Free):

```bash
# Install Certbot
sudo apt install certbot python3-certbot-apache -y

# Get certificate (replace with your domain)
sudo certbot --apache -d yourdomain.com -d www.yourdomain.com

# Auto-renewal is set up automatically
```

---

## Quick Setup Script

I can create a setup script that does all of this automatically. Would you like me to create it?

---

## Access URLs Summary

Once set up, you can access your website:

- **Local (on Pi):** `http://localhost/colitasgold/`
- **Local Network:** `http://192.168.1.XXX/colitasgold/`
- **Internet (Port Forwarding):** `http://YOUR_PUBLIC_IP/colitasgold/`
- **Internet (ngrok):** `https://abc123.ngrok.io`
- **Internet (Domain):** `https://yourdomain.com`

---

## Troubleshooting

### Can't access from network:
- Check firewall: `sudo ufw allow 80`
- Check Apache/Nginx is running: `sudo systemctl status apache2`
- Check Pi's IP: `hostname -I`

### Permission errors:
```bash
sudo chown -R www-data:www-data /var/www/html/colitasgold
sudo chmod -R 755 /var/www/html/colitasgold
```

### Port 80 already in use:
- Check what's using it: `sudo lsof -i :80`
- Stop conflicting service or use different port

---

## Next Steps

1. **Choose your method** (Apache/Nginx/Python)
2. **Transfer files** to Pi
3. **Set up web access** (port forwarding or ngrok)
4. **Test access** from your phone/another computer
5. **Set up domain** (optional but recommended)

Let me know which method you prefer and I can create specific scripts for your setup!

