# Set Up Netlify for Decap CMS

## Current Status

✅ **Step 1:** Git repository initialized  
✅ **Step 2:** GitHub repository created  
✅ **Step 3:** Code pushed to GitHub  
⏳ **Step 4:** Set up Netlify (Next!)

---

## Step 4: Set Up Netlify

### 1. Go to Netlify

Visit: https://www.netlify.com/

### 2. Sign Up / Log In

- Click "Sign up" (free account)
- **Best option:** Sign up with GitHub (makes everything easier!)
- Or use email

### 3. Import Your Site

1. Click **"Add new site"** button
2. Select **"Import an existing project"**
3. Choose **"Deploy with GitHub"**
4. Authorize Netlify to access your GitHub account
5. Select your repository: **`colitalgold-website`**
6. Click **"Connect"**

### 4. Configure Build Settings

- **Build command:** (leave empty - no build needed)
- **Publish directory:** `/` (or leave as is)
- Click **"Deploy site"**

### 5. Wait for Deployment

Netlify will deploy your site. You'll get a URL like:
```
https://random-name-12345.netlify.app
```

### 6. Enable Identity & Git Gateway (IMPORTANT!)

1. Go to: **Site settings** (gear icon)
2. Click: **"Identity"** (in left menu)
3. Click: **"Enable Identity"** button
4. **Registration preferences:**
   - Set to: **"Invite only"** or **"Open"** (your choice)
5. Scroll down to **"Services"**
6. Click: **"Enable Git Gateway"** button
7. Click **"Save"**

### 7. Invite Yourself as Admin (Optional)

1. Go to: **Identity** → **Invite users**
2. Enter your email
3. Click **"Invite"**
4. Check your email and accept the invite

---

## Step 5: Update Decap CMS Config

I'll update the `admin/config.yml` file to point to your GitHub repository.

---

## Step 6: Access Your CMS

Once everything is set up:

1. Go to: `https://your-site-name.netlify.app/admin/`
2. Sign up or log in
3. Start editing!

---

## Quick Checklist

- [ ] Created Netlify account
- [ ] Connected GitHub repository
- [ ] Site deployed
- [ ] Identity enabled
- [ ] Git Gateway enabled
- [ ] Got your Netlify site URL

**Let me know once you've completed these steps and I'll help configure Decap CMS!**

---

**Your GitHub Repository:**
- URL: https://github.com/Falconeer48/colitalgold-website
- Status: ✅ Code pushed successfully

