import 'package:equatable/equatable.dart';
import 'package:shopnestt_new/models/product_model.dart';

class Cart extends Equatable {
  final List<Product> products;
  const Cart({this.products = const <Product>[]});

  Map productquantity(products){
    var quantity = Map();

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      }
      else {
        quantity[product] +=1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double deliveryFee(double subtotal) {
    if (subtotal >= 500.0) {
      return 0.0;
    } else {
      return 20.0;
    }
  }

  double total(double subtotal, double Function(double) deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }

  String freeDelivery(double subtotal) {
    if (subtotal >= 500.0) {
      return 'You Have Free Delivery';
    } else {
      double missing = 500.0 - subtotal;
      return 'Add \₹${missing.toStringAsFixed(2)} for Free Delivery';
    }
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);
  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);
  String get freeDeliveryString => freeDelivery(subtotal);


  @override
  List<Object?> get props => [products];
}
