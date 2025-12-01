# Making Your Website Accessible from the Internet

Your website is now running on port 8081 locally. Here's how to make it accessible from anywhere in the world.

---

## Option 1: ngrok (Easiest - Works Immediately) ⭐ RECOMMENDED

### Setup Steps:

1. **Install ngrok on your Pi:**

```bash
cd ~
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz
tar xvzf ngrok-v3-stable-linux-arm64.tgz
sudo mv ngrok /usr/local/bin/
```

2. **Sign up for free account:**
   - Go to: https://ngrok.com/
   - Sign up (free)
   - Get your authtoken from dashboard

3. **Configure ngrok:**

```bash
ngrok config add-authtoken YOUR_AUTH_TOKEN
```

4. **Start ngrok tunnel:**

```bash
ngrok http 8081
```

5. **You'll get a URL like:**
   ```
   https://abc123.ngrok-free.app
   ```

**Share this URL with anyone!** They can access your website.

**Note:** Free ngrok URLs change each time you restart. For permanent URL, upgrade to paid plan or use Option 2.

---

## Option 2: Port Forwarding (Permanent Solution)

### Step 1: Configure Router

1. **Find your router's IP:**
   ```bash
   # On your Mac or Pi
   ip route | grep default
   # Usually 192.168.1.1 or 192.168.50.1
   ```

2. **Log into router:**
   - Open browser: `http://192.168.50.1` (or your router IP)
   - Enter admin username/password

3. **Find Port Forwarding:**
   - Look for: "Port Forwarding", "Virtual Server", or "NAT"
   - Usually under "Advanced" or "Firewall"

4. **Add port forward rule:**
   - **External Port:** 8081 (or any port you want, like 80)
   - **Internal IP:** 192.168.50.243 (your Pi)
   - **Internal Port:** 8081
   - **Protocol:** TCP
   - **Description:** ColitasGold Website

5. **Save settings**

### Step 2: Find Your Public IP

```bash
# On your Pi or Mac
curl ifconfig.me
```

### Step 3: Access from Internet

People can access your website at:
```
http://YOUR_PUBLIC_IP:8081
```

**Example:**
```
http://123.45.67.89:8081
```

### Step 4: Set Up Dynamic DNS (If IP Changes)

If your public IP changes, use Dynamic DNS:

1. **Sign up for DuckDNS (free):**
   - Go to: https://www.duckdns.org/
   - Create account
   - Create a subdomain: `yourname.duckdns.org`

2. **Install DuckDNS on Pi:**

```bash
cd ~
git clone https://github.com/linux-update/duckdns.git
cd duckdns
sudo ./duck.sh
```

Follow the prompts to set up.

3. **Access via domain:**
```
http://yourname.duckdns.org:8081
```

---

## Option 3: Cloudflare Tunnel (Free, Secure)

### Setup:

1. **Install cloudflared on Pi:**

```bash
cd ~
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
chmod +x cloudflared-linux-arm64
sudo mv cloudflared-linux-arm64 /usr/local/bin/cloudflared
```

2. **Login and create tunnel:**

```bash
cloudflared tunnel login
cloudflared tunnel create colitasgold
cloudflared tunnel route dns colitasgold yourname.yourdomain.com
```

3. **Run tunnel:**

```bash
cloudflared tunnel --url http://localhost:8081
```

---

## Option 4: Use Your Own Domain Name

If you have a domain name:

1. **Point DNS to your public IP:**
   - Add A record: `@` → `YOUR_PUBLIC_IP`
   - Add A record: `www` → `YOUR_PUBLIC_IP`

2. **Configure router port forwarding** (see Option 2)

3. **Access at:**
   ```
   http://yourdomain.com:8081
   ```

4. **Set up HTTPS (optional but recommended):**
   ```bash
   # Install certbot on Pi
   sudo apt install certbot python3-certbot-apache
   
   # Get SSL certificate
   sudo certbot --standalone -d yourdomain.com
   ```

---

## Quick Start Recommendation

**For immediate access:** Use **Option 1 (ngrok)** - it works in 2 minutes!

**For permanent access:** Use **Option 2 (Port Forwarding)** + Dynamic DNS

---

## Security Considerations

⚠️ **Important Security Tips:**

1. **Firewall:** Make sure your Pi's firewall allows the port:
   ```bash
   sudo ufw allow 8081/tcp
   ```

2. **Strong Passwords:** Ensure your Pi has strong passwords

3. **Keep Updated:**
   ```bash
   sudo apt update && sudo apt upgrade
   ```

4. **HTTPS:** Consider setting up HTTPS for secure access

---

## Which Option Should You Use?

- **Need it working in 5 minutes?** → Use ngrok (Option 1)
- **Want permanent access?** → Use Port Forwarding (Option 2)
- **Want free domain?** → Use DuckDNS with Port Forwarding
- **Already have domain?** → Use Port Forwarding + Your Domain

---

Let me know which option you'd like to set up, and I'll guide you through it step by step!

