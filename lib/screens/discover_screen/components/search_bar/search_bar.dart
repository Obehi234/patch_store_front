import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/product_domain/product_provider.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4
              )
            ]
        ),
        child:  Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.grey,
              size: 24.0,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  context.read<ProductProvider>().filterProductsBySearch(value);
                },
                decoration: const InputDecoration(
                  hintText: "What are you looking for?",
                  hintStyle: TextStyle(color: Color(0xFF717171)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}