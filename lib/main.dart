import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnestt_new/blocs/auth/auth_bloc.dart';

import 'package:shopnestt_new/blocs/cart/cart_bloc.dart';
import 'package:shopnestt_new/blocs/category/category_bloc.dart';
import 'package:shopnestt_new/blocs/checkoutss/checkoutss_bloc.dart';
import 'package:shopnestt_new/blocs/products/products_bloc.dart';
import 'package:shopnestt_new/config/app_router.dart';
import 'package:shopnestt_new/config/theme.dart';
import 'package:shopnestt_new/cubits/login/login_cubit.dart';
import 'package:shopnestt_new/cubits/signup/signup_cubit.dart';
import 'package:shopnestt_new/firebase_options.dart';
import 'package:shopnestt_new/repositories/auth/auth_repository.dart';

import 'package:shopnestt_new/repositories/category/category_repository.dart';
import 'package:shopnestt_new/repositories/checkouts/checkout_repository.dart';
import 'package:shopnestt_new/repositories/product/product_repository.dart';
import 'package:shopnestt_new/repositories/user/user_repository.dart';
import 'package:shopnestt_new/screens/order_confirmation/order_confirmation_screen.dart';

import 'package:shopnestt_new/screens/screens.dart';

import 'blocs/wishlist/wishlist_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [

        RepositoryProvider(
          create: (context)=> UserRepository(),
        ),
        RepositoryProvider(
          create: (context)=> AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (_) => CategoryRepository(),
        ),
        RepositoryProvider<ProductRepository>(
          create: (_) => ProductRepository(),
        ),
        RepositoryProvider<CheckoutRepository>(
          create: (_) => CheckoutRepository(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (_) => WishlistBloc()..add(StartWishlist())),
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(
          create: (context) => CheckoutssBloc(
            cartBloc: context.read<CartBloc>(),
            checkoutRepository: context.read<CheckoutRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: context.read<CategoryRepository>(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            productRepository: context.read<ProductRepository>(),
          )..add(LoadProducts()),
        ),
        BlocProvider(
          create: (context)=> AuthBloc(
            authRepository: context.read<AuthRepository>(),
            userRepository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider(
          create: (context)=> LoginCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider(
          create: (context)=> SignupCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'ShopNest',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
