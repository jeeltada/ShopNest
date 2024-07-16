import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';
import '../../models/wishlist_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlist>(_onStartWishlist);
    on<AddWishlistProduct>(_onAddWishlistProduct);
    on<RemoveWishlistProduct>(_onRemoveWishlistProduct);
  }

  void _onStartWishlist(StartWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      emit(const WishlistLoaded(wishlist: Wishlist(products: [])));
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _onAddWishlistProduct(AddWishlistProduct event, Emitter<WishlistState> emit) {
    if (state is WishlistLoaded) {
      try {
        final List<Product> updatedProducts = List<Product>.from((state as WishlistLoaded).wishlist.products)
          ..add(event.product);
        emit(WishlistLoaded(wishlist: Wishlist(products: updatedProducts)));
      } catch (_) {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveWishlistProduct(RemoveWishlistProduct event, Emitter<WishlistState> emit) {
    if (state is WishlistLoaded) {
      try {
        final List<Product> updatedProducts = List<Product>.from((state as WishlistLoaded).wishlist.products)
          ..remove(event.product);
        emit(WishlistLoaded(wishlist: Wishlist(products: updatedProducts)));
      } catch (_) {
        emit(WishlistError());
      }
    }
  }


  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    // No need to handle events here as we are using on method above.
  }
}