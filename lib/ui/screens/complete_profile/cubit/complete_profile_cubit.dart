import 'package:aswaq_attar_market/model/user_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());

  static CompleteProfileCubit get(context) => BlocProvider.of(context);

  void setUserInfo(
      {required String fullName,
      required String phone,
      required String address,
      String? details}) async {
    emit(LoadingUploadUserInfoCompleteProfile());

      UserModel userModel = UserModel(
          id: FirebaseAuth.instance.currentUser!.uid,
          fullName: fullName,
          phoneNumber: phone,
          adress: address,
          details: details,
        token:await FirebaseMessaging.instance.getToken()
      );
      FirebaseFirestore.instance
          .collection(ConstantsManger.USERS)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userModel.toMap())
          .then((value) {
        emit(SucessUploadUserInfoCompleteProfile());
      }).catchError((error) {
        emit(ErrorUploadUserInfoCompleteProfile(error.toString()));
      });
  }

}
