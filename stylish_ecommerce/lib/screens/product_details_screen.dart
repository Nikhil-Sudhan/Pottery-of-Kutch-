import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../utils/theme.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/footer.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      drawer: isDesktop ? null : _buildMobileDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: '/products'),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: _buildBreadcrumb(context),
            ),
            isDesktop
                ? _buildDesktopLayout(context)
                : _buildMobileLayout(context),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumb(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppTheme.accentColor,
              size: 18,
            ),
            label: Text(
              'Back to Products',
              style: GoogleFonts.lora(
                fontSize: 14,
                color: AppTheme.accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
      color: AppTheme.primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Product Image
          Expanded(
            flex: 5,
            child: _buildProductImage(),
          ),
          const SizedBox(width: 48),
          // Right side - Product Info
          Expanded(
            flex: 4,
            child: _buildProductInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      color: AppTheme.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          SizedBox(
            height: 350,
            width: double.infinity,
            child: _buildProductImage(),
          ),
          const SizedBox(height: 32),
          // Product Info
          _buildProductInfo(context),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Hero(
          tag: 'product-${product.id}',
          child: Image.asset(
            product.imageUrl,
            fit: BoxFit.contain,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 400,
                color: AppTheme.secondaryColor,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey[700],
                    size: 60,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: GoogleFonts.playfairDisplay(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'In Stock',
            style: GoogleFonts.lora(
              fontSize: 14,
              color: Colors.green[300],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: GoogleFonts.lora(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.accentColor,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Product Description',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: GoogleFonts.lora(
            fontSize: 16,
            color: Colors.grey[400],
            height: 1.6,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Category: ',
              style: GoogleFonts.lora(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
              ),
            ),
            Text(
              product.category,
              style: GoogleFonts.lora(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Handcrafted with love in India',
          style: GoogleFonts.lora(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Add to cart using provider
              Provider.of<CartProvider>(context, listen: false).addItem(product);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} added to cart!'),
                  backgroundColor: AppTheme.accentColor.withOpacity(0.8),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'VIEW CART',
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/cart');
                    },
                  ),
                ),
              );
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
              'Add to Cart',
              style: GoogleFonts.lora(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
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
              'ARTISANAL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(context, 'Home', Icons.home),
          _buildDrawerItem(context, 'Products', Icons.shopping_bag, isActive: true),
          _buildDrawerItem(context, 'Sign In', Icons.person),
          _buildDrawerItem(context, 'Cart', Icons.shopping_cart),
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
        } else if (title == 'Products' && !isActive) {
          Navigator.pushReplacementNamed(context, '/products');
        }
      },
    );
  }
}
