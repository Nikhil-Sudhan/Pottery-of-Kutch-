<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pottery of Kutch - Shopping Cart</title>
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
                    <li><a href="products">Products</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="cart" class="active">Cart</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="cart-section">
        <div class="container">
            <h2>Your Shopping Cart</h2>
            
            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="empty-cart">
                        <p>Your cart is empty.</p>
                        <a href="products" class="btn">Continue Shopping</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="cart-container">
                        <table class="cart-table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cartItems}">
                                    <tr>
                                        <td class="product-info">
                                            <img src="${item.product.imageUrl}" alt="${item.product.name}">
                                            <div>
                                                <h3>${item.product.name}</h3>
                                                <p>${item.product.shortDescription}</p>
                                            </div>
                                        </td>
                                        <td class="price">$<fmt:formatNumber value="${item.product.price}" pattern="#0.00"/></td>
                                        <td class="quantity">
                                            <form action="cart" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" onchange="this.form.submit()">
                                            </form>
                                        </td>
                                        <td class="subtotal">$<fmt:formatNumber value="${item.subtotal}" pattern="#0.00"/></td>
                                        <td class="actions">
                                            <form action="cart" method="post">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <button type="submit" class="btn-remove">Remove</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" class="total-label">Total:</td>
                                    <td class="total-amount">$<fmt:formatNumber value="${cartTotal}" pattern="#0.00"/></td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                        
                        <div class="cart-actions">
                            <a href="products" class="btn">Continue Shopping</a>
                            <a href="checkout.jsp" class="btn btn-primary">Proceed to Checkout</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
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
