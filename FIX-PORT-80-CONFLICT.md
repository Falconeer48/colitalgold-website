# Fix Apache Port 80 Conflict

## The Problem

Port 80 is already in use (probably by your photo portfolio). Apache can't start because it's trying to use port 80, which is already taken.

## The Solution

Configure Apache to **only** use port 8080 and **not** use port 80.

## Quick Fix (Run on Your Pi)

```bash
# Disable Apache from using port 80
sudo sed -i 's/^Listen 80/#Listen 80/' /etc/apache2/ports.conf

# Make sure port 8080 is enabled
if ! grep -q "^Listen 8080" /etc/apache2/ports.conf; then
    echo "Listen 8080" | sudo tee -a /etc/apache2/ports.conf
fi

# Disable default site (uses port 80)
sudo a2dissite 000-default.conf

# Test configuration
sudo apache2ctl configtest

# Start Apache
sudo systemctl start apache2

# Check status
sudo systemctl status apache2
```

## Or Use the Fix Script

1. Copy the script to your Pi:
   ```bash
   scp "/Volumes/M2 Drive/colitasgold-website/fix-port-conflict.sh" ian@192.168.50.243:/home/ian/
   ```

2. Run it on your Pi:
   ```bash
   ssh ian@192.168.50.243
   chmod +x fix-port-conflict.sh
   sudo ./fix-port-conflict.sh
   ```

## Manual Fix Steps

### Step 1: Edit ports.conf

```bash
sudo nano /etc/apache2/ports.conf
```

**Comment out or remove this line:**
```
#Listen 80
```

**Make sure this line exists:**
```
Listen 8080
```

Save and exit (Ctrl+X, Y, Enter)

### Step 2: Disable default site

```bash
sudo a2dissite 000-default.conf
```

### Step 3: Enable ColitasGold site

```bash
sudo a2ensite colitasgold.conf
```

### Step 4: Test and start

```bash
sudo apache2ctl configtest
sudo systemctl start apache2
sudo systemctl status apache2
```

## Verify It's Working

Check Apache is listening on port 8080:

```bash
sudo netstat -tlnp | grep apache2
```

You should see:
```
tcp6  0  0 :::8080  :::*  LISTEN  [PID]/apache2
```

## Access Your Website

```
http://192.168.50.243:8080/
```

## What This Does

- **Port 80**: Used by your photo portfolio (unchanged)
- **Port 8080**: Used by ColitasGold website (new)

Apache will only try to use port 8080, so it won't conflict with whatever is using port 80.

---

Try the quick fix commands above and let me know if it works!

