# Decap CMS Setup - Next Steps

## ✅ Step 1: COMPLETE
- Git repository initialized
- Files committed

## 📋 Step 2: Create GitHub Repository

### On GitHub Website:

1. **Go to:** https://github.com/
2. **Sign in** (or create account if needed)
3. **Click:** "+" icon (top right) → "New repository"
4. **Repository details:**
   - Name: `colitasgold-website` (or any name you like)
   - Description: "ColitasGold Website"
   - **Public** or **Private** (your choice)
   - **DO NOT** check "Initialize with README"
   - **DO NOT** add .gitignore or license
5. **Click:** "Create repository"

### After Creating Repository:

GitHub will show you commands. You'll see something like:

```
...or push an existing repository from the command line
git remote add origin https://github.com/YOUR-USERNAME/colitasgold-website.git
git branch -M main
git push -u origin main
```

---

## 📋 Step 3: Connect Local Repository to GitHub

Once you've created the GitHub repository, run these commands (replace YOUR-USERNAME with your GitHub username):

```bash
cd "/Volumes/M2 Drive/colitasgold-website"

# Add GitHub as remote
git remote add origin https://github.com/YOUR-USERNAME/colitasgold-website.git

# Make sure you're on main branch
git branch -M main

# Push to GitHub
git push -u origin main
```

You'll be asked for your GitHub username and password/token.

---

## 📋 Step 4: Set Up Netlify (Free Hosting + Git Gateway)

1. **Go to:** https://netlify.com/
2. **Sign up** (free) - can use GitHub account
3. **Click:** "Add new site" → "Import an existing project"
4. **Connect to GitHub:**
   - Choose your repository: `colitasgold-website`
   - Click "Connect"
5. **Deploy settings:**
   - Build command: (leave empty)
   - Publish directory: `/` (or leave as is)
   - Click "Deploy"
6. **Enable Identity & Git Gateway:**
   - Go to: Site settings → Identity
   - Click "Enable Identity"
   - Go to: Identity → Services → Git Gateway
   - Click "Enable Git Gateway"
   - Click "Save"

---

## 📋 Step 5: Configure Decap CMS

### Update config.yml:

The `admin/config.yml` file needs to point to your GitHub repository.

I'll update it for you once you have:
- GitHub repository URL
- Netlify site URL

---

## 📋 Step 6: Access CMS

Once everything is set up:
1. Go to: `https://your-site-name.netlify.app/admin/`
2. Sign up/login
3. Start editing!

---

## Quick Commands Summary

```bash
# Step 1: ✅ DONE

# Step 2: Create repo on GitHub (do this on website)

# Step 3: Connect and push
cd "/Volumes/M2 Drive/colitasgold-website"
git remote add origin https://github.com/YOUR-USERNAME/REPO-NAME.git
git branch -M main
git push -u origin main

# Step 4: Set up Netlify (do this on website)

# Step 5: I'll help configure
```

---

**Ready for Step 2?** Create the GitHub repository and let me know your GitHub username and repository name!

