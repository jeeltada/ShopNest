import 'package:shopnestt_new/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}