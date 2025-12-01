# Fix DuckDNS "KO" Error

Getting "KO" means the DuckDNS update failed. Here's how to fix it.

## Common Causes

1. **Wrong token** - Token doesn't match your account
2. **Wrong domain name** - Domain doesn't exist in your DuckDNS account
3. **Domain/token mismatch** - Token doesn't match the domain
4. **Domain not created** - Domain hasn't been added to your DuckDNS account

## Step-by-Step Fix

### Step 1: Verify Your DuckDNS Account

1. Go to: https://www.duckdns.org/
2. Sign in to your account
3. Go to: https://www.duckdns.org/domains
4. Check:
   - Your domain name (e.g., `colitasgold`)
   - Make sure it's listed there
   - If not, add it first!

### Step 2: Get Your Token

1. Go to: https://www.duckdns.org/
2. Look for "Token" section
3. Copy the token (long string of characters)

### Step 3: Recreate the Script

On your Pi:

```bash
cd ~/duckdns
nano duck.sh
```

**Delete everything and paste this (replace YOUR_DOMAIN and YOUR_TOKEN):**

```bash
#!/bin/bash
echo url="https://www.duckdns.org/update?domains=YOUR_DOMAIN&token=YOUR_TOKEN&ip=" | curl -k -o ~/duckdns/duck.log -K -
```

**Important:**
- `YOUR_DOMAIN` should be just the domain name **without** `.duckdns.org`
  - Example: If domain is `colitasgold.duckdns.org`, use just `colitasgold`
- `YOUR_TOKEN` should be your full token from DuckDNS website

Save and exit (Ctrl+X, Y, Enter)

### Step 4: Test Manually

```bash
chmod +x duck.sh
./duck.sh
cat duck.log
```

Should say: **OK**

If still "KO", test the URL directly:

```bash
curl "https://www.duckdns.org/update?domains=YOUR_DOMAIN&token=YOUR_TOKEN&ip="
```

Should return: **OK**

## Quick Test Script

I've created a fix script. Transfer and run it:

```bash
# From your Mac
scp "/Volumes/M2 Drive/colitasgold-website/fix-duckdns.sh" ian@192.168.50.243:/home/ian/

# On Pi
chmod +x fix-duckdns.sh
./fix-duckdns.sh
```

## Common Mistakes

❌ **Wrong:** `domains=colitasgold.duckdns.org`
✅ **Right:** `domains=colitasgold`

❌ **Wrong:** Using wrong token
✅ **Right:** Copy token directly from DuckDNS website

❌ **Wrong:** Domain doesn't exist in account
✅ **Right:** Create domain in DuckDNS account first

## Verify Your Setup

1. **Check domain exists:**
   - Go to: https://www.duckdns.org/domains
   - Domain should be listed

2. **Check token:**
   - Go to: https://www.duckdns.org/
   - Token shown should match what you're using

3. **Test update:**
   ```bash
   curl "https://www.duckdns.org/update?domains=YOUR_DOMAIN&token=YOUR_TOKEN&ip="
   ```
   Should return: **OK**

## Still Not Working?

If you're still getting "KO", check:

1. **Domain exists in account:**
   - https://www.duckdns.org/domains

2. **Token is correct:**
   - https://www.duckdns.org/
   - Copy token directly

3. **Try manual update:**
   ```bash
   curl "https://www.duckdns.org/update?domains=YOUR_DOMAIN&token=YOUR_TOKEN&ip="
   ```

4. **Check DuckDNS status:**
   - Visit: https://status.duckdns.org/

---

Once you get "OK", your DuckDNS is working! Then you can proceed with HTTPS setup.

