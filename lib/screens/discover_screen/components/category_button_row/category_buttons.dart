import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front/domain/product_domain/product_provider.dart';

import 'button_item.dart';

class CategoryButtonRow extends StatefulWidget {
  const CategoryButtonRow({super.key});

  @override
  State<CategoryButtonRow> createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtonRow> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Lowest Price First", "Highest Price First"
    ];

    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CategoryButton(
              label: categories[index],
              index: index,
              selectedIndex: selectedIndex,
              onTap: (int selectedIndex) {
                setState(() {
                  this.selectedIndex = selectedIndex;
                });
                bool ascending = selectedIndex == 0;
                Provider.of<ProductProvider>(context, listen: false).sortProductsByPrice(ascending);
              },
            ),
          );
        },
      ),
    );
  }
}
