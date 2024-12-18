
import 'package:flutter/material.dart';
import '../../../../model/product.dart';
import '../product_card/product_item.dart';


class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        mainAxisExtent: 260,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductItem(
          productName: product.title,
          productImageUrl: product.image,
          productPrice: product.price,
          productCategory: product.category,
          productDescription: product.description,
        );
      },
    );
  }
}
