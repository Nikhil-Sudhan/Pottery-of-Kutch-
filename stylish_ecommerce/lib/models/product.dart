class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final String shortDescription;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.shortDescription,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      shortDescription: json['shortDescription'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'shortDescription': shortDescription,
    };
  }
}

// Sample product data
final List<Product> demoProducts = [
  Product(
    id: '1',
    name: 'Handwoven Basket',
    price: 79.99,
    imageUrl: 'assets/images/product_1.webp',
    description: 'Intricately handwoven basket made from sustainable materials.',
    category: 'Home Decor',
    shortDescription: 'Sustainable handwoven basket',
  ),
  Product(
    id: '2',
    name: 'Ceramic Vase',
    price: 89.99,
    imageUrl: 'assets/images/product_2.webp',
    description: 'Hand-thrown ceramic vase with unique glazing technique.',
    category: 'Pottery',
    shortDescription: 'Glazed artisan ceramic vase',
  ),
  Product(
    id: '3',
    name: 'Handcrafted Jewelry Box',
    price: 129.99,
    imageUrl: 'assets/images/product_3.webp',
    description: 'Elegantly designed wooden jewelry box with intricate carvings.',
    category: 'Woodcraft',
    shortDescription: 'Intricately carved wooden box',
  ),
  Product(
    id: '4',
    name: 'Artisanal Scarf',
    price: 49.99,
    imageUrl: 'assets/images/product_4.webp',
    description: 'Hand-dyed scarf using traditional techniques and premium fabrics.',
    category: 'Textile',
    shortDescription: 'Hand-dyed premium fabric scarf',
  ),
  Product(
    id: '5',
    name: 'Handmade Leather Journal',
    price: 59.99,
    imageUrl: 'assets/images/product_5.webp',
    description: 'Meticulously crafted leather journal with handmade paper.',
    category: 'Stationery',
    shortDescription: 'Handcrafted leather-bound journal',
  ),
  Product(
    id: '6',
    name: 'Artisan Candle Set',
    price: 39.99,
    imageUrl: 'assets/images/product_6.webp',
    description: 'Hand-poured natural wax candles with essential oil fragrances.',
    category: 'Home Decor',
    shortDescription: 'Natural wax essential oil candles',
  ),
];
