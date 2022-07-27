part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class ErrorInConnection extends SplashState {}
class SplashMainLayouState extends SplashState {}
class SplashOnBoardingState extends SplashState {}
class SplashCompleteProfileState extends SplashState {}
class SplashLoginState extends SplashState {}
