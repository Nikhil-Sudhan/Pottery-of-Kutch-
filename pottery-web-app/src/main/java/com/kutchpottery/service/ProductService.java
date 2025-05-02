package com.kutchpottery.service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import com.google.gson.reflect.TypeToken;
import com.kutchpottery.model.Product;

import javax.servlet.ServletContext;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ProductService {
    private List<Product> products;
    private List<String> categories;
    private static final String PRODUCTS_JSON = "/WEB-INF/classes/products.json";

    public ProductService() {
        loadProductsFromJson();
    }

    private void loadProductsFromJson() {
        try {
            // In a real application, this would load from the file system
            // For now, we'll hardcode the products data
            products = new ArrayList<>();
            categories = new ArrayList<>();
            
            products.add(new Product("1", "Traditional Water Pot", 89.99, "images/product_1.jpg", 
                "Handcrafted water pot made from locally sourced Kutch clay, featuring traditional geometric patterns. Each piece is shaped on a foot-powered wheel by Kumbhar artisans and fired using traditional methods.", 
                "Home Decor", "Traditional clay water vessel"));
                
            products.add(new Product("2", "Khavda Decorative Vase", 79.99, "images/product_2.jpg", 
                "Hand-thrown decorative vase from Khavda village, featuring the region's distinctive white and black motifs on natural terracotta. Perfect as a standalone decorative piece or for dried arrangements.", 
                "Vases", "Hand-painted terracotta vase"));
                
            products.add(new Product("3", "Kutch Coffee Mug Set", 59.99, "images/product_3.jpg", 
                "Set of four handcrafted coffee mugs made by master potters from Lodai village. Each mug features traditional Kutch designs with natural mineral pigments and a food-safe glaze interior.", 
                "Mugs", "Set of 4 traditional clay mugs"));
                
            products.add(new Product("4", "Terracotta Dinner Plates", 69.99, "images/product_4.jpg", 
                "Set of six dinner plates handcrafted from Kutch clay. These plates feature minimalist design with subtle rim detailing, finished with food-safe natural glazes. Microwave and dishwasher safe.", 
                "Plates", "Handmade terracotta dinner plates"));
                
            products.add(new Product("5", "Decorative Diya Set", 39.99, "images/product_5.jpg", 
                "Set of five hand-painted diyas (oil lamps) made by Kutch artisans. Each piece features traditional motifs representing prosperity and light, perfect for festivals or year-round home decor.", 
                "Home Decor", "Traditional clay oil lamps"));
                
            products.add(new Product("6", "Serving Bowl with Lid", 64.99, "images/product_6.jpg", 
                "Handcrafted serving bowl with matching lid, featuring fish and geometric motifs that symbolize abundance. Made from local Kutch clay and finished with food-safe glazes.", 
                "Bowls", "Traditional covered serving dish"));
            
            // Initialize categories
            categories.add("All");
            categories.add("Mugs");
            categories.add("Plates");
            categories.add("Bowls");
            categories.add("Vases");
            categories.add("Home Decor");
            categories.add("Kitchenware");
            
        } catch (Exception e) {
            e.printStackTrace();
            // Initialize with empty lists if there's an error
            products = new ArrayList<>();
            categories = new ArrayList<>();
        }
    }

    public List<Product> getAllProducts() {
        return products;
    }

    public List<String> getAllCategories() {
        return categories;
    }

    public Product getProductById(String id) {
        return products.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public List<Product> getProductsByCategory(String category) {
        return products.stream()
                .filter(p -> p.getCategory().equals(category))
                .collect(Collectors.toList());
    }
}
