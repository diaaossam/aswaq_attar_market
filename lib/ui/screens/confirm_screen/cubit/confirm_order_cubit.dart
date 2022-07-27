import 'package:aswaq_attar_market/model/cart_model.dart';
import 'package:aswaq_attar_market/model/order_model.dart';
import 'package:aswaq_attar_market/model/user_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../shared/services/network/dio_helper.dart';

part 'confirm_order_state.dart';

class ConfirmOrderCubit extends Cubit<ConfirmOrderState> {
  ConfirmOrderCubit() : super(ConfirmOrderInitial());

  static ConfirmOrderCubit get(context) => BlocProvider.of(context);

  int groupValue = 2;

  void changeRadioButtonState(value) {
    this.groupValue = value;
    emit(RadioButtonAddressState());
  }

  void sendOrderToAdmin(
      {required List<CartModel> order,
      required double totalPrice,
      required String userName,
      required String phone,
      required String address}) {
    emit(SendOrderLoading());

    OrderModel orderModel = OrderModel(
        order: order,
        totalPrice: totalPrice,
        time: '${DateFormat.jms().format(DateTime.now())}',
        date: '${DateFormat.yMMMEd().format(DateTime.now())}',
        userName: userName,
        userId: FirebaseAuth.instance.currentUser!.uid,
        phone: phone,
        address: address);


    FirebaseFirestore.instance
        .collection(ConstantsManger.ORDERS)
        .add(orderModel.toMap())
        .then((value) async {
      FirebaseFirestore.instance
          .collection(ConstantsManger.ORDERS)
          .doc(value.id)
          .update({"orderId": value.id}).then((value) async {
        var snapshot = await FirebaseFirestore.instance
            .collection(ConstantsManger.CART)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(ConstantsManger.CART)
            .get();
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
        FirebaseFirestore.instance
            .collection(ConstantsManger.USERS)
            .doc(ConstantsManger.ADMIN_ID)
            .get()
            .then((value) {
          UserModel userModel = UserModel.fromJson(map: value.data() ?? {});
          print("${userModel.token}");

          final data = {
            "to": "${userModel.token}",
            "notification": {
              "body": "تم عمل طلب جديد برجاء التحقق",
              "title": "طلب جديد",
              "sound": "default"
            },
            "android": {
              "priority": "HIGH",
              "notification": {
                "notification_priority": "PRIORITY_HIGH",
                "sound": "default",
                "default_sound": true,
                "default_vibrate_timings": true,
                "default_light_settings": true,
              },
            },
            "data": {
              "type": "order",
              "id": "87",
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
            }
          };
          DioHelper().postData(path: 'fcm/send', data: data).then((value) {
            if (value.statusCode == 200) {
              emit(SendOrderSuccess());
            }
          });
        });
      });
    });
  }
}
