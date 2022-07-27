import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePasswordVisibalty() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibiltyState());
  }

  void signInUser({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          FirebaseFirestore.instance.collection(ConstantsManger.USERS).doc(value.user!.uid).get().then((value) {
            if(value.exists){
              emit(LoginSuccessState());
            }else{
              emit(LoginSuccessComState());
            }
          });
    }).catchError((error) {
      emit(LoginErrorState(errorMsg: error.toString()));
    });
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      FirebaseFirestore.instance.collection(ConstantsManger.USERS).doc(value.user!.uid).get().then((value) {
        if(value.exists){
          emit(LoginSuccessState());
        }else{
          emit(LoginSuccessComState());
        }
      });
    }).catchError((error) {
      emit(LoginErrorState(errorMsg: error.toString()));
    });
  }
}
