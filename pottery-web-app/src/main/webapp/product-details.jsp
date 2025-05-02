<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pottery of Kutch - ${product.name}</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        /* Additional styles for product details page */
        .product-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-top: 30px;
        }
        
        .product-image img {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        
        .product-info h2 {
            color: #5e3a1a;
            margin-bottom: 10px;
            text-align: left;
        }
        
        .product-info .price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #5e3a1a;
            margin-bottom: 20px;
        }
        
        .product-info .description {
            margin-bottom: 30px;
            line-height: 1.8;
        }
        
        .product-info .category {
            display: inline-block;
            background-color: #efe9e2;
            padding: 5px 10px;
            border-radius: 4px;
            color: #5e3a1a;
            margin-bottom: 30px;
        }
        
        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .quantity-selector label {
            margin-right: 10px;
            font-weight: bold;
        }
        
        .quantity-selector input {
            width: 60px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
        }
        
        @media (max-width: 768px) {
            .product-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <h1>Pottery of Kutch</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="products" class="active">Products</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="cart">Cart</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="product-details-section">
        <div class="container">
            <a href="products" class="btn" style="margin-bottom: 20px;">← Back to Products</a>
            
            <div class="product-details">
                <div class="product-image">
                    <img src="${product.imageUrl}" alt="${product.name}">
                </div>
                <div class="product-info">
                    <h2>${product.name}</h2>
                    <div class="price">$<fmt:formatNumber value="${product.price}" pattern="#0.00"/></div>
                    <span class="category">${product.category}</span>
                    <p class="description">${product.description}</p>
                    
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${product.id}">
                        
                        <div class="quantity-selector">
                            <label for="quantity">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" value="1" min="1">
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-logo">
                    <h2>Pottery of Kutch</h2>
                    <p>Preserving tradition through craftsmanship</p>
                </div>
                <div class="footer-links">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="products">Products</a></li>
                        <li><a href="about.jsp">About</a></li>
                        <li><a href="cart">Cart</a></li>
                    </ul>
                </div>
                <div class="footer-contact">
                    <h3>Contact Us</h3>
                    <p>Email: info@potteryofkutch.com</p>
                    <p>Phone: +91 98765 43210</p>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 Pottery of Kutch. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="js/main.js"></script>
</body>
</html>
