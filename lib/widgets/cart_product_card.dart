import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../models/product_model.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartProductCard({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              product.imageUrl,
              width: 110,
              height: 110,
              //fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    product.details,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${product.price}",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black),
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(CartProductRemoved(product));
                                  // Define the action to be taken when the button is pressed
                                  // For example, you can add the product to the cart or show a dialog
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product.name} removed from cart!',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              Text('$quantity', style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.black),
                              ),

                              IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(CartProductAdded(product));
                                  // Define the action to be taken when the button is pressed
                                  // For example, you can add the product to the cart or show a dialog
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product.name} added to cart!',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      )


                      // isWishlist
                      //     ? Expanded(
                      //   child: IconButton(
                      //     icon: Icon(
                      //       Icons.delete,
                      //       color: Colors.black,
                      //     ),
                      //     onPressed: (){},
                      //   ),
                      // )
                      //     : SizedBox(),
                    ],
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