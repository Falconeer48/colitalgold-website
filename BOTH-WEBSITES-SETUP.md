# Setting Up Both Websites - Photo Portfolio + ColitasGold

## The Situation

You have:
- **Photo Portfolio** - Already running (probably on port 80)
- **ColitasGold** - Want to add with HTTPS

**Problem:** Only one service can use port 80 at a time.

---

## Solution Options

### Option 1: Photo Portfolio on HTTP, ColitasGold on HTTPS Only (RECOMMENDED)

**Setup:**
- Photo Portfolio: Keep existing setup on port 80 (HTTP)
- ColitasGold: Use HTTPS only (port 443)

**Benefits:**
- No changes to existing photo portfolio
- ColitasGold gets HTTPS
- Both work independently

**Configuration:**

1. **Keep photo portfolio as-is** (don't change anything)

2. **Configure ColitasGold for HTTPS only:**

Create Nginx config that only handles HTTPS:

```bash
sudo nano /etc/nginx/sites-available/colitasgold
```

Paste:

```nginx
server {
    listen 443 ssl;
    server_name colitasgold.duckdns.org;

    ssl_certificate /etc/letsencrypt/live/colitasgold.duckdns.org/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/colitasgold.duckdns.org/privkey.pem;

    location / {
        proxy_pass http://localhost:8081;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

3. **Get SSL certificate:**

```bash
sudo certbot certonly --standalone -d colitasgold.duckdns.org
```

4. **Enable site:**

```bash
sudo ln -s /etc/nginx/sites-available/colitasgold /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

**Result:**
- Photo portfolio: `http://YOUR_IP/` (port 80) - unchanged
- ColitasGold: `https://colitasgold.duckdns.org/` (port 443)

---

### Option 2: Use Domain-Based Routing (If Both Use Nginx)

If both websites use Nginx, configure domain-based routing:

**Photo Portfolio Config:**

```nginx
server {
    listen 80;
    server_name YOUR_PHOTO_DOMAIN_OR_IP;

    # Your existing photo portfolio config
    root /var/www/html/photoportfolio;
    # ... rest of your config
}
```

**ColitasGold Config:**

```nginx
server {
    listen 80;
    server_name colitasgold.duckdns.org;

    location / {
        proxy_pass http://localhost:8081;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Both can use port 80 because Nginx routes by domain name.

---

### Option 3: Different Ports

**Setup:**
- Photo Portfolio: Port 80 (existing)
- ColitasGold: Port 8081 (already set up) or different port

**Access:**
- Photo Portfolio: `http://YOUR_IP/`
- ColitasGold: `http://YOUR_IP:8081/` or `https://colitasgold.duckdns.org/`

---

## What's Your Current Photo Portfolio Setup?

To give you the best solution, I need to know:

1. **What serves your photo portfolio?**
   - Apache?
   - Nginx?
   - Python server?
   - Something else?

2. **How do you access it?**
   - IP address?
   - Domain name?
   - What port?

3. **What port is it using?**
   - Port 80?
   - Different port?

---

## My Recommendation

**Use Option 1** - Keep photo portfolio on HTTP (port 80), set up ColitasGold on HTTPS only (port 443).

This way:
- ✅ No disruption to existing photo portfolio
- ✅ ColitasGold gets secure HTTPS
- ✅ Both work independently
- ✅ Simplest setup

Would you like me to help you set up Option 1? Just let me know what your photo portfolio setup is!

