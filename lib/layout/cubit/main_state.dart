part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class ChangeBottomNavState extends MainState {}
class ChangeIndicatorIndexState extends MainState {}
class ChangeBottomSheetState extends MainState {}
class RadioButtonAddressState extends MainState {}
class ErrorConnection extends MainState {}


class GetUserLoadingState extends MainState {}
class GetUserSuccessState extends MainState {}
class GetUserErrorState extends MainState {}


class GetCartLoadingState extends MainState {}
class GetCartSuccessState extends MainState {}
class GetCartErrorState extends MainState {}



class AddNumberState extends MainState {}
class RemoveNumberState extends MainState {}




class GetPopularLoadingState extends MainState {}
class GetPopularSuccessState extends MainState {}
class GetPopularErrorState extends MainState {}


class LoadingProductFav extends MainState {}
class GetProductFav extends MainState {}
class AddProductToCartState extends MainState {}



class SignOutState extends MainState {}
class ChangePasswordSucces extends MainState {}
class ChangePasswordError extends MainState {}
