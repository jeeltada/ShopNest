import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategory extends Equatable{
  final String name;
  final String imageUrl;

  const ProductCategory({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
    name,
    imageUrl
  ];

  static ProductCategory fromSnapshot(DocumentSnapshot snap){
    ProductCategory productCategory = ProductCategory(name: snap['name'], imageUrl: snap['imageUrl']);
    return productCategory;
  }

  static List<ProductCategory> categories = [
    ProductCategory(
        name: 'Household Supplies',
        imageUrl: 'https://media.istockphoto.com/id/1309230401/photo/brushes-sponges-rubber-gloves-and-natural-cleaning-products-in-the-basket.jpg?s=612x612&w=0&k=20&c=uDThSSDg2WnREa1qOFjtvC_hP8KPbdHdFOLYIyQsFDU='
    ),
    ProductCategory(
        name: 'Personal Care',
        imageUrl: 'https://static01.nyt.com/images/2017/11/14/t-magazine/fashion/14tmag-bath-01/14tmag-bath-01-videoSixteenByNineJumbo1600.jpg'
    ),
    ProductCategory(
        name: 'Food & Beverages',
        imageUrl: 'https://d2t3trus7wwxyy.cloudfront.net/catalog/product/cache/d166c7ea81ddc4172de536322110c911/t/a/tang-orange-375g_2.jpg'
    ),
    ProductCategory(
        name: 'Baby Care',
        imageUrl: 'https://allibhavan.com/cdn/shop/collections/baby_care_-_baby_products.jpg?v=1666170648'
    ),

  ];
}
