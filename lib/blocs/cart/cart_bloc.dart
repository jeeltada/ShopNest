import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/cart_model.dart';
import '../../models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(_onCartStarted);
    on<CartProductAdded>(_onCartProductAdded);
    on<CartProductRemoved>(_onCartProductRemoved);
  }

  void _onCartStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      emit(CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onCartProductAdded(CartProductAdded event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
          cart: Cart(
            products: List.from(state.cart.products)..add(event.product),
          ),
        ));
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onCartProductRemoved(CartProductRemoved event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
          cart: Cart(
            products: List.from(state.cart.products)..remove(event.product),
          ),
        ));
      } catch (_) {
        emit(CartError());
      }
    }
  }
}
