// Product data
const products = [
    {
        id: '1',
        name: 'Traditional Water Pot',
        price: 89.99,
        imageUrl: 'images/product_1.jpg',
        description: 'Handcrafted water pot made from locally sourced Kutch clay, featuring traditional geometric patterns. Each piece is shaped on a foot-powered wheel by Kumbhar artisans and fired using traditional methods.',
        category: 'Home Decor',
        shortDescription: 'Traditional clay water vessel'
    },
    {
        id: '2',
        name: 'Khavda Decorative Vase',
        price: 79.99,
        imageUrl: 'images/product_2.jpg',
        description: 'Hand-thrown decorative vase from Khavda village, featuring the region\'s distinctive white and black motifs on natural terracotta. Perfect as a standalone decorative piece or for dried arrangements.',
        category: 'Vases',
        shortDescription: 'Hand-painted terracotta vase'
    },
    {
        id: '3',
        name: 'Kutch Coffee Mug Set',
        price: 59.99,
        imageUrl: 'images/product_3.jpg',
        description: 'Set of four handcrafted coffee mugs made by master potters from Lodai village. Each mug features traditional Kutch designs with natural mineral pigments and a food-safe glaze interior.',
        category: 'Mugs',
        shortDescription: 'Set of 4 traditional clay mugs'
    },
    {
        id: '4',
        name: 'Terracotta Dinner Plates',
        price: 69.99,
        imageUrl: 'images/product_4.jpg',
        description: 'Set of six dinner plates handcrafted from Kutch clay. These plates feature minimalist design with subtle rim detailing, finished with food-safe natural glazes. Microwave and dishwasher safe.',
        category: 'Plates',
        shortDescription: 'Handmade terracotta dinner plates'
    },
    {
        id: '5',
        name: 'Decorative Diya Set',
        price: 39.99,
        imageUrl: 'images/product_5.jpg',
        description: 'Set of five hand-painted diyas (oil lamps) made by Kutch artisans. Each piece features traditional motifs representing prosperity and light, perfect for festivals or year-round home decor.',
        category: 'Home Decor',
        shortDescription: 'Traditional clay oil lamps'
    },
    {
        id: '6',
        name: 'Serving Bowl with Lid',
        price: 64.99,
        imageUrl: 'images/product_6.jpg',
        description: 'Handcrafted serving bowl with matching lid, featuring fish and geometric motifs that symbolize abundance. Made from local Kutch clay and finished with food-safe glazes.',
        category: 'Bowls',
        shortDescription: 'Traditional covered serving dish'
    }
];

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    // Get current page
    const currentPage = window.location.pathname.split('/').pop();
    
    // Initialize mobile menu
    initMobileMenu();
    
    // Initialize page-specific functionality
    if (currentPage === 'products.html' || currentPage === '') {
        initProductsPage();
    } else if (currentPage === 'product-details.html') {
        initProductDetailsPage();
    } else if (currentPage === 'cart.html') {
        initCartPage();
    }
});

// Mobile menu
function initMobileMenu() {
    const nav = document.querySelector('nav');
    
    // Create menu toggle if it doesn't exist
    if (!document.querySelector('.menu-toggle')) {
        const menuToggle = document.createElement('div');
        menuToggle.className = 'menu-toggle';
        menuToggle.innerHTML = '<span></span><span></span><span></span>';
        
        const header = document.querySelector('header .container');
        header.insertBefore(menuToggle, nav);
        
        menuToggle.addEventListener('click', function() {
            nav.classList.toggle('active');
            menuToggle.classList.toggle('active');
        });
        
        // Close mobile menu when clicking outside
        document.addEventListener('click', function(e) {
            if (!nav.contains(e.target) && !menuToggle.contains(e.target) && nav.classList.contains('active')) {
                nav.classList.remove('active');
                menuToggle.classList.remove('active');
            }
        });
    }
}

// Products page functionality
function initProductsPage() {
    // Set up category filter buttons
    const filterButtons = document.querySelectorAll('.filter-btn');
    filterButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const category = this.getAttribute('data-category');
            filterProducts(category);
            
            // Update active button
            filterButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
        });
    });
}

