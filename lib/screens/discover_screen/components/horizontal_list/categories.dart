import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front/domain/product_domain/product_provider.dart';

class CategoryFilter extends StatefulWidget {
  final List<String> categories;

  const CategoryFilter({super.key, required this.categories});

  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  int selectedIndex = -1;

  String capitalizeText(String text) {
    return text.split(' ').map((word) {
      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '';
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortedCategories = List.from(widget.categories);
    sortedCategories.sort((a, b) => a.compareTo(b));

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sortedCategories.length,
        itemBuilder: (context, index) {
          String category = sortedCategories[index];
          bool isSelected = selectedIndex == index;

          String? categoryImage =
              Provider.of<ProductProvider>(context).getCategoryImage(category);

          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = isSelected ? -1 : index;
                });
                Provider.of<ProductProvider>(context, listen: false)
                    .filterProductsByCategory(isSelected ? null : category);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          border: isSelected
                              ? Border.all(color: Colors.green, width: 3)
                              : Border.all(color: Colors.transparent),
                        ),
                        child: categoryImage != null
                            ? ClipOval(
                                child: Image.asset(
                                  categoryImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              )
                            : const Icon(Icons.error)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    capitalizeText(category),
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
