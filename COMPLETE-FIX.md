# Complete Apache Fix - Remove ALL Port 80 References

The issue is that Apache still has some configuration trying to use port 80. Let's remove ALL references to port 80.

## Option 1: Use the Fix Script (Easiest)

1. Copy script to Pi:
   ```bash
   scp "/Volumes/M2 Drive/colitasgold-website/fix-all-apache-config.sh" ian@192.168.50.243:/home/ian/
   ```

2. Run it:
   ```bash
   ssh ian@192.168.50.243
   chmod +x fix-all-apache-config.sh
   sudo ./fix-all-apache-config.sh
   ```

## Option 2: Manual Complete Fix

### Step 1: Stop Apache completely

```bash
sudo systemctl stop apache2
sudo pkill -9 apache2
```

### Step 2: Edit ports.conf to ONLY use 8080

```bash
sudo nano /etc/apache2/ports.conf
```

**Delete everything and replace with:**

```
# Ports configuration - Only 8080 for ColitasGold
Listen 8080

<IfModule ssl_module>
        Listen 443
</IfModule>
```

Save and exit (Ctrl+X, Y, Enter)

### Step 3: Disable ALL sites

```bash
# List enabled sites
ls -la /etc/apache2/sites-enabled/

# Disable each one
sudo a2dissite 000-default.conf
sudo a2dissite default-ssl.conf
# Disable any others shown
```

### Step 4: Make sure ColitasGold config ONLY uses 8080

```bash
sudo nano /etc/apache2/sites-available/colitasgold.conf
```

**Make sure it says:**

```apache
<VirtualHost *:8080>
    ServerName 192.168.50.243
    DocumentRoot /var/www/html/cg
    
    <Directory /var/www/html/cg>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

**Important: Must be `*:8080` NOT `*:80`**

Save and exit.

### Step 5: Enable ONLY ColitasGold

```bash
sudo a2ensite colitasgold.conf
```

### Step 6: Fix ServerName warning

```bash
echo "ServerName 192.168.50.243" | sudo tee -a /etc/apache2/apache2.conf
```

### Step 7: Test and start

```bash
sudo apache2ctl configtest
sudo systemctl start apache2
sudo systemctl status apache2
```

### Step 8: Verify

```bash
sudo netstat -tlnp | grep apache2
```

Should only show port 8080, not 80.

## Option 3: Use Python Server (Simplest - No Apache)

If Apache keeps causing issues, just use Python:

```bash
cd /var/www/html/cg
sudo python3 -m http.server 8080
```

Keep it running in background:

```bash
cd /var/www/html/cg
nohup sudo python3 -m http.server 8080 > /dev/null 2>&1 &
```

Access at: `http://192.168.50.243:8080/`

---

**I recommend Option 3 (Python server) for simplicity!**

