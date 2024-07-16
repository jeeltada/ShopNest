import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnestt_new/models/category_model.dart';
import 'package:shopnestt_new/widgets/custom_appbar.dart';
import 'package:shopnestt_new/widgets/widgets.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../models/product_model.dart';
import '../../widgets/custom_navbar.dart';
import '../../widgets/full_width_product_card.dart';


class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, '/'));
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.authUser != current.authUser,
      listener: (context, state) {
        print('splash screen Auth Listener');
      },
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image(image: AssetImage('assets/images/ShopNest.png'),
                  width: 200,
                  height: 200,
                ),
              ),
              // Container(
              //   child: Text('ShopNest',
              //     style: Theme.of(context)
              //         .textTheme
              //         .headlineLarge!
              //         .copyWith(color: Colors.black, fontSize: 45),
              //   ),
              // )
            ],
          )
      ),
    );
  }
}