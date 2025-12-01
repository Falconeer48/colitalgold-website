# Setup ColitasGold on Port 8080 - Easy Solution

## Quick Setup (3 Steps)

### Step 1: Transfer the setup script to your Pi

From your Mac, run:

```bash
scp "/Volumes/M2 Drive/colitasgold-website/setup-port-8080.sh" ian@192.168.50.243:/home/ian/
```

Or manually copy the script to your Pi.

### Step 2: Run the setup script on your Pi

SSH into your Pi:

```bash
ssh ian@192.168.50.243
```

Then run:

```bash
cd ~
chmod +x setup-port-8080.sh
sudo ./setup-port-8080.sh
```

### Step 3: Access your website

Open your browser and go to:

```
http://192.168.50.243:8080/
```

---

## Manual Setup (if script doesn't work)

### 1. Copy website files

```bash
sudo cp -r ~/colitasgold-website /var/www/html/cg
sudo chown -R www-data:www-data /var/www/html/cg
sudo chmod -R 755 /var/www/html/cg
```

### 2. Add port 8080 to Apache

```bash
sudo nano /etc/apache2/ports.conf
```

Add this line:
```
Listen 8080
```

Save and exit (Ctrl+X, then Y, then Enter)

### 3. Create virtual host

```bash
sudo nano /etc/apache2/sites-available/colitasgold.conf
```

Add this content:

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

Save and exit.

### 4. Enable site and restart

```bash
sudo a2ensite colitasgold.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
```

### 5. Open firewall (if needed)

```bash
sudo ufw allow 8080/tcp
```

---

## Access Your Website

```
http://192.168.50.243:8080/
```

---

## Troubleshooting

### Can't access on port 8080

```bash
# Check if Apache is listening on 8080
sudo netstat -tlnp | grep 8080

# Check Apache error log
sudo tail -30 /var/log/apache2/error.log

# Test configuration
sudo apache2ctl configtest
```

### Port 8080 already in use

Use a different port (like 8081):
- Change "Listen 8080" to "Listen 8081" in ports.conf
- Change "*:8080" to "*:8081" in the virtual host config

---

That's it! Your website will be on port 8080, separate from your photo portfolio on port 80.

