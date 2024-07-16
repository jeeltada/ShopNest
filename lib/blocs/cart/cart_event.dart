part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartStarted extends CartEvent {

  @override
  List<Object> get props => [];
}

class CartProductAdded extends CartEvent {
  final Product product;

  CartProductAdded(this.product);

  @override
  List<Object> get props => [product];
}

class CartProductRemoved extends CartEvent {
  final Product product;

  CartProductRemoved(this.product);

  @override
  List<Object> get props => [product];
}