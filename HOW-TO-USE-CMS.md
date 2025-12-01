# How to Use Decap CMS (Content Management System)

## Quick Start Guide

### Step 1: Access the Admin Panel

1. Make sure your website server is running (`python3 -m http.server 8000`)
2. Open your browser and go to:
   ```
   http://localhost:8000/admin/
   ```

### Step 2: Set Up Authentication

**IMPORTANT:** Decap CMS needs Git and authentication to save changes. You have two options:

---

## Option A: Full Setup with Git (Recommended for Production)

This allows you to save changes directly to files.

### Prerequisites:
- Git installed on your Mac
- GitHub account (free)
- Your website in a Git repository

### Setup Steps:

1. **Initialize Git in your website folder:**
   ```bash
   cd "/Volumes/M2 Drive/colitasgold-website"
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. **Create a GitHub repository:**
   - Go to github.com
   - Create a new repository
   - Don't initialize with README

3. **Connect your local folder to GitHub:**
   ```bash
   git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
   git branch -M main
   git push -u origin main
   ```

4. **Set up Netlify (free hosting with Git Gateway):**
   - Go to netlify.com
   - Sign up/login
   - Click "New site from Git"
   - Connect your GitHub repository
   - Deploy
   - Enable "Identity" in Netlify settings
   - Enable "Git Gateway"

5. **Access CMS:**
   - Go to: `https://your-site-name.netlify.app/admin/`
   - Create an account/login
   - Start editing!

---

## Option B: Simple Local Editor (No Git Required)

Since Git setup can be complex, I've created a simpler editor that works immediately:

### How to Use the Simple Editor:

1. Open: `http://localhost:8000/editor.html`
2. Edit the content in the forms
3. Click "Generate Updated HTML"
4. Copy the generated HTML
5. Paste into `index.html` manually

---

## Option C: Local File System (Advanced)

For advanced users, you can set up Decap CMS with local file system backend, but it requires additional setup.

---

## What You Can Edit in Decap CMS

Once set up, you'll be able to edit:

- ✅ **Hero Section** - Title, tagline, subtitle, button text
- ✅ **Benefits Section** - Title, introduction, benefit list
- ✅ **Contact Information** - Website, WhatsApp, email
- ✅ **Product Information** - Product features and details
- ✅ **Images** - Upload and manage images

---

## Troubleshooting

### "Failed to load config.yml"
- Make sure `admin/config.yml` exists
- Check the file path is correct

### "No backend found"
- You need to set up Git Gateway or use the simple editor
- See Option B above for an alternative

### "Authentication required"
- Set up Netlify with Git Gateway (Option A)
- Or use the simple editor (Option B)

---

## My Recommendation

**For quick editing right now:** Use the simple editor at `http://localhost:8000/editor.html`

**For long-term professional use:** Set up Option A with Git and Netlify

**Need help?** I can guide you through any of these options step by step!

---

## Next Steps

1. Try the simple editor first: `http://localhost:8000/editor.html`
2. If you want the full CMS, let me know and I'll help you set up Git/GitHub
3. Or I can create an even simpler custom editor just for you!

