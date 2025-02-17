import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopnestt_new/models/product_model.dart'; // Import Product model

class Checkout extends Equatable {
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


  const Checkout({
    required this.email,
    required this.fullName,
    required this.address,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,

  });

  @override
  List<Object?> get props => [
    email,
    fullName,
    address,
    city,
    country,
    zipCode,
    products,
    subtotal,
    total,
    deliveryFee,
  ];

  Map<String, Object> toDocument() {
    Map customerAddress = Map();
    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['zipCode'] = zipCode;

    return {
      'customerAddress': customerAddress,
      'customerName': fullName ?? '',
      'customerEmail': email ?? '',
      'products': products?.map((product) => product.name).toList() ?? [],
      'subtotal': subtotal ?? '',
      'deliveryFee': deliveryFee ?? '',
      'total': total ?? '',
    };
  }
}
