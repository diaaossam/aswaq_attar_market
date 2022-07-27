import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'forget_state.dart';

class ForgetCubit extends Cubit<ForgetState> {
  ForgetCubit() : super(ForgetInitial());

  static ForgetCubit get(context) => BlocProvider.of(context);

  void sendForgetPassword({required String email}) {
    emit(LoadingForget());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(SuccessForget());
    }).catchError((error) {
      emit(ErrorForget());
    });
  }
}
