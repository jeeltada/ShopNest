import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'dart:async'; // Import this for StreamSubscription

import '../../models/cart_model.dart';
import '../../models/checkout_model.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../repositories/checkouts/checkout_repository.dart';
import '../cart/cart_bloc.dart';

part 'checkoutss_event.dart';
part 'checkoutss_state.dart';

class CheckoutssBloc extends Bloc<CheckoutssEvent, CheckoutssState> {
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutssBloc({
    required CartBloc cartBloc,
    required CheckoutRepository checkoutRepository,
  })  :_cartBloc = cartBloc,
        _checkoutRepository = checkoutRepository,
        super(
          cartBloc.state is CartLoaded?
          CheckoutLoaded(
            products: (cartBloc.state as CartLoaded).cart.products,
            subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
            deliveryFee: (cartBloc.state as CartLoaded).cart.deliveryFeeString,
            total: (cartBloc.state as CartLoaded).cart.totalString,
          ) :
          CheckoutLoading()) {
    _cartSubscription = _cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        add(UpdateCheckout(cart: state.cart));
      }
    });
  }

  @override
  Stream<CheckoutssState> mapEventToState(
      CheckoutssEvent event,
      )async* {
    if (event is UpdateCheckout) {
      yield* _mapUpdateCheckoutToState(event, state);
    }
    if (event is ConfirmCheckout) {
      yield* _mapConfirmCheckoutToState(event, state);
    }
  }

  Stream<CheckoutssState> _mapUpdateCheckoutToState (
      UpdateCheckout event,
      CheckoutssState state,
      )async*{
    if (state is CheckoutLoaded){
      yield CheckoutLoaded(
        email: event.email ?? state.email,
        fullName: event.fullName ?? state.fullName,
        address: event.address ?? state.address,
        city: event.city ?? state.city,
        country: event.country ?? state.country,
        zipCode: event.zipCode ?? state.zipCode,
        products: event.cart?.products ?? state.products,
        subtotal: event.cart?.subtotalString ?? state.subtotal,
        deliveryFee: event.cart?.deliveryFeeString ?? state.deliveryFee,
        total: event.cart?.totalString ?? state.total,
      );
    }
  }

  Stream<CheckoutssState> _mapConfirmCheckoutToState(
      ConfirmCheckout event,
      CheckoutssState state,
      ) async* {
    if (state is CheckoutLoaded) {
      try {
        // Assuming _checkoutRepository.addCheckout returns void or Future<void>
        await _checkoutRepository.addCheckout(event.checkout);
        // Optionally, you can yield a loading state to indicate progress
        yield CheckoutLoading(); // Yield loading state if needed

        // After successful checkout, yield CheckoutSuccess or navigate to confirmation
        yield CheckoutSuccess(); // Example: Change state to success after checkout
      } catch (e) {
        print('Error adding checkout: ${e.toString()}');
      }
    }
  }

}
