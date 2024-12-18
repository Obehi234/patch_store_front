import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String productName;
  final String productImageUrl;
  final double productPrice;
  final String productCategory;
  final String productDescription;

  const ProductItem({
    super.key,
    required this.productName,
    required this.productImageUrl,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 210,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: const Color(0xFFCACACA),
              width: 1,
              style: BorderStyle.solid)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 140,
                child: Image.network(productImageUrl,
                    fit: BoxFit.contain, width: double.infinity)),
            const SizedBox(height: 8),
            Text(
              productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              productDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Color(0xFF7C7C7C),
              ),
            ),
            const SizedBox(height: 4),
            Text('\$${productPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
