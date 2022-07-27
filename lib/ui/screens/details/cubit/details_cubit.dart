import 'package:aswaq_attar_market/model/cart_model.dart';
import 'package:aswaq_attar_market/model/fav_model.dart';
import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  static DetailsCubit get(context) => BlocProvider.of(context);

  int number = 1;

  void increaseNumber() {
    this.number++;
    totalPrice = double.parse("${price}") * number;
    emit(AddNumberState());
  }

  void removeNumber() {
    if (number != 1) {
      this.number--;
      totalPrice = double.parse("${price}") * number;
      emit(RemoveNumberState());
    }
  }

  double? price;
  double? totalPrice;

  void setUpPrice({required String price, required String productId}) {
    getProductFav(productId: productId);
    this.price = double.parse(price.toString());
    this.totalPrice = this.price;
  }

  void addProductToCart({required String title,
    required String image,
    required String price,
    String? details}) {
    CartModel cartModel = CartModel(
        id: ConstantsManger.DEFULT,
        title: title,
        image: image,
        count: number,
        details: details ?? ConstantsManger.DEFULT,
        totalPrice: totalPrice);

    FirebaseFirestore.instance
        .collection(ConstantsManger.CART)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantsManger.CART)
        .add(cartModel.toMap())
        .then((val) {
      FirebaseFirestore.instance
          .collection(ConstantsManger.CART)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(ConstantsManger.CART)
          .doc(val.id)
          .update({"id": val.id}).then((value) {
        emit(AddProductToCartState());
      });
    });
  }

  FavModel? favModel;

  void getProductFav({required String productId}) {
    emit(LoadingProductFav());

    FirebaseFirestore.instance.collection(ConstantsManger.FAV).doc(
        FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantsManger.FAV)
        .doc(productId).snapshots().listen((event) {
      favModel = FavModel.fromJson(event.data() ?? {});
      print(favModel!.isFav);
      emit(GetProductFav());
    });
  }

  void addOrRemoveProductFav({
    required String productId,
    required String title,
    required String image,
    required double price,
  }) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.FAV)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantsManger.FAV)
        .doc(productId)
        .get()
        .then((value) {
      if (value.exists) {
        FirebaseFirestore.instance
            .collection(ConstantsManger.FAV)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(ConstantsManger.FAV)
            .doc(productId)
            .update({"isFav": !favModel!.isFav!});
      } else {
        FavModel favModel = FavModel(
            productId: productId,
            isFav: true,
            title: title,
            image: image,
            price: price,
            userId: FirebaseAuth.instance.currentUser!.uid);

        FirebaseFirestore.instance
            .collection(ConstantsManger.FAV)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(ConstantsManger.FAV)
            .doc(productId)
            .set(favModel.toMap());
      }
    });
  }
}
