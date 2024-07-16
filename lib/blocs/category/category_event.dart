part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class LoadCategories extends CategoryEvent {}

class UpdateCategories extends CategoryEvent {
  final List<ProductCategory> categories;

  UpdateCategories(this.categories);

  @override
  List<Object> get props => [categories];
}