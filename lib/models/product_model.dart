import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String details;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;


  const Product({
    required this.name,
    required this.category,
    required this.details,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,

  });
  // Convert Product instance to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'details': details,
      'imageUrl': imageUrl,
      'price': price,
      'isRecommended': isRecommended,
      'isPopular': isPopular,

    };
  }

  static Product fromSnapshot(DocumentSnapshot snap){
    Product product = Product(
        name: snap['name'],
        category: snap['category'],
        details: snap['details'],
        imageUrl: snap['imageUrl'],
        price: snap['price'] is int
            ? (snap['price'] as int).toDouble()
            : snap['price'] as double,
        isRecommended: snap['isRecommended'],
        isPopular: snap['isPopular'],

    );
    return product;
  }

  @override
  List<Object?> get props => [
    name,
    category,
    details,
    imageUrl,
    price,
    isRecommended,
    isPopular,

  ];

  static List<Product> products = [
    Product(
      name: 'Vim ',
      category: 'Household Supplies',
      details: 'Vim Dishwash Liquid Gel Lemon Refill Pouch, 2 Ltr',
      imageUrl: 'https://www.jiomart.com/images/product/original/492519279/vim-lemon-dishwash-liquid-2-l-product-images-o492519279-p590841719-0-202401041737.jpg?im=Resize=(420,420)',
      price: 360,
      isRecommended: true,
      isPopular: true,

    ),
    Product(
      name: 'Surf Excel ',
      category: 'Household Supplies',
      details: 'Surf Excel Matic Powder Front Load 6 Kg',
      imageUrl: 'https://images-eu.ssl-images-amazon.com/images/I/61jQnfUMq+L._AC_UL600_SR600,600_.jpg',
      price: 1475,
      isRecommended: false,
      isPopular: true,

    ),
    Product(
      name: 'Himalaya ',
      category: 'Baby Care',
      details: 'Himalaya Gentle Baby Shampoo 100ml',
      imageUrl: 'https://himalayawellness.in/cdn/shop/products/gentle-baby-shampoo-100ml.jpg?v=1622100852',
      price: 205,
      isRecommended: true,
      isPopular: false,

    ),
    Product(
      name: 'Cetaphil ',
      category: 'Personal Care',
      details: 'Cetaphil Gentle Skin Cleanser 125ml',
      imageUrl: 'https://m.media-amazon.com/images/I/71t9JRry+3L.jpg',
      price: 333,
      isRecommended: false,
      isPopular: true,

    ),
    Product(
      name: "L'Oreal Paris ",
      category: 'Personal Care',
      details: "L'Oreal Paris Serum 100ml",
      imageUrl: 'https://m.media-amazon.com/images/I/51FRsJvhucL.jpg',
      price: 357,
      isRecommended: true,
      isPopular: false,

    ),
    Product(
      name: 'NESCAFE ',
      category: 'Food & Beverages',
      details: 'NESCAFE Gold Blend 50gm',
      imageUrl: 'https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/zsy3khdqevqedrdlhl3c',
      price: 350,
      isRecommended: true,
      isPopular: true,

    ),


  ];
}