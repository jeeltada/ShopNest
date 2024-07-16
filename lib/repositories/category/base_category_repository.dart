import 'package:shopnestt_new/models/category_model.dart';

abstract class BaseCategoryRepository {
  Stream<List<ProductCategory>> getAllCategories();
}