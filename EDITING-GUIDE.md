# Website Editing Guide

This guide shows you how to make common changes to your ColitasGold website.

## Quick Start

### Opening Files to Edit

**Option 1: Using Finder**
1. Open Finder
2. Go to: `/Users/ian/Documents/Arduino/fridge-and-freezer-sensors/colitasgold-website/`
3. Right-click on any file (index.html, styles.css, etc.)
4. Choose "Open With" → "TextEdit" or any text editor

**Option 2: Using Cursor (Current Editor)**
- Just open the files directly in Cursor like you're doing now!

---

## Common Changes

### 1. Changing Text Content

**File to edit:** `index.html`

**To change the hero title:**
- Find line 43: `<h1 class="hero-title">ColitasGold</h1>`
- Change "ColitasGold" to whatever you want

**To change the subtitle:**
- Find line 44: `<p class="hero-subtitle">Cold Processed, Full Extract Cannabis Oil (F.E.C.O)</p>`
- Change the text between the `<p>` tags

**To change contact information:**
- Find the Contact Section (around line 116)
- Look for:
  - WhatsApp number
  - Email address
  - Website URL
- Just change the text or links!

### 2. Changing Colors

**File to edit:** `styles.css`

**At the top of the file (lines 14-23), you'll see color variables:**

```css
:root {
    --primary: #1a472a;           /* Main green color */
    --primary-dark: #0f2818;      /* Darker green */
    --primary-light: #2d6a3f;     /* Lighter green */
    --secondary: #4a7c2a;         /* Secondary green */
    --accent: #8b9a5b;            /* Accent color */
    --gold: #d4af37;              /* Gold color */
}
```

**To change colors:**
- Replace the color codes (like `#1a472a`) with any color you want
- You can use:
  - Hex codes: `#FF5733` (orange)
  - Color names: `blue`, `red`, `purple`
  - RGB: `rgb(255, 0, 0)` (red)

**Popular color picker websites:**
- https://coolors.co/
- https://htmlcolorcodes.com/

### 3. Adding or Removing Sections

**File to edit:** `index.html`

**To add a new section:**
1. Copy an existing section (like the Benefits section)
2. Paste it where you want it
3. Change the content inside
4. Update the navigation if needed

**To remove a section:**
- Just delete the entire `<section>` block (from `<section` to `</section>`)

### 4. Changing Images

**Steps:**
1. Replace the image file in the `images/` folder
2. Make sure the new image has the same filename, OR
3. Update the filename in `index.html` to match

**To change the logo:**
- Replace `images/cannabis_3-removebg.png` with your new logo
- Keep the same filename, OR update line 18 and 41 in index.html

**To change the dog image:**
- Replace `images/dog.webp` with your new image
- Update line 67 in index.html if you change the filename

### 5. Adding More Navigation Links

**File to edit:** `index.html`

**Around line 21-25, you'll see the navigation menu:**

```html
<ul class="nav-menu">
    <li><a href="#home" class="nav-link active">Home</a></li>
    <li><a href="#benefits" class="nav-link">Benefits</a></li>
    <li><a href="#products" class="nav-link">Products</a></li>
    <li><a href="#contact" class="nav-link">Contact</a></li>
</ul>
```

**To add a new link:**
- Add a new line: `<li><a href="#section-id" class="nav-link">Link Name</a></li>`
- Make sure you have a section with `id="section-id"` on the page

### 6. Changing Fonts

**File to edit:** `styles.css`

**Around line 35, you'll see:**

```css
body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, ...
}
```

**To use a different font:**
1. Go to Google Fonts (https://fonts.google.com/)
2. Pick a font and get the link
3. Update line 10 in `index.html` with the new font link
4. Update `styles.css` with the font name

---

## Editing Tips

### 💡 Finding Things Quickly

**In index.html:**
- Search for text using `Cmd + F` (or `Ctrl + F`)
- Look for HTML comments like `<!-- Hero Section -->` to find sections

**In styles.css:**
- Search for class names like `.hero` or `.navbar` to find styles
- Comments like `/* Navigation */` help locate sections

### 💡 Testing Your Changes

1. Save your file (`Cmd + S`)
2. Refresh your browser (`Cmd + R` or click refresh)
3. You should see your changes immediately!

### 💡 Undoing Changes

- `Cmd + Z` to undo in any text editor
- Or use Git if you have it set up

---

## File Structure

```
colitasgold-website/
├── index.html          ← Main content and structure
├── styles.css          ← All styling and colors
├── script.js           ← Animations and interactions
├── images/             ← All your images
│   ├── cannabis_3-removebg.png
│   ├── dog.webp
│   ├── Bottle-and-box.jpg
│   └── product-screenshot.png
└── EDITING-GUIDE.md    ← This file!
```

---

## Common Questions

**Q: How do I change the spacing between sections?**
A: Edit `styles.css`, find the section (like `.benefits-section`), and change the `padding` value.

**Q: How do I make text bigger/smaller?**
A: In `styles.css`, find the element and change the `font-size` value.

**Q: Can I add more pages?**
A: Yes! Create a new HTML file (like `about.html`) and link to it from navigation.

**Q: Do I need to know HTML/CSS?**
A: Not really! Most changes are just finding and replacing text. But learning basics helps.

---

## Need Help?

- HTML Tutorial: https://www.w3schools.com/html/
- CSS Tutorial: https://www.w3schools.com/css/
- Color Picker: https://htmlcolorcodes.com/color-picker/

Remember: **Save your file and refresh the browser** to see changes!

---

Happy editing! 🚀
