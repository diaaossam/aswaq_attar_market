import 'package:aswaq_attar_market/model/order_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  static MyOrdersCubit get(context) => BlocProvider.of(context);

  List<OrderModel> oldOrdersList = [];
  List<OrderModel> currentOrdersList = [];

/*
  void getMyOrdersHistory() {
    emit(GetAllOrdersLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.ORDERS)
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      oldOrdersList.clear();
      currentOrdersList.clear();
      value.docs.forEach((element) {
        OrderModel orderModel = OrderModel.fromJson(element.data());
        if (orderModel.reply == ConstantsManger.ADMINNo ||
            orderModel.reply == ConstantsManger.ADMINOk) {
          oldOrdersList.add(OrderModel.fromJson(element.data()));
        } else if (orderModel.reply == ConstantsManger.DEFULT) {
          currentOrdersList.add(OrderModel.fromJson(element.data()));
        }
      });
      emit(GetAllOrdersSuccess());
    }).catchError((error) {
      emit(GetAllOrdersError());
      print(error.toString());
    });
  }
*/

  void getMyOrdersHistory() {
    emit(GetAllOrdersLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.ORDERS)
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((value) {
      oldOrdersList.clear();
      currentOrdersList.clear();
      value.docs.forEach((element) {
        OrderModel orderModel = OrderModel.fromJson(element.data());
        if (orderModel.reply == ConstantsManger.ADMINNo ||
            orderModel.reply == ConstantsManger.ADMINOk) {
          oldOrdersList.add(OrderModel.fromJson(element.data()));
        } else if (orderModel.reply == ConstantsManger.DEFULT) {
          currentOrdersList.add(OrderModel.fromJson(element.data()));
        }
      });
      emit(GetAllOrdersSuccess());
    });
  }


  void deleteOrder({required String id}){
    FirebaseFirestore.instance.collection(ConstantsManger.ORDERS).doc(id).delete().then((value) {
      print('Ok');
    });
  }
}
