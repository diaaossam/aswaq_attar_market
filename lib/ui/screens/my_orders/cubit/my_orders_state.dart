part of 'my_orders_cubit.dart';

@immutable
abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}
class GetAllOrdersLoading extends MyOrdersState {}
class GetAllOrdersSuccess extends MyOrdersState {}
class GetAllOrdersError extends MyOrdersState {}
