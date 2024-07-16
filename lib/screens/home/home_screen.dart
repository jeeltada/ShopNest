import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnestt_new/widgets/custom_appbar.dart';
import 'package:shopnestt_new/widgets/widgets.dart';

import '../../blocs/category/category_bloc.dart';
import '../../blocs/products/products_bloc.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../widgets/custom_navbar.dart';
import '../../widgets/hero_carousel_card.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ShopNest'),
      bottomNavigationBar: CustomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CategoryLoaded) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.5,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      items: state.categories
                          .map((category) => HeroCarouselCard(category: category))
                          .toList(),
                    );
                  } else {
                    return Text('Something went wrong!');
                  }
                },
              ),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return Column(
                    children: [
                      SectionWithCarousel(
                        title: 'RECOMMENDED',
                        products: state.products.where((product) => product.isRecommended).toList(),
                      ),
                      SectionWithCarousel(
                        title: 'MOST POPULAR',
                        products: state.products.where((product) => product.isPopular).toList(),
                      ),
                    ],
                  );
                } else {
                  return Text('Something went wrong!');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SectionWithCarousel extends StatelessWidget {
  final String title;
  final List<Product> products;

  const SectionWithCarousel({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: title),
        Container(
          height: 260, // Adjust the height as needed
          child: ProductCarousel(products: products),
        ),
      ],
    );
  }
}
