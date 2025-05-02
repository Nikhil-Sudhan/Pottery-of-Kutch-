package com.kutchpottery.servlet;

import com.kutchpottery.model.Product;
import com.kutchpottery.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Product> products;
        
        if (category != null && !category.equals("All")) {
            products = productService.getProductsByCategory(category);
        } else {
            products = productService.getAllProducts();
        }
        
        request.setAttribute("products", products);
        request.setAttribute("categories", productService.getAllCategories());
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}
