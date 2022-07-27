part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class GetCategoryLoading extends CategoryState {}
class GetCategorySuccess extends CategoryState {}
class GetCategoryError extends CategoryState {}

class AddProductToCartState extends CategoryState {}
