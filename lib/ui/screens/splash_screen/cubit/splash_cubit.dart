import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';

import '../../../../../shared/helper/mangers/constants.dart';
import '../../../../../shared/services/local/cache_helper.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void checkUserState(context) {
    Future.delayed(Duration(seconds: 2), ()async {

      bool result = await InternetConnectionChecker().hasConnection;
      if(result == true) {
        bool onBoarding = CachedHelper.getBooleon(key: ConstantsManger.ON_BOARDING) ?? false;
        if (onBoarding == true) {
          FirebaseAuth.instance.authStateChanges().listen((user) {
            if (user != null) {
              FirebaseFirestore.instance
                  .collection(ConstantsManger.USERS)
                  .doc(user.uid)
                  .get()
                  .then((value) {
                if (value.exists) {
                  emit(SplashMainLayouState());
                } else {
                  emit(SplashCompleteProfileState());
                }
              });
            } else {
              emit(SplashLoginState());
            }
          });
        } else {
          emit(SplashOnBoardingState());
        }
      } else {
        emit(ErrorInConnection());
        print('No internet :( Reason:');
      }

    });
  }
}
