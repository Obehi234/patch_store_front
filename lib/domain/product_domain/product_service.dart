
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/product.dart';

class ProductService {
  final http.Client client;

  ProductService({required this.client});

  Future<List<Product>> fetchProducts() async {

    final prefs = await SharedPreferences.getInstance();


    final cachedProductItems = prefs.getStringList('products');

    if(cachedProductItems != null && cachedProductItems.isNotEmpty) {
      return cachedProductItems.map((itemJson) => Product.fromJson(json.decode(itemJson))).toList();
    }

    List<Product> allProducts = [];
    int page = 1;
    int limit = 20;

    while (allProducts.length < 50) {
      final response = await client.get(
        Uri.parse('https://fakestoreapi.com/products?limit=$limit&page=$page'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        allProducts.addAll(data.map((json) => Product.fromJson(json)).toList());
        if (allProducts.length >= 50) {
          break;
        }
        page++;
      } else {
        throw Exception('Failed to load products');
      }
    }
    await _saveProductItemsToPrefs(allProducts);
    return allProducts;
  }

  Future<void> _saveProductItemsToPrefs(List<Product> productItems) async {
    final prefs = await SharedPreferences.getInstance();
    final productData = productItems.map((item) => json.encode(item)).toList();
    await prefs.setStringList('products', productData);
  }

  List<String> getCategories(List<Product> products) {
    Set<String> categoriesSet = {};
    for (var product in products) {
      categoriesSet.add(product.category);
    }
    return categoriesSet.toList();
  }
}







