part of 'forget_cubit.dart';

@immutable
abstract class ForgetState {}

class ForgetInitial extends ForgetState {}
class LoadingForget extends ForgetState {}
class SuccessForget extends ForgetState {}
class ErrorForget extends ForgetState {}
