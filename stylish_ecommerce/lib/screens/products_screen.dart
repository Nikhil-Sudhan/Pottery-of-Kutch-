import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../utils/theme.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/footer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductService _productService = ProductService();
  final TextEditingController _searchController = TextEditingController();
  
  String _selectedCategory = 'All';
  List<String> _categories = ['All'];
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final products = await _productService.getProducts();
      final categories = await _productService.getCategories();

      setState(() {
        _products = products;
        _filteredProducts = products;
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      debugPrint('Error loading products: $e');
    }
  }

  void _filterProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Product> filtered;
      
      // First filter by category
      if (_selectedCategory == 'All') {
        filtered = _products;
      } else {
        filtered = _products.where((p) => p.category == _selectedCategory).toList();
      }
      
      // Then filter by search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        filtered = filtered.where((p) => 
          p.name.toLowerCase().contains(query) ||
          p.shortDescription.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query)
        ).toList();
      }

      setState(() {
        _filteredProducts = filtered;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error filtering products: $e');
    }
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    _filterProducts();
  }

  void _handleCategoryChange(String? category) {
    if (category != null) {
      setState(() {
        _selectedCategory = category;
      });
      _filterProducts();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Determine grid columns based on screen width
    int crossAxisCount;
    if (screenWidth > 1200) {
      crossAxisCount = 4; // Large screens
    } else if (screenWidth > 800) {
      crossAxisCount = 3; // Medium screens
    } else if (screenWidth > 600) {
      crossAxisCount = 2; // Small screens
    } else {
      crossAxisCount = 1; // Extra small screens
    }

    return Scaffold(
      drawer: screenWidth <= 800 ? _buildMobileDrawer(context) : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: '/products'),
            _buildPageHeader(),
            SearchFilterBar(
              searchController: _searchController,
              onSearch: _handleSearch,
              selectedCategory: _selectedCategory,
              categories: _categories,
              onCategoryChanged: _handleCategoryChange,
            ),
            _isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(
                        color: AppTheme.accentColor,
                      ),
                    ),
                  )
                : _buildProductsGrid(crossAxisCount),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppTheme.primaryColor,
      child: Column(
        children: [
          Text(
            'All Products',
            style: GoogleFonts.playfairDisplay(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Explore our handcrafted collection made by Indian artisans.',
            style: GoogleFonts.lora(
              fontSize: 18,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            width: 100,
            height: 2,
            color: AppTheme.accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(int crossAxisCount) {
    if (_filteredProducts.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(60),
        child: Center(
          child: Text(
            'No products found.',
            style: AppTheme.subheadingStyle,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Showing ${_filteredProducts.length} products',
              style: AppTheme.bodyStyle,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.7,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: 'product-${_filteredProducts[index].id}',
                child: ProductCard(
                  product: _filteredProducts[index],
                  onPressed: () {
                    // Navigate to product details
                    Navigator.pushNamed(
                      context, 
                      '/product-details',
                      arguments: _filteredProducts[index],
                    );
                  },
                ),
              );
            },
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
          _buildDrawerItem(context, 'Products', Icons.shopping_bag, isActive: true),
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
        if (title == 'Home' && !isActive) {
          Navigator.pushReplacementNamed(context, '/');
        } else if (title == 'About' && !isActive) {
          Navigator.pushReplacementNamed(context, '/about');
        } else if (title == 'Cart') {
          Navigator.pushReplacementNamed(context, '/cart');
        }
      },
    );
  }
}
