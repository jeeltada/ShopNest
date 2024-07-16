import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopnestt_new/models/category_model.dart';
import 'package:shopnestt_new/widgets/custom_appbar.dart';
import 'package:shopnestt_new/widgets/widgets.dart';
import '../../models/product_model.dart';
import '../../widgets/custom_navbar.dart';
import '../../widgets/full_width_product_card.dart';



class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';
  static Route route({required ProductCategory category}){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CatalogScreen(category: category),
    );
  }
  final ProductCategory category;
  const CatalogScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products.where((product) => product.category == category.name).toList();
    return Scaffold(
        appBar: CustomAppBar(title:category.name),
        bottomNavigationBar: CustomNavBar(),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          itemCount: categoryProducts.length,
          itemBuilder: (BuildContext context, int index){
            return FullWidthProductCard(
              product: categoryProducts[index],
              //widthFactor: 2.2,
            );
          },
        )
    );
  }
}