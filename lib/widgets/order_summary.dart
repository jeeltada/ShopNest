import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';

class OrderSummary extends StatelessWidget{
  const OrderSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded){
          return Column(
            children: [
              Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SUBTOTAL',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '\₹${state.cart.subtotalString}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'DELIVERY FEE',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '\₹${state.cart.deliveryFeeString}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(5.0),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                          ),
                          Text(
                            '\₹${state.cart.totalString}',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Display the number of products in the cart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Text(
                  'Total items: ${state.cart.products.length}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 16),
                ),
              ),
            ],
          );
        }
        else {
          return Text('Something went wrong!');
        }

  },
);
  }
}