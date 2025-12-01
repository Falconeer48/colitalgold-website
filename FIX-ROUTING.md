# Fix Website Routing Issue

It looks like your photo portfolio is showing instead of the ColitasGold website. This usually means:

1. The ColitasGold files weren't copied to the right location
2. Apache is pointing to the wrong directory
3. There's a routing conflict

## Quick Fix Options

### Option 1: Use a Different Path (Easiest)

Install ColitasGold at a different URL path so it doesn't conflict:

**On your Pi, run:**

```bash
# Copy files to a new location
sudo cp -r ~/colitasgold-website /var/www/html/colitasgold-site

# Set permissions
sudo chown -R www-data:www-data /var/www/html/colitasgold-site
sudo chmod -R 755 /var/www/html/colitasgold-site

# Restart Apache
sudo systemctl restart apache2
```

**Then access at:**
```
http://192.168.50.243/colitasgold-site/
```

---

### Option 2: Use a Different Port

Run ColitasGold on a different port (like 8080):

**On your Pi, create a virtual host:**

```bash
sudo nano /etc/apache2/sites-available/colitasgold.conf
```

**Add this content:**

```apache
<VirtualHost *:8080>
    ServerName 192.168.50.243
    DocumentRoot /var/www/html/colitasgold
    
    <Directory /var/www/html/colitasgold>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

**Then enable it:**

```bash
# Enable the site
sudo a2ensite colitasgold.conf

# Enable port 8080
sudo nano /etc/apache2/ports.conf
# Add: Listen 8080

# Restart Apache
sudo systemctl restart apache2
```

**Access at:**
```
http://192.168.50.243:8080/
```

---

### Option 3: Use Subdomain (Requires DNS)

Set up a subdomain like `colitasgold.local` or use your domain.

---

### Option 4: Replace the Photo Portfolio

If you want ColitasGold at `/colitasgold/`, we need to:

1. Check what's currently there
2. Move/backup the photo portfolio
3. Install ColitasGold properly

**Run this diagnostic first:**

```bash
# See what's at that path
ls -la /var/www/html/colitasgold/

# See all sites
ls -la /var/www/html/
```

---

## Diagnostic Steps

**SSH into your Pi and run:**

```bash
# Check if ColitasGold files are there
ls -la /var/www/html/colitasgold/

# Check what Apache is serving
sudo apache2ctl -S

# Check Apache configuration
ls -la /etc/apache2/sites-enabled/
```

---

## Recommended Solution

I recommend **Option 1** - use `/colitasgold-site/` or `/cg/` as the path to avoid conflicts.

Or we can set it up as the default site on a different port.

Which option would you prefer?

