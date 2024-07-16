part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<ProductCategory> categories;

  CategoryLoaded({this.categories = const <ProductCategory>[]});

  @override
  List<Object> get props => [categories];
}
