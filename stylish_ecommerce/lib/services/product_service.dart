import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductService {
  // Singleton pattern
  static final ProductService _instance = ProductService._internal();
  
  factory ProductService() {
    return _instance;
  }
  
  ProductService._internal();

  // Load all products from JSON file
  Future<List<Product>> getProducts() async {
    final String response = await rootBundle.loadString('assets/data/products.json');
    final data = await json.decode(response);
    final List<dynamic> productsJson = data['products'];
    
    return productsJson.map((json) => Product.fromJson(json)).toList();
  }

  // Get all available categories
  Future<List<String>> getCategories() async {
    final String response = await rootBundle.loadString('assets/data/products.json');
    final data = await json.decode(response);
    final List<dynamic> categoriesJson = data['categories'];
    
    return categoriesJson.map((category) => category as String).toList();
  }

  // Filter products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    final products = await getProducts();
    
    if (category == 'All') {
      return products;
    }
    
    return products.where((product) => product.category == category).toList();
  }

  // Search products by name
  Future<List<Product>> searchProducts(String query) async {
    final products = await getProducts();
    
    if (query.isEmpty) {
      return products;
    }
    
    final queryLower = query.toLowerCase();
    return products.where((product) => 
      product.name.toLowerCase().contains(queryLower) || 
      product.description.toLowerCase().contains(queryLower) ||
      product.shortDescription.toLowerCase().contains(queryLower)
    ).toList();
  }
}
