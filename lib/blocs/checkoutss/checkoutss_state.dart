part of 'checkoutss_bloc.dart';

@immutable
abstract class CheckoutssState extends Equatable {
  const CheckoutssState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutssState {}

class CheckoutLoaded extends CheckoutssState {
  final String? email;
  final String? fullName;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  final Checkout checkout;

  CheckoutLoaded({
    this.email,
    this.products,
    this.subtotal,
    this.deliveryFee,
    this.total,
    this.fullName,
    this.address,
    this.city,
    this.country,
    this.zipCode,
  }) : checkout = Checkout(
    fullName: fullName,
    email: email,
    address: address,
    city: city,
    country: country,
    zipCode: zipCode,
    products: products,
    subtotal: subtotal,
    total: total,
    deliveryFee: deliveryFee,
  );
  @override
  List<Object?> get props => [
    fullName,
    email,
    address,
    city,
    country,
    zipCode,
    products,
    subtotal,
    total,
    deliveryFee,
  ];

}

class CheckoutSuccess extends CheckoutssState {}

class CheckoutFailure extends CheckoutssState {}
