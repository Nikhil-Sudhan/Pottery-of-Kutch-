<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pottery of Kutch - Products</title>
    <link rel="stylesheet" href="css/styles.css">
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

    <section class="products-section">
        <div class="container">
            <h2>Our Products</h2>
            
            <div class="category-filter">
                <h3>Filter by Category</h3>
                <ul>
                    <c:forEach var="category" items="${categories}">
                        <li>
                            <a href="products?category=${category}" 
                               class="${param.category eq category ? 'active' : ''}">
                                ${category}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            
            <div class="products-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <img src="${product.imageUrl}" alt="${product.name}">
                        <h3>${product.name}</h3>
                        <p class="price">$<fmt:formatNumber value="${product.price}" pattern="#0.00"/></p>
                        <p class="description">${product.shortDescription}</p>
                        <div class="product-actions">
                            <a href="product?id=${product.id}" class="btn">View Details</a>
                            <form action="cart" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="btn btn-cart">Add to Cart</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
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
