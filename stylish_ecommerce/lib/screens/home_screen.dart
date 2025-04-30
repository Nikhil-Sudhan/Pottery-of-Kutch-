import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/featured_products.dart';
import '../widgets/craftsmanship_section.dart';
import '../widgets/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MediaQuery.of(context).size.width <= 800
          ? _buildMobileDrawer(context)
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: '/'),
            const HeroSection(),
            FeaturedProducts(products: demoProducts),
            const CraftsmanshipSection(),
            const Footer(),
          ],
        ),
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
          _buildDrawerItem(context, 'Home', Icons.home, isActive: true),
          _buildDrawerItem(context, 'About', Icons.info_outline),
          _buildDrawerItem(context, 'Products', Icons.shopping_bag),
          _buildDrawerItem(context, 'Cart', Icons.shopping_cart),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, {bool isActive = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? const Color(0xFFD4AF37) : Colors.grey[400],
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
        if (title == 'Products') {
          Navigator.pushReplacementNamed(context, '/products');
        } else if (title == 'About') {
          Navigator.pushReplacementNamed(context, '/about');
        } else if (title == 'Cart') {
          Navigator.pushReplacementNamed(context, '/cart');
        }
      },
    );
  }
}
