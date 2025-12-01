# Run HTTPS Setup - Quick Instructions

## Transfer and Run the Setup Script

### Step 1: Transfer script to your Pi

From your Mac, run:

```bash
scp "/Volumes/M2 Drive/colitasgold-website/complete-https-setup.sh" ian@192.168.50.243:/home/ian/
```

### Step 2: Run the script on your Pi

SSH into your Pi:

```bash
ssh ian@192.168.50.243
```

Then run:

```bash
cd ~
chmod +x complete-https-setup.sh
sudo ./complete-https-setup.sh
```

The script will:
1. ✅ Update system packages
2. ✅ Configure Nginx for your website
3. ✅ Enable the site
4. ✅ Install Certbot (if needed)
5. ✅ Get SSL certificate automatically

### Step 3: Follow prompts

When it asks for SSL certificate:
- It will run automatically
- If it needs email, it will use admin@colitasgold.duckdns.org
- It will automatically set up redirect from HTTP to HTTPS

### Step 4: Test your HTTPS website

After completion, access:
```
https://colitasgold.duckdns.org/
```

---

## Manual Steps (if script doesn't work)

### 1. Configure Nginx

```bash
sudo nano /etc/nginx/sites-available/colitasgold
```

Paste:
```nginx
server {
    listen 80;
    server_name colitasgold.duckdns.org;
    location / {
        proxy_pass http://localhost:8081;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

Save and exit.

### 2. Enable site

```bash
sudo ln -s /etc/nginx/sites-available/colitasgold /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx
```

### 3. Get SSL certificate

```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d colitasgold.duckdns.org
```

Follow prompts, choose option 2 for redirect.

---

## Before Running

Make sure:
- ✅ Port 80 is forwarded in router → 192.168.50.243:80
- ✅ Port 443 is forwarded in router → 192.168.50.243:443
- ✅ Python server is running on port 8081
- ✅ DuckDNS is working (tested with "OK")

---

Ready? Transfer and run the script!

