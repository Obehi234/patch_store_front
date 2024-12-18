import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/product_domain/product_provider.dart';
import 'components/category_button_row/category_buttons.dart';
import 'components/horizontal_list/categories.dart';
import 'components/product_grid/product_grid.dart';
import 'components/search_bar/search_bar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF7A6EAE),
            title: const Text(""),
            // flexibleSpace: const SafeArea(
            //     child: AppSearchBar()
            // ),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, _) {
                  if(productProvider.products.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15,),
                      const Text("Choose from any category",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      CategoryFilter(categories: productProvider.categories),
                      const SizedBox(height: 10,),
                      Text("${productProvider.products.length} products to choose from", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 8,),
                      const SizedBox(height: 60,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: CategoryButtonRow(),
                        ),),
                      const SizedBox(height: 8,),
                      Expanded(child: ProductGrid(products: productProvider.products))
                    ],
                  );
                },
              )
          ),
        ),

        const Positioned(
          top: 50,
            right: 16,
            left: 16,
            child: AppSearchBar())
      ],
    );
  }
}
