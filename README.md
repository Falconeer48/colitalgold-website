# ColitasGold Website

A static website for ColitasGold - Premium Cold Processed Full Extract Cannabis Oil (F.E.C.O) for pets.

## Files Structure

```
colitasgold-website/
├── index.html          # Main HTML file
├── styles.css          # CSS styling
├── script.js           # JavaScript for interactions
├── images/             # Image assets folder
│   ├── cannabis_3-removebg.png
│   ├── dog.webp
│   ├── bottle-and-box.jpg
│   └── product-screenshot.png
└── README.md           # This file
```

## Setup Instructions

### 1. Download Images

You'll need to download the following images from the original Wix site and place them in the `images/` folder:

- `cannabis_3-removebg.png` - Logo
- `dog.webp` - Dog image for benefits section
- `bottle-and-box.jpg` - Product image
- `product-screenshot.png` - Product screenshot

**To download images:**
1. Visit https://www.colitasgold.com/
2. Right-click on each image and "Save Image As..."
3. Save them to the `images/` folder in this project

### 2. Create Images Folder

```bash
mkdir images
```

### 3. Hosting Options

#### Option A: Simple HTTP Server (Testing)

For local testing, you can use Python:

```bash
# Python 3
python3 -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
```

Then visit: http://localhost:8000

#### Option B: Apache Server

1. Copy the entire `colitasgold-website` folder to your Apache web directory (usually `/var/www/html/` or `/Library/WebServer/Documents/` on macOS)
2. Ensure Apache is running
3. Visit `http://localhost/colitasgold-website/` or configure a virtual host

#### Option C: Nginx Server

1. Copy the folder to `/usr/share/nginx/html/` or your configured root
2. Configure Nginx to serve the directory
3. Restart Nginx

#### Option D: GitHub Pages (Free Hosting)

1. Create a GitHub repository
2. Upload all files
3. Enable GitHub Pages in repository settings
4. Your site will be available at `https://yourusername.github.io/repository-name/`

#### Option E: Netlify/Vercel (Free Hosting)

1. Drag and drop the folder to Netlify or Vercel
2. Get an instant URL
3. Optionally connect to a custom domain

### 4. Custom Domain Setup (Optional)

1. Point your domain's DNS to your hosting provider
2. Configure SSL certificate (Let's Encrypt is free)
3. Update any hardcoded URLs if needed

## Features

- ✅ Responsive design (mobile-friendly)
- ✅ Smooth scrolling navigation
- ✅ Fade-in animations on scroll
- ✅ Modern, clean design
- ✅ SEO-friendly structure
- ✅ Fast loading static files

## Customization

### Colors
Edit `styles.css` and modify the CSS variables at the top:

```css
:root {
    --primary-color: #2d5016;      /* Main green color */
    --secondary-color: #4a7c2a;    /* Secondary green */
    --accent-color: #8b9a5b;       /* Accent color */
    --text-color: #333;            /* Main text */
    --bg-light: #f8f9f5;           /* Light background */
}
```

### Content
Edit `index.html` to update any text, sections, or structure.

### Styling
All styles are in `styles.css`. Modify as needed for your branding.

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers

## Notes

- The website is fully static and doesn't require a backend
- All contact links (WhatsApp, email) are functional
- Images need to be downloaded from the original site
- No external dependencies required (pure HTML/CSS/JS)

## Support

For issues or questions, refer to your hosting provider's documentation or contact your web developer.

---

Made for ColitasGold - Premium Cannabis Oil for Pets
