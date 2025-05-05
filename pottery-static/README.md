# Pottery of Kutch Static Website

This is a static HTML/CSS/JavaScript version of the Pottery of Kutch website that can be run directly in your browser without any server-side requirements.

## Prerequisites
- Node.js (for running a static HTTP server)
- Python 3.x (optional)

## How to Run the Website Locally
1. Open a terminal in the project root (`pottery-static` folder):
   ```sh
   cd pottery-static
   ```
2. Start a simple HTTP server:
   - With Node.js:
     ```sh
     npx http-server . -p 8080
     ```
   - With Python 3.x:
     ```sh
     python -m http.server 5500
     ```
3. Open your browser at `http://localhost:8080` (or `http://localhost:5500`).
4. (Optional) In VS Code, install the Live Server extension and click **Go Live** on `index.html` for live reloading.

## Adding Images

Before running the website, you'll need to add some images for the products. The website is looking for these image files:

- `images/product_1.jpg` - Traditional Water Pot
- `images/product_2.jpg` - Khavda Decorative Vase
- `images/product_3.jpg` - Kutch Coffee Mug Set
- `images/product_4.jpg` - Terracotta Dinner Plates
- `images/product_5.jpg` - Decorative Diya Set
- `images/product_6.jpg` - Serving Bowl with Lid
- `images/hero-bg.jpg` - Hero background image
- `images/about-image.jpg` - About page image

You can add any images you like with these filenames to the `images` folder. If you don't have specific pottery images, you can use any placeholder images and rename them to match these filenames.

## How to Edit the Application
- **HTML**: Modify the `.html` files in the root directory.
- **CSS**: Update styles in `css/styles.css` (and `placeholder-styles.css`).
- **JavaScript**: Edit `js/main.js` for product data, UI logic, and interactivity.
- **Images**: Add or replace files in the `images/` folder; ensure paths match in `js/main.js`.
- After making changes, refresh your browser to see updates.

## Features

- Product browsing with category filtering
- Product details view
- Shopping cart functionality with localStorage
- Responsive design for mobile and desktop

## Structure

- `index.html` - Homepage
- `products.html` - Products catalog
- `product-details.html` - Product details page
- `cart.html` - Shopping cart
- `about.html` - About page
- `css/styles.css` - Stylesheet
- `js/main.js` - JavaScript functionality
- `images/` - Directory for product images
