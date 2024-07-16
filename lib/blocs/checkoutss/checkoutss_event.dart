part of 'checkoutss_bloc.dart';

@immutable
sealed class CheckoutssEvent {}

class UpdateCheckout extends CheckoutssEvent {
  final String? email;
  final String? fullName;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final Cart? cart;

  UpdateCheckout({
    this.email,
    this.zipCode,
    this.address,
    this.country,
    this.city,
    this.fullName,
    this.cart,
  });

  @override
  List<Object?> get props => [
    email,
    fullName,
    address,
    city,
    country,
    zipCode,
    cart,
  ];

}

class ConfirmCheckout extends CheckoutssEvent {
  final Checkout checkout;

  ConfirmCheckout({required this.checkout});

  @override
  List<Object?> get props => [checkout];
}
