# Fix Apache Restart Error on Port 8080

## Quick Diagnosis

Run these commands on your Pi to see what's wrong:

```bash
# See the exact error
sudo journalctl -xeu apache2.service | tail -50

# Check what's using port 8080
sudo lsof -i :8080

# Check Apache error log
sudo tail -50 /var/log/apache2/error.log

# Check if Apache is already running
ps aux | grep apache2
```

---

## Common Fixes

### Fix 1: Port Already in Use

If port 8080 is already in use, we can:
- Use a different port (8081)
- Stop the service using 8080

**Use port 8081 instead:**

```bash
# Edit ports.conf
sudo nano /etc/apache2/ports.conf
# Change "Listen 8080" to "Listen 8081"

# Edit virtual host
sudo nano /etc/apache2/sites-available/colitasgold.conf
# Change "*:8080" to "*:8081"

# Restart
sudo systemctl restart apache2
```

Then access at: `http://192.168.50.243:8081/`

---

### Fix 2: Stop and Clean Restart

```bash
# Stop Apache completely
sudo systemctl stop apache2

# Kill any stuck processes
sudo pkill -9 apache2

# Wait a moment
sleep 2

# Start fresh
sudo systemctl start apache2

# Check status
sudo systemctl status apache2
```

---

### Fix 3: Check for Configuration Conflicts

```bash
# List all enabled sites
ls -la /etc/apache2/sites-enabled/

# Check if there are conflicting virtual hosts
sudo apache2ctl -S

# Disable default site if needed
sudo a2dissite 000-default.conf
```

---

### Fix 4: Use Python Server Instead (Simplest)

If Apache is too complex, use Python server:

```bash
cd /var/www/html/cg
sudo python3 -m http.server 8080
```

Then access at: `http://192.168.50.243:8080/`

To keep it running in background:

```bash
cd /var/www/html/cg
nohup sudo python3 -m http.server 8080 > /dev/null 2>&1 &
```

---

### Fix 5: Check ServerName Warning

The warning about ServerName is harmless, but we can fix it:

```bash
sudo nano /etc/apache2/apache2.conf
```

Add at the top:
```apache
ServerName 192.168.50.243
```

Save and restart.

---

## Quick Test - Try Different Port

Let's try port 8081 which is less likely to be in use:

```bash
# Change port to 8081
sudo sed -i 's/Listen 8080/Listen 8081/' /etc/apache2/ports.conf
sudo sed -i 's/:8080/:8081/' /etc/apache2/sites-available/colitasgold.conf

# Test and restart
sudo apache2ctl configtest
sudo systemctl restart apache2
```

Then access at: `http://192.168.50.243:8081/`

---

## Recommended: Use Python Server (Easiest)

If Apache keeps causing issues, Python server is simpler:

```bash
cd /var/www/html/cg

# Run in background
nohup python3 -m http.server 8080 > server.log 2>&1 &

# Check if running
ps aux | grep python3
```

Access at: `http://192.168.50.243:8080/`

To stop it later:
```bash
pkill -f "python3 -m http.server 8080"
```

---

Please run the diagnosis commands and share the output so I can help fix the specific issue!

