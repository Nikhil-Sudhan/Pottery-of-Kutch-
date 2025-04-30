import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  // Map of product ID to CartItem
  final Map<String, CartItem> _items = {};

  // Get all items in cart
  Map<String, CartItem> get items => {..._items};

  // Count of items in cart
  int get itemCount => _items.length;

  // Total number of products (including quantities)
  int get totalQuantity {
    int total = 0;
    _items.forEach((key, item) {
      total += item.quantity;
    });
    return total;
  }

  // Calculate subtotal
  double get subtotal {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.totalPrice;
    });
    return total;
  }

  // Fixed shipping cost
  double get shippingCost {
    return _items.isEmpty ? 0.0 : 50.0; // $50 fixed shipping
  }

  // Calculate total
  double get total => subtotal + shippingCost;

  // Check if cart is empty
  bool get isEmpty => _items.isEmpty;

  // Add item to cart
  void addItem(Product product, {int quantity = 1}) {
    if (_items.containsKey(product.id)) {
      // Increase quantity if already in cart
      _items.update(
        product.id,
        (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        ),
      );
    } else {
      // Add new item
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Update item quantity
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => existingItem.copyWith(quantity: quantity),
      );
      notifyListeners();
    }
  }

  // Increase item quantity by 1
  void increaseQuantity(String productId) {
    _items.update(
      productId,
      (existingItem) => existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      ),
    );
    notifyListeners();
  }

  // Decrease item quantity by 1
  void decreaseQuantity(String productId) {
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        ),
      );
      notifyListeners();
    } else {
      removeItem(productId);
    }
  }

  // Clear cart
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
