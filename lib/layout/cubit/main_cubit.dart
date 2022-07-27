import 'package:aswaq_attar_market/model/banner_model.dart';
import 'package:aswaq_attar_market/model/cart_model.dart';
import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/model/user_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:aswaq_attar_market/ui/screens/cart_screen/cart_screen.dart';
import 'package:aswaq_attar_market/ui/screens/chat_screen/chat_screen.dart';
import 'package:aswaq_attar_market/ui/screens/fav_screen/fav_screen.dart';
import 'package:aswaq_attar_market/ui/screens/home_screen/home_screen.dart';
import 'package:aswaq_attar_market/ui/screens/settings/settings_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';

import '../../model/fav_model.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), label: 'عربة التسوق'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلات'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'المحادثة'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادت'),
  ];

  List<String> titles = [
    "الرئيسية",
    "عربة التسوق ",
    "المفضلات",
    "المحادثة",
    "الإعدادت"
  ];
  int currentIndex = 0;

  void changeBottomNav(int index) {
    this.currentIndex = index;
    if (currentIndex == 1) {
      getCartList();
    } else if (currentIndex == 2) {
      getProductFav();
    }
    emit(ChangeBottomNavState());
  }

  int currentIndicator = 0;

  void changeIndicator(int index) {
    this.currentIndicator = index;
    emit(ChangeIndicatorIndexState());
  }

  List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    FavScreen(),
    ChatScreen(),
    SettingsScreen()
  ];

  UserModel? userModel;

  void getUserInfo() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      emit(GetUserLoadingState());
      if (userModel == null) {
        FirebaseFirestore.instance
            .collection(ConstantsManger.USERS)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          userModel = UserModel.fromJson(map: value.data() ?? {});
          emit(GetUserSuccessState());
        }).catchError((error) {
          emit(GetUserErrorState());
        });
      }
    } else {
      emit(ErrorConnection());
    }
  }

  /////////////////// Home Screen /////////////////////////////////

  List<ProductModel> popularProduct = [];
  List<ProductModel> discountProduct = [];
  List<BannerModel> bannersList = [];

  void getPopularItems() {
    if (popularProduct.isEmpty) {
      emit(GetPopularLoadingState());
      FirebaseFirestore.instance
          .collection(ConstantsManger.Products)
          .get()
          .then((value) {
        popularProduct.clear();
        discountProduct.clear();
        value.docs.forEach((element) {
          ProductModel productModel = ProductModel.fromJson(element.data());
          if (productModel.hasDiscount == true) {
            discountProduct.add(productModel);
          }
          if (productModel.isPopular == true) {
            popularProduct.add(productModel);
          }
        });
      }).then((value) {
        FirebaseFirestore.instance
            .collection(ConstantsManger.BANNERS)
            .get()
            .then((value) {
          bannersList.clear();
          value.docs.forEach((mm) {
            bannersList.add(BannerModel.fromJson(mm.data()));
          });
          emit(GetPopularSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(GetPopularErrorState());
      });
    }
  }

/*
  void getPopularItems() {
    if (popularProduct.isEmpty) {
      emit(GetPopularLoadingState());
      FirebaseFirestore.instance
          .collection(ConstantsManger.Products)
          .where('isPopular', isEqualTo: true)
          .get()
          .then((value) {
        popularProduct.clear();
        value.docs.forEach((element) {
          popularProduct.add(ProductModel.fromJson(element.data()));
        });
        emit(GetPopularSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetPopularErrorState());
      });
    }
  }
*/

  void addProductToCart(
      {required String title,
      required String image,
      required int count,
      required double price,
      String? details}) {
    CartModel cartModel = CartModel(
        id: ConstantsManger.DEFULT,
        title: title,
        image: image,
        count: count,
        details: details ?? ConstantsManger.DEFULT,
        totalPrice: price);

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

/*
  void addProductToCart({required String title,
    required String image,
    required double price,
    String? details})
  {
    CartModel cartModel = CartModel(
        id: ConstantsManger.DEFULT,
        title: title,
        image: image,
        count: 1,
        details: details ?? ConstantsManger.DEFULT,
        totalPrice: price);

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

*/

////////////////Cart Screen /////////////////////////////

  List<CartModel> cartList = [];

  void getCartList() {
    emit(GetCartLoadingState());
    FirebaseFirestore.instance
        .collection(ConstantsManger.CART)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantsManger.CART)
        .snapshots()
        .listen((event) {
      cartList.clear();
      event.docs.forEach((element) {
        cartList.add(CartModel.fromJson(element.data()));
      });
      emit(GetCartSuccessState());
    });
  }

  void deleteItemFromCart({required String id}) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.CART)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantsManger.CART)
        .doc(id)
        .delete();
  }

  double totalCartPrice = 0;

  String setUpTotalPrice() {
    if (cartList.isNotEmpty && cartList != null) {
      totalCartPrice = 0;
      cartList.forEach((element) {
        double price = element.totalPrice!;
        totalCartPrice = totalCartPrice + price;
      });
      return "${totalCartPrice}";
    } else {
      return "0.0";
    }
  }

  ///////////////////////////////////////////////////////
  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(SignOutState());
    });
  }

  void changeUserPassword(
      {required String newPass, required String oldPass}) async {
    User? user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser!.email ?? "",
        password: oldPass);

    user!.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPass).catchError((error) {
        print(error.toString());
        emit(ChangePasswordError());
      });
      emit(ChangePasswordSucces());
    }).catchError((error) {
      emit(ChangePasswordError());
    });
  }

  /////////////////////////////////////////////////////////

  List<FavModel> favList = [];

  void getProductFav() {
    emit(LoadingProductFav());
    FirebaseFirestore.instance
        .collection(ConstantsManger.FAV)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantsManger.FAV)
        .snapshots()
        .listen((event) {
      favList.clear();
      event.docs.forEach((element) {
        FavModel favModel = FavModel.fromJson(element.data());
        if (favModel.isFav!) {
          favList.add(favModel);
        }
      });
      emit(GetProductFav());
    });
  }

  void deleteItemFromFav({required String id}) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.FAV)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantsManger.FAV)
        .doc(id)
        .delete();
  }
}
