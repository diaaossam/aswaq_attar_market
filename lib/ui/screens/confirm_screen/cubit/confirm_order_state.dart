part of 'confirm_order_cubit.dart';

@immutable
abstract class ConfirmOrderState {}

class ConfirmOrderInitial extends ConfirmOrderState {}
class RadioButtonAddressState extends ConfirmOrderState {}


class SendOrderLoading extends ConfirmOrderState {}
class SendOrderSuccess extends ConfirmOrderState {}
