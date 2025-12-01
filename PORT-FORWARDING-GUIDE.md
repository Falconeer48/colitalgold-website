# Port Forwarding Guide - Make Website Accessible from Internet

## Step-by-Step Instructions

### Step 1: Configure Router Port Forwarding

1. **Find your router's IP address:**
   ```bash
   # On your Mac or Pi
   ip route | grep default
   ```
   Usually: `192.168.50.1` or `192.168.1.1`

2. **Open router admin page:**
   - Open browser
   - Go to: `http://192.168.50.1` (or your router IP)
   - Enter admin username/password
     - Default might be: admin/admin or admin/password
     - Check router sticker or manual

3. **Find Port Forwarding section:**
   - Look for: "Port Forwarding", "Virtual Server", "NAT", or "Firewall"
   - Usually under "Advanced Settings" or "Network"

4. **Add new port forward rule:**
   - Click "Add Rule" or "New Rule"
   - **Service Name:** ColitasGold (or any name)
   - **External Port:** 8081 (or 80 if you want standard web port)
   - **Internal IP:** 192.168.50.243 (your Pi's IP)
   - **Internal Port:** 8081
   - **Protocol:** TCP (or Both)
   - **Enable:** Yes/Checked

5. **Save and apply**

### Step 2: Find Your Public IP

On your Pi or Mac, run:

```bash
curl ifconfig.me
```

This gives you your public IP address (like: `123.45.67.89`)

### Step 3: Test External Access

From another network (or use your phone's mobile data), try:

```
http://YOUR_PUBLIC_IP:8081
```

**Example:**
```
http://123.45.67.89:8081
```

### Step 4: Set Up Dynamic DNS (Optional - If IP Changes)

If your internet provider changes your IP, use Dynamic DNS:

#### Using DuckDNS (Free):

1. **Sign up:**
   - Go to: https://www.duckdns.org/
   - Sign in with Google/GitHub
   - Create subdomain: `yourname.duckdns.org`

2. **Install DuckDNS on Pi:**

```bash
cd ~
mkdir duckdns
cd duckdns
nano duck.sh
```

3. **Paste this content (replace YOUR_TOKEN and YOUR_DOMAIN):**

```bash
#!/bin/bash
echo url="https://www.duckdns.org/update?domains=YOUR_DOMAIN&token=YOUR_TOKEN&ip=" | curl -k -o ~/duckdns/duck.log -K -
```

4. **Save and make executable:**

```bash
chmod +x duck.sh
```

5. **Add to crontab (updates every 5 minutes):**

```bash
crontab -e
```

Add this line:
```
*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1
```

6. **Access via domain:**
```
http://yourname.duckdns.org:8081
```

---

## Router-Specific Instructions

### Common Router Brands:

**TP-Link:**
- Advanced → NAT Forwarding → Port Forwarding

**Netgear:**
- Advanced → Port Forwarding/Port Triggering

**Linksys:**
- Connectivity → Router Settings → Port Forwarding

**Asus:**
- WAN → Virtual Server/Port Forwarding

**D-Link:**
- Advanced → Port Forwarding

---

## Security Checklist

- [ ] Pi firewall allows port: `sudo ufw allow 8081/tcp`
- [ ] Router firewall allows port forwarding
- [ ] Strong passwords on Pi
- [ ] Pi is updated: `sudo apt update && sudo apt upgrade`

---

## Troubleshooting

**Can't access from outside:**
- Check router port forwarding is enabled
- Check Pi firewall: `sudo ufw status`
- Verify public IP: `curl ifconfig.me`
- Try from different network (mobile data)

**Port already forwarded:**
- Check existing rules in router
- Use different external port

**IP keeps changing:**
- Set up Dynamic DNS (DuckDNS)
- Or use ngrok for stable URL

---

## Quick Test

1. Port forward 8081 → 192.168.50.243:8081
2. Get public IP: `curl ifconfig.me`
3. Access: `http://PUBLIC_IP:8081`
4. Done! 🎉

---

Need help with your specific router? Let me know the brand and I can provide detailed instructions!

