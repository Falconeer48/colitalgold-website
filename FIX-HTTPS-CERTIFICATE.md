# Fix HTTPS Certificate Issue

## Current Problem

When accessing `https://colitasgold.duckdns.org/`, you're seeing the photo portfolio's certificate (iancook.myddns.me) because:
- ColitasGold doesn't have its own SSL certificate yet
- Let's Encrypt can't verify the DuckDNS domain
- Nginx falls back to the photo portfolio's certificate

## Solutions

### Solution 1: Redirect HTTPS to HTTP (Temporary)

I've configured Nginx to redirect HTTPS to HTTP. Users will see a certificate warning but then get redirected to HTTP.

**Current behavior:**
- `https://colitasgold.duckdns.org/` → Shows warning → Redirects to HTTP
- `http://colitasgold.duckdns.org/` → Works perfectly

### Solution 2: Get SSL Certificate Using DNS Validation

Use DNS-01 challenge instead of HTTP-01:

```bash
sudo certbot certonly --manual --preferred-challenges dns -d colitasgold.duckdns.org
```

This requires adding a TXT record to DuckDNS.

### Solution 3: Use Cloudflare (Free SSL)

1. Point your domain to Cloudflare
2. Cloudflare provides free SSL automatically
3. No certificate management needed

### Solution 4: Wait for DNS Propagation

DuckDNS DNS can take 24-48 hours to fully propagate. Try SSL certificate again tomorrow.

### Solution 5: Use HTTP Only (Simplest)

Since HTTP works perfectly, you can:
- Use `http://colitasgold.duckdns.org/` for now
- Add HTTPS later when DNS is fully propagated
- Most browsers work fine with HTTP

## Recommendation

For now, use HTTP:
```
http://colitasgold.duckdns.org/
```

It works perfectly! HTTPS can be added once the SSL certificate is obtained.

The redirect I've set up will automatically send HTTPS requests to HTTP, so users will still be able to access the site even if they type HTTPS.

---

**Current Status:**
- ✅ HTTP: Working perfectly
- ⚠️ HTTPS: Redirects to HTTP (certificate warning first)
- ⏳ SSL Certificate: Waiting for DNS propagation or alternative method

