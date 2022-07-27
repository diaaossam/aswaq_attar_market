part of 'regitser_cubit.dart';

@immutable
abstract class RegitserState {}

class RegitserInitial extends RegitserState {}
class RegisterLoadingState extends RegitserState {}
class RegisterErrorState extends RegitserState {
  String errorMsg ;

  RegisterErrorState(this.errorMsg);
}
class RegisterSuccessState extends RegitserState {}
