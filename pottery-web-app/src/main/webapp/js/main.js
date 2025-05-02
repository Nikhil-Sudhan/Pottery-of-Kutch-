// main.js for Pottery of Kutch website

// Add smooth scrolling to all links
document.addEventListener('DOMContentLoaded', function() {
    const scrollLinks = document.querySelectorAll('a[href^="#"]');
    
    for (const scrollLink of scrollLinks) {
        scrollLink.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 70,
                    behavior: 'smooth'
                });
            }
        });
    }
    
    // Quantity selector (for product details page)
    const quantityInput = document.getElementById('quantity');
    if (quantityInput) {
        // Add plus/minus buttons functionality if needed
        // This is a simple example implementation
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
    
    // Cart quantity update - auto-submit the form when quantity changes
    const cartQuantityInputs = document.querySelectorAll('.cart-table .quantity input');
    for (const input of cartQuantityInputs) {
        input.addEventListener('change', function() {
            this.form.submit();
        });
    }
});

// Add mobile menu toggle functionality
const menuToggle = document.createElement('div');
menuToggle.className = 'menu-toggle';
menuToggle.innerHTML = '<span></span><span></span><span></span>';

const nav = document.querySelector('nav');
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
