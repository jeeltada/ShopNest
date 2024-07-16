import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnestt_new/widgets/custom_appbar.dart';
import 'package:shopnestt_new/widgets/custom_navbar.dart';
import 'package:shopnestt_new/widgets/order_summary_product_card.dart';

import '../../models/product_model.dart';
import '../../widgets/order_summary.dart';

class OrderConfirmation extends StatelessWidget {
  final List<Product> cartProducts;

  OrderConfirmation({required this.cartProducts});

  static const String routeName = '/order-confirmation';

  static Route route(List<Product> cartProducts) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrderConfirmation(cartProducts: cartProducts),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Order Confirmation'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  // Handle checkout action
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Back To Shopping',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width - 10) / 2.5,
                  top: 120,
                  child: SvgPicture.asset(
                    'assets/svgs/garlands-svgrepo-com.svg',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  top: 250,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Your order is complete!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDER CODE: #k321-ekd3',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Thank You for purchasing on ShopNest.',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 10),
                  OrderSummary(),
                  SizedBox(height: 10),
                  Text(
                    'ORDER DETAILS',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Divider(thickness: 2),
                  SizedBox(height: 5),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      return OrderSummaryProductCard(
                        product: cartProducts[index],
                        quantity: 1, // Assuming each product quantity is 1, adjust as necessary
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
