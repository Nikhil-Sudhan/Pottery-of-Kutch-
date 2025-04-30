import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../utils/theme.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/footer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      drawer: isDesktop ? null : _buildMobileDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: '/cart'),
            _buildPageHeader(),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                if (cartProvider.isEmpty) {
                  return _buildEmptyCart(context);
                } else {
                  return isDesktop
                      ? _buildDesktopCart(context, cartProvider)
                      : _buildMobileCart(context, cartProvider);
                }
              },
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      color: AppTheme.primaryColor,
      child: Column(
        children: [
          Text(
            'Your Cart',
            style: GoogleFonts.playfairDisplay(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 2,
            color: AppTheme.accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: AppTheme.secondaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey[700],
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Looks like you haven\'t added any items to your cart yet.',
              style: GoogleFonts.lora(
                fontSize: 16,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/products');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Browse Products',
                style: GoogleFonts.lora(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopCart(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: AppTheme.secondaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart items list - left side
          Expanded(
            flex: 7,
            child: _buildCartItemsList(context, cartProvider),
          ),
          const SizedBox(width: 40),
          // Order summary - right side
          Expanded(
            flex: 3,
            child: _buildOrderSummary(context, cartProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCart(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppTheme.secondaryColor,
      child: Column(
        children: [
          _buildCartItemsList(context, cartProvider),
          const SizedBox(height: 32),
          _buildOrderSummary(context, cartProvider),
        ],
      ),
    );
  }

  Widget _buildCartItemsList(BuildContext context, CartProvider cartProvider) {
    final cartItems = cartProvider.items.values.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cart Items (${cartProvider.totalQuantity})',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 24),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartItems.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.grey,
            height: 40,
          ),
          itemBuilder: (context, index) {
            return _buildCartItem(context, cartItems[index], cartProvider);
          },
        ),
      ],
    );
  }

  Widget _buildCartItem(
      BuildContext context, CartItem cartItem, CartProvider cartProvider) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: AssetImage(cartItem.product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // Product details
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.product.name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cartItem.product.shortDescription,
                      style: GoogleFonts.lora(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              // Quantity selector
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      color: AppTheme.accentColor,
                      onPressed: () {
                        cartProvider.decreaseQuantity(cartItem.product.id);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${cartItem.quantity}',
                        style: GoogleFonts.lora(
                          fontSize: 16,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      color: AppTheme.accentColor,
                      onPressed: () {
                        cartProvider.increaseQuantity(cartItem.product.id);
                      },
                    ),
                  ],
                ),
              ),
              // Price
              Expanded(
                flex: 2,
                child: Text(
                  '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.lora(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Remove button
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: Colors.grey[400],
                onPressed: () {
                  cartProvider.removeItem(cartItem.product.id);
                },
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: AssetImage(cartItem.product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.product.name,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cartItem.product.shortDescription,
                          style: GoogleFonts.lora(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${cartItem.product.price.toStringAsFixed(2)}',
                          style: GoogleFonts.lora(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Remove button
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.grey[400],
                    onPressed: () {
                      cartProvider.removeItem(cartItem.product.id);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Quantity selector
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Quantity: ',
                    style: GoogleFonts.lora(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    color: AppTheme.accentColor,
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      cartProvider.decreaseQuantity(cartItem.product.id);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${cartItem.quantity}',
                      style: GoogleFonts.lora(
                        fontSize: 14,
                        color: AppTheme.textColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: AppTheme.accentColor,
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      cartProvider.increaseQuantity(cartItem.product.id);
                    },
                  ),
                  const Spacer(),
                  Text(
                    'Total: \$${cartItem.totalPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.lora(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentColor,
                    ),
                  ),
                ],
              ),
            ],
          );
  }

  Widget _buildOrderSummary(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 24),
          _buildSummaryRow('Subtotal', '\$${cartProvider.subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 12),
          _buildSummaryRow('Shipping', '\$${cartProvider.shippingCost.toStringAsFixed(2)}'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.grey),
          ),
          _buildSummaryRow(
            'Total',
            '\$${cartProvider.total.toStringAsFixed(2)}',
            isTotal: true,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to checkout page
                _showCheckoutDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Proceed to Checkout',
                style: GoogleFonts.lora(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/products');
              },
              child: Text(
                'Continue Shopping',
                style: GoogleFonts.lora(
                  fontSize: 14,
                  color: AppTheme.accentColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.lora(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppTheme.textColor,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.lora(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppTheme.accentColor : AppTheme.textColor,
          ),
        ),
      ],
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.secondaryColor,
        title: Text(
          'Order Confirmation',
          style: GoogleFonts.playfairDisplay(
            color: AppTheme.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Thank you for your order! This is a demo checkout page. In a real application, you would proceed to payment processing.',
          style: GoogleFonts.lora(
            color: AppTheme.textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // Clear cart after checkout
              Provider.of<CartProvider>(context, listen: false).clear();
              // Navigate to home
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Text(
              'OK',
              style: GoogleFonts.lora(
                color: AppTheme.accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF212121),
            ),
            child: Text(
              'POTTERY OF KUTCH',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(context, 'Home', Icons.home),
          _buildDrawerItem(context, 'About', Icons.info_outline),
          _buildDrawerItem(context, 'Products', Icons.shopping_bag),
          _buildDrawerItem(context, 'Cart', Icons.shopping_cart, isActive: true),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, {bool isActive = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppTheme.accentColor : const Color(0xFFD4AF37),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (title == 'Home') {
          Navigator.pushReplacementNamed(context, '/');
        } else if (title == 'About') {
          Navigator.pushReplacementNamed(context, '/about');
        } else if (title == 'Products') {
          Navigator.pushReplacementNamed(context, '/products');
        } else if (title == 'Cart' && !isActive) {
          Navigator.pushReplacementNamed(context, '/cart');
        }
      },
    );
  }
}
