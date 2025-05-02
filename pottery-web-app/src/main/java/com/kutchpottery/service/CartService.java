package com.kutchpottery.service;

import com.kutchpottery.model.CartItem;
import com.kutchpottery.model.Product;

import java.util.List;
import java.util.Optional;

public class CartService {
    
    public void addToCart(List<CartItem> cart, Product product, int quantity) {
        Optional<CartItem> existingItem = cart.stream()
                .filter(item -> item.getProduct().getId().equals(product.getId()))
                .findFirst();
        
        if (existingItem.isPresent()) {
            // Update quantity if product already in cart
            CartItem item = existingItem.get();
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            // Add new item to cart
            cart.add(new CartItem(product, quantity));
        }
    }
    
    public void updateCartItem(List<CartItem> cart, String productId, int quantity) {
        cart.stream()
                .filter(item -> item.getProduct().getId().equals(productId))
                .findFirst()
                .ifPresent(item -> {
                    if (quantity > 0) {
                        item.setQuantity(quantity);
                    } else {
                        removeFromCart(cart, productId);
                    }
                });
    }
    
    public void removeFromCart(List<CartItem> cart, String productId) {
        cart.removeIf(item -> item.getProduct().getId().equals(productId));
    }
    
    public double calculateTotal(List<CartItem> cart) {
        return cart.stream()
                .mapToDouble(CartItem::getSubtotal)
                .sum();
    }
}
