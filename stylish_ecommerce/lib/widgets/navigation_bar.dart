import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentRoute;

  const CustomNavigationBar({
    super.key,
    this.currentRoute = '/',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.secondaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Text(
            'POTTERY OF KUTCH',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          
          // Navigation Links - Desktop
          if (MediaQuery.of(context).size.width > 800)
            Row(
              children: [
                _buildNavItem('Home', currentRoute == '/', onTap: () {
                  if (currentRoute != '/') {
                    Navigator.pushReplacementNamed(context, '/');
                  }
                }),
                _buildNavItem('About', currentRoute == '/about', onTap: () {
                  if (currentRoute != '/about') {
                    Navigator.pushReplacementNamed(context, '/about');
                  }
                }),
                _buildNavItem('Products', currentRoute == '/products', onTap: () {
                  if (currentRoute != '/products') {
                    Navigator.pushReplacementNamed(context, '/products');
                  }
                }),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: currentRoute == '/cart' ? AppTheme.accentColor : AppTheme.textColor,
                  ),
                  onPressed: () {
                    if (currentRoute != '/cart') {
                      Navigator.pushReplacementNamed(context, '/cart');
                    }
                  },
                ),
              ],
            )
          else
            // Mobile menu icon
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: AppTheme.textColor,
              ),
              onPressed: () {
                // Show mobile drawer/menu
                Scaffold.of(context).openDrawer();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, bool isActive, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: Text(
          title,
          style: GoogleFonts.lora(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? AppTheme.accentColor : AppTheme.textColor,
          ),
        ),
      ),
    );
  }
}
