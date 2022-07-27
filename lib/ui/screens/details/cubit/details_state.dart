part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}
class SetUpProductInfoState extends DetailsState {}
class AddNumberState extends DetailsState {}
class RemoveNumberState extends DetailsState {}
class AddProductToCartState extends DetailsState {}



class LoadingProductFav extends DetailsState {}
class GetProductFav extends DetailsState {}
class AddProductToFav extends DetailsState {}
class RemoveProductToFav extends DetailsState {}
