package com.kutchpottery.servlet;

import com.kutchpottery.model.Product;
import com.kutchpottery.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/product")
public class ProductDetailsServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("id");
        
        if (productId != null && !productId.isEmpty()) {
            Product product = productService.getProductById(productId);
            
            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("/product-details.jsp").forward(request, response);
                return;
            }
        }
        
        // If product not found, redirect to products page
        response.sendRedirect(request.getContextPath() + "/products");
    }
}
