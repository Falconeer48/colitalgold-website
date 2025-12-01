# Quick Setup Guide for Raspberry Pi 5

**Pi IP Address:** 192.168.50.243

## Option 1: Automated Setup (Easiest)

### Step 1: Transfer Files from Your Mac

Open Terminal on your Mac and run:

```bash
cd "/Volumes/M2 Drive/colitasgold-website"
./deploy-to-pi.sh
```

**OR manually:**

```bash
scp -r "/Volumes/M2 Drive/colitasgold-website" ian@192.168.50.243:/home/ian/
```

(Enter your Pi password when prompted)

### Step 2: Setup on Pi

SSH into your Pi:

```bash
ssh ian@192.168.50.243
```

Then run:

```bash
cd ~/colitasgold-website
chmod +x setup-on-pi.sh
sudo ./setup-on-pi.sh
```

### Step 3: Access Your Website

Open browser and go to:
```
http://192.168.50.243/colitasgold/
```

---

## Option 2: Manual Setup

### On Your Mac:

1. Transfer files:
```bash
scp -r "/Volumes/M2 Drive/colitasgold-website" ian@192.168.50.243:/home/ian/
```

### On Your Pi (SSH into it):

```bash
ssh ian@192.168.50.243
```

Then run these commands:

```bash
# Update system
sudo apt update

# Install Apache
sudo apt install apache2 -y

# Copy website to web directory
sudo cp -r ~/colitasgold-website /var/www/html/colitasgold

# Set permissions
sudo chown -R www-data:www-data /var/www/html/colitasgold
sudo chmod -R 755 /var/www/html/colitasgold

# Restart Apache
sudo systemctl restart apache2

# Check status
sudo systemctl status apache2
```

### Access Your Website:

Open browser:
```
http://192.168.50.243/colitasgold/
```

---

## Troubleshooting

### Can't connect to Pi:
- Make sure Pi is powered on
- Check Pi is on same network
- Verify IP: `ping 192.168.50.243`

### Permission denied:
- Make sure SSH is enabled on Pi: `sudo raspi-config` → Interface Options → SSH → Enable

### Website not loading:
- Check Apache is running: `sudo systemctl status apache2`
- Check firewall: `sudo ufw allow 80`
- Check files exist: `ls -la /var/www/html/colitasgold/`

---

## Next: Make It Accessible from Internet

See `PI5-SETUP-GUIDE.md` for instructions on making it accessible from anywhere!

