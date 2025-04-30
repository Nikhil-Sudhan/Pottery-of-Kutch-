import 'package:flutter/material.dart';
import '../utils/theme.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String) onSearch;
  final String selectedCategory;
  final List<String> categories;
  final void Function(String?) onCategoryChanged;

  const SearchFilterBar({
    super.key,
    required this.searchController,
    required this.onSearch,
    required this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: AppTheme.primaryColor,
      child: isDesktop
          ? Row(
              children: [
                Expanded(child: _buildSearchField()),
                const SizedBox(width: 16),
                _buildCategoryDropdown(),
              ],
            )
          : Column(
              children: [
                _buildSearchField(),
                const SizedBox(height: 16),
                _buildCategoryDropdown(),
              ],
            ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      style: TextStyle(color: AppTheme.textColor),
      decoration: InputDecoration(
        hintText: 'Search products...',
        hintStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
        filled: true,
        fillColor: AppTheme.secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      onChanged: onSearch,
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: false,
          hint: Text('Select Category', style: TextStyle(color: Colors.grey[500])),
          icon: const Icon(Icons.arrow_drop_down, color: AppTheme.accentColor),
          dropdownColor: AppTheme.secondaryColor,
          style: const TextStyle(color: AppTheme.textColor),
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: onCategoryChanged,
        ),
      ),
    );
  }
}
