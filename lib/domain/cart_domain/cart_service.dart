import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart.dart';

class CartService {
  final http.Client client;

  CartService({required this.client});

  Future<List<CartItem>> fetchCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedCartItems = prefs.getStringList('cart_items');

    if (cachedCartItems != null && cachedCartItems.isNotEmpty) {
      return cachedCartItems
          .map((itemJson) => CartItem.fromJson(json.decode(itemJson)))
          .toList();
    }

    return await _fetchFromApi();
  }

  Future<List<CartItem>> _fetchFromApi() async {
    final response =
        await client.get(Uri.parse('https://fakestoreapi.com/carts'));

    if (response.statusCode == 200) {
      List<dynamic> cartData = json.decode(response.body);
      List<CartItem> cartItems = [];

      for (var cart in cartData) {
        for (var product in cart['products']) {
          var productResponse = await client.get(Uri.parse(
              'https://fakestoreapi.com/products/${product['productId']}'));

          if (productResponse.statusCode == 200) {
            var productData = json.decode(productResponse.body);
            cartItems.add(CartItem.fromJson({
              'productId': product['productId'],
              'title': productData['title'],
              'price': productData['price'],
              'quantity': product['quantity'],
              'image': productData['image'],
            }));
          } else {
            throw Exception('Failed to load product details');
          }
        }
      }

      await _saveCartItemsToPrefs(cartItems);

      return cartItems;
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> _saveCartItemsToPrefs(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = cartItems.map((item) => json.encode(item)).toList();
    await prefs.setStringList('cart_items', cartData);
  }
}
