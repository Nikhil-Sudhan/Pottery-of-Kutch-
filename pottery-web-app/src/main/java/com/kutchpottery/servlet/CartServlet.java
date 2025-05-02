package com.kutchpottery.servlet;

import com.kutchpottery.model.CartItem;
import com.kutchpottery.model.Product;
import com.kutchpottery.service.CartService;
import com.kutchpottery.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ProductService productService;
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        
        request.setAttribute("cartItems", cart);
        request.setAttribute("cartTotal", cartService.calculateTotal(cart));
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addToCart(request, response);
        } else if ("update".equals(action)) {
            updateCart(request, response);
        } else if ("remove".equals(action)) {
            removeFromCart(request, response);
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response) {
        String productId = request.getParameter("productId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        Product product = productService.getProductById(productId);
        if (product != null) {
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }
            
            cartService.addToCart(cart, product, quantity);
        }
    }
    
    private void updateCart(HttpServletRequest request, HttpServletResponse response) {
        String productId = request.getParameter("productId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            cartService.updateCartItem(cart, productId, quantity);
        }
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) {
        String productId = request.getParameter("productId");
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            cartService.removeFromCart(cart, productId);
        }
    }
}
