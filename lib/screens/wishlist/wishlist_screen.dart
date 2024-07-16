import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnestt_new/blocs/wishlist/wishlist_bloc.dart';
import 'package:shopnestt_new/models/product_model.dart';
import 'package:shopnestt_new/widgets/custom_appbar.dart';
import 'package:shopnestt_new/widgets/widgets.dart';

import '../../widgets/custom_navbar.dart';


class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';
  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => WishlistScreen(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title:'Wishlist'),
        bottomNavigationBar: CustomNavBar(),
        body: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state){
              if (state is WishlistLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(state is WishlistLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  itemCount: state.wishlist.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FullWidthProductCard(
                      product: state.wishlist.products[index],
                      isWishlist: true,
                      //widthFactor: 2.2,
                    );
                  },
                );
              }
              else {
                return Text('Something went wrong');
              }
            }
        )
    );
  }
}