import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopnestt_new/screens/cart/cart_screen.dart';
import 'package:shopnestt_new/screens/home/home_screen.dart';
import 'package:shopnestt_new/screens/screens.dart';
import 'package:shopnestt_new/models/category_model.dart';
import 'package:shopnestt_new/models/product_model.dart';

import '../screens/login/login_screen.dart';
import '../screens/order_confirmation/order_confirmation_screen.dart';
import '../screens/signup/signup_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings){
    print('This is route: ${settings.name}');

    switch(settings.name){
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as ProductCategory);
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case OrderConfirmation.routeName:
        final cartProducts = settings.arguments as List<Product>?;
        return OrderConfirmation.route(cartProducts ?? []);
      default:
        return _errorRoute();
    }
  }
  static Route _errorRoute(){
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(appBar: AppBar(title: Text('Error')),),
    );
  }
}