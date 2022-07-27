import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'regitser_state.dart';

class RegitserCubit extends Cubit<RegitserState> {
  RegitserCubit() : super(RegitserInitial());

  static RegitserCubit get(context) => BlocProvider.of(context);

  void registerUser({required String email, required String password}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}
