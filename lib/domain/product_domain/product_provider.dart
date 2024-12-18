import 'package:flutter/cupertino.dart';
import 'package:store_front/domain/product_domain/product_service.dart';
import '../../model/product.dart';

class ProductProvider with ChangeNotifier {
  final ProductService productService;

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<String> _categories = [];
  String? _selectedCategory;

  Map<String, String> _categoryImages = {};

  ProductProvider({required this.productService});

  List<Product> get products => _filteredProducts;

  List<String> get categories => _categories;

  String? get selectedCategory => _selectedCategory;

  String? getCategoryImage(String category) {
    return _categoryImages[category];
  }

  Map<String, String> getCategoryImages() {
    return {
      "electronics": "assets/electro.jpg",
      "jewelery": "assets/jewellery.jpg",
      "men's clothing": "assets/mens.jpg",
      "women's clothing": "assets/womens.jpg",
    };
  }

  Future<void> fetchProducts() async {
    try {
      _products = await productService.fetchProducts();
      _categories = productService.getCategories(_products);
      _categoryImages = getCategoryImages();
      _filteredProducts = _products;
      notifyListeners();
    } catch (e, stacktrace) {
      print('Error fetching products: $e, $stacktrace');
    }
  }

  void filterProductsByCategory(String? category) {
    _selectedCategory = category;
    if (category == null || category.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts =
          _products.where((product) => product.category == category).toList();
    }
    notifyListeners();
  }

  void sortProductsByPrice(bool ascending) {
    _filteredProducts.sort((a, b) =>
        ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    notifyListeners();
  }

  void filterProductsBySearch(String query) {
    if (query.isEmpty) {
      _filteredProducts = products;
    } else {
      _filteredProducts = products.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase()) ||
            product.category.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