// Filter products by category
function filterProducts(category) {
    const productCards = document.querySelectorAll('.product-card');
    
    productCards.forEach(card => {
        if (category === 'All' || card.getAttribute('data-category') === category) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

// Product details page
function initProductDetailsPage() {
    // Get product ID from URL
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get('id');
    
    if (productId) {
        // Find product in data
        const product = products.find(p => p.id === productId);
        
        if (product) {
            // Set page title
            document.title = `Pottery of Kutch - ${product.name}`;
            
            // Display product details
            const productDetailsContainer = document.getElementById('product-details');
            
            productDetailsContainer.innerHTML = `
                <div class="product-image">
                    <img src="${product.imageUrl}" alt="${product.name}">
                </div>
                <div class="product-info">
                    <h2>${product.name}</h2>
                    <div class="price">$${product.price.toFixed(2)}</div>
                    <span class="category">${product.category}</span>
                    <p class="description">${product.description}</p>
                    
                    <div class="quantity-selector">
                        <label for="quantity">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1">
                    </div>
                    
                    <button onclick="addToCart('${product.id}', '${product.name}', ${product.price}, '${product.imageUrl}', document.getElementById('quantity').value)" class="btn btn-primary">Add to Cart</button>
                </div>
            `;
            
            // Set up quantity selector
            const quantityInput = document.getElementById('quantity');
            
            // Create plus/minus buttons
            const minusBtn = document.createElement('button');
            minusBtn.type = 'button';
            minusBtn.innerText = '-';
            minusBtn.className = 'quantity-btn';
            minusBtn.addEventListener('click', function() {
                const currentValue = parseInt(quantityInput.value);
                if (currentValue > 1) {
                    quantityInput.value = currentValue - 1;
                }
            });
            
            const plusBtn = document.createElement('button');
            plusBtn.type = 'button';
            plusBtn.innerText = '+';
            plusBtn.className = 'quantity-btn';
            plusBtn.addEventListener('click', function() {
                const currentValue = parseInt(quantityInput.value);
                quantityInput.value = currentValue + 1;
            });
            
            // Insert buttons before and after quantity input
            quantityInput.parentNode.insertBefore(minusBtn, quantityInput);
            quantityInput.parentNode.insertBefore(plusBtn, quantityInput.nextSibling);
        }
    }
}

// Cart functionality
function initCartPage() {
    displayCart();
}

// Add item to cart
function addToCart(id, name, price, imageUrl, quantity) {
    // Get current cart from localStorage
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    
    // Convert quantity to number
    quantity = parseInt(quantity);
    
    // Check if product already exists in cart
    const existingItemIndex = cart.findIndex(item => item.id === id);
    
    if (existingItemIndex !== -1) {
        // Update quantity if item already in cart
        cart[existingItemIndex].quantity += quantity;
    } else {
        // Add new item to cart
        cart.push({
            id: id,
            name: name,
            price: price,
            imageUrl: imageUrl,
            quantity: quantity
        });
    }
    
    // Save cart to localStorage
    localStorage.setItem('cart', JSON.stringify(cart));
    
    // Show success message
    alert(`${name} added to cart!`);
    
    // If on cart page, refresh the display
    if (window.location.pathname.split('/').pop() === 'cart.html') {
        displayCart();
    }
}

// Update cart item quantity
function updateCartItem(id, quantity) {
    // Get current cart from localStorage
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    
    // Convert quantity to number
    quantity = parseInt(quantity);
    
    // Find item in cart
    const itemIndex = cart.findIndex(item => item.id === id);
    
    if (itemIndex !== -1) {
        if (quantity > 0) {
            // Update quantity
            cart[itemIndex].quantity = quantity;
        } else {
            // Remove item if quantity is 0 or negative
            cart.splice(itemIndex, 1);
        }
        
        // Save cart to localStorage
        localStorage.setItem('cart', JSON.stringify(cart));
        
        // Refresh cart display
        displayCart();
    }
}

// Remove item from cart
function removeCartItem(id) {
    // Get current cart from localStorage
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    
    // Remove item from cart
    cart = cart.filter(item => item.id !== id);
    
    // Save cart to localStorage
    localStorage.setItem('cart', JSON.stringify(cart));
    
    // Refresh cart display
    displayCart();
}

// Clear entire cart
function clearCart() {
    // Clear cart in localStorage
    localStorage.removeItem('cart');
    
    // Refresh cart display
    displayCart();
}

// Display cart contents
function displayCart() {
    // Get cart from localStorage
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    
    const emptyCartMessage = document.getElementById('empty-cart-message');
    const cartContainer = document.getElementById('cart-container');
    const cartItemsContainer = document.getElementById('cart-items');
    const cartTotalElement = document.getElementById('cart-total');
    
    if (cart.length === 0) {
        // Show empty cart message
        emptyCartMessage.style.display = 'block';
        cartContainer.style.display = 'none';
    } else {
        // Hide empty cart message
        emptyCartMessage.style.display = 'none';
        cartContainer.style.display = 'block';
        
        // Clear previous cart items
        cartItemsContainer.innerHTML = '';
        
        // Calculate total
        let total = 0;
        
        // Add cart items
        cart.forEach(item => {
            const subtotal = item.price * item.quantity;
            total += subtotal;
            
            const itemRow = document.createElement('tr');
            itemRow.innerHTML = `
                <td class="product-info">
                    <img src="${item.imageUrl}" alt="${item.name}">
                    <div>
                        <h3>${item.name}</h3>
                    </div>
                </td>
                <td class="price">$${item.price.toFixed(2)}</td>
                <td class="quantity">
                    <input type="number" value="${item.quantity}" min="1" 
                        onchange="updateCartItem('${item.id}', this.value)">
                </td>
                <td class="subtotal">$${subtotal.toFixed(2)}</td>
                <td class="actions">
                    <button class="btn-remove" onclick="removeCartItem('${item.id}')">Remove</button>
                </td>
            `;
            
            cartItemsContainer.appendChild(itemRow);
        });
        
        // Update total
        cartTotalElement.textContent = `$${total.toFixed(2)}`;
    }
}

// Checkout function
function checkout() {
    alert('Thank you for your order! This is a demo website, so no actual purchase will be processed.');
    clearCart();
}
