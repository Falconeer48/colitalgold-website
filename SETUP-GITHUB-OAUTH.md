# Set Up GitHub OAuth for Decap CMS

## ✅ What I've Done

1. ✅ Updated `admin/config.yml` to use GitHub backend
2. ✅ Removed Netlify Identity dependency from `admin/index.html`
3. ✅ Configured to use your GitHub repo: `Falconeer48/colitalgold-website`

## Next Steps

### Step 1: Create GitHub OAuth App

1. **Go to GitHub:**
   - Visit: https://github.com/settings/developers
   - Or: GitHub → Your Profile → Settings → Developer settings → OAuth Apps

2. **Click "New OAuth App"** (green button)

3. **Fill in the form:**
   - **Application name:** `ColitasGold CMS`
   - **Homepage URL:** `https://colitasgold.netlify.app`
   - **Authorization callback URL:** `https://colitasgold.netlify.app/admin/`
   - **Click "Register application"**

4. **Copy Your Credentials:**
   - After creating, you'll see:
     - **Client ID** - copy this!
     - **Client Secret** - click "Generate a new client secret" button, then copy it!

---

### Step 2: Add to Netlify Environment Variables

1. **Go to Netlify:**
   - Visit: https://app.netlify.com/sites/colitasgold/configuration/env
   - Or: Site settings → Environment variables

2. **Add Two Variables:**
   - Click **"Add a variable"**
   
   **Variable 1:**
   - Key: `GITHUB_CLIENT_ID`
   - Value: (paste your Client ID from GitHub)
   - Click **"Save"**
   
   **Variable 2:**
   - Click **"Add a variable"** again
   - Key: `GITHUB_CLIENT_SECRET`
   - Value: (paste your Client Secret from GitHub)
   - Click **"Save"**

3. **Redeploy Site:**
   - Go to: Deploys tab
   - Click **"Trigger deploy"** → **"Clear cache and deploy site"**

---

### Step 3: Test the CMS!

1. **Go to:** `https://colitasgold.netlify.app/admin/`
2. **Click "Login with GitHub"**
3. **Authorize** the application
4. **Start editing!** 🎉

---

## Benefits of This Method

- ✅ No deprecated services
- ✅ Direct GitHub authentication
- ✅ Future-proof
- ✅ Simpler setup
- ✅ More secure

---

**Once you've created the GitHub OAuth app and added the environment variables, let me know and we can test it!**

