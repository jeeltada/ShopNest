import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnestt_new/widgets/custom_appbar.dart';
import 'package:shopnestt_new/widgets/custom_navbar.dart';
import 'package:shopnestt_new/widgets/order_summary.dart';

import '../../blocs/checkoutss/checkoutss_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';
  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Checkout'),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<CheckoutssBloc, CheckoutssState>(
                  builder: (context, state) {
                    if (state is CheckoutLoading){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CheckoutLoaded){
                      final cartProducts = state.products;
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pushNamed(context, '/order-confirmation', arguments: cartProducts);
                          context.read<CheckoutssBloc>().add(ConfirmCheckout(checkout: state.checkout));
                          // Handle checkout action
                          //Navigator.pushNamed(context, '/order-confirmation');
                        },
                        child: Text(
                          'ORDER NOW',
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
                        ),
                      );
                    }
                    else {
                      return Text('Something went wrong!!');
                    }
                  },),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<CheckoutssBloc, CheckoutssState>(
            builder: (context, state) {
              if (state is CheckoutLoading){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CheckoutLoaded){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CUSTOMER INFORMATON",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    _buildTextFormField((value){
                      context.read<CheckoutssBloc>().add(
                        UpdateCheckout(email: value),
                      );
                    }, context, 'Email'),
                    _buildTextFormField((value){
                      context.read<CheckoutssBloc>().add(
                        UpdateCheckout(fullName: value),
                      );
                    }, context, 'Full Name'),
                    Text(
                      "DELIVERY INFORMATON",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    _buildTextFormField((value){
                      context.read<CheckoutssBloc>().add(
                        UpdateCheckout(address: value),
                      );
                    }, context, 'Address'),
                    _buildTextFormField((value){
                      context.read<CheckoutssBloc>().add(
                        UpdateCheckout(city: value),
                      );
                    }, context, 'City'),
                    _buildTextFormField((value){
                      context.read<CheckoutssBloc>().add(
                        UpdateCheckout(country: value),
                      );
                    }, context, 'Country'),
                    _buildTextFormField((value){
                      context.read<CheckoutssBloc>().add(
                        UpdateCheckout(zipCode: value),
                      );
                    }, context, 'Zip Code'),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              'SELECT A PAYMENT METHOD',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),

                    Text(
                      "ORDER SUMMARY",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    OrderSummary(),
                  ],
                );
              }
              else{
                return Text('Something went wrong!');
              }
            },
          ),
        )
    );
  }
  Padding _buildTextFormField(
      Function(String)? onChanged,
      BuildContext context,
      String labelText,
      ){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child:
            TextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 10.0),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
