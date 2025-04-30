import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/about_screen.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artisanal E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/products': (context) => const ProductsScreen(),
        '/cart': (context) => const CartScreen(),
      },
      // Using onGenerateRoute for dynamic product details pages
      onGenerateRoute: (settings) {
        if (settings.name == '/product-details') {
          final Product product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          );
        }
        return null;
      },
    );
  }
}
