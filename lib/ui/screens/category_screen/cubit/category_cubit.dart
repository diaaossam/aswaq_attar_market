import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/ui/screens/category_screen/compoents/category_page.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../model/cart_model.dart';
import '../../../../shared/helper/mangers/constants.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  List<Tab> setUpTab({required String categoryText}) {
    if (categoryText == ConstantsManger.Etara) {
      List<Tab> tabs = [
        Tab(text: ConstantsManger.Etara1,),
        Tab(text: ConstantsManger.Etara2),
        Tab(text: ConstantsManger.Etara3),
        Tab(text: ConstantsManger.Etara4),
      ];
      return tabs;
    } else if (categoryText == ConstantsManger.Beqala) {
      List<Tab> tabs = [
        Tab(text: ConstantsManger.Beqala1),
        Tab(text: ConstantsManger.Beqala2),
        Tab(text: ConstantsManger.Beqala3),
        Tab(text: ConstantsManger.Beqala4),
        Tab(text: ConstantsManger.Beqala5),
      ];
      return tabs;
      ;
    } else if (categoryText == ConstantsManger.Elafa) {
      List<Tab> tabs = [
        Tab(text: ConstantsManger.Elafa1),
        Tab(text: ConstantsManger.Elafa2),
      ];
      return tabs;
    } else {
      return [];
    }
  }

 // List<ProductModel> _allProductList = [];
  List<ProductModel> beqala1List = [];
  List<ProductModel> beqala2List = [];
  List<ProductModel> beqala3List = [];
  List<ProductModel> beqala4List = [];
  List<ProductModel> beqala5List = [];

  List<ProductModel> etata1List = [];
  List<ProductModel> etata2List = [];
  List<ProductModel> etata3List = [];
  List<ProductModel> etata4List = [];

  List<ProductModel> elafa1List = [];
  List<ProductModel> elafa2List = [];

  List<ProductModel> productSpecial=[];

  void getCategoryList({required String categoryText}) {
    emit(GetCategoryLoading());

    FirebaseFirestore.instance
        .collection(ConstantsManger.Products)
        .get()
        .then((value) {
      productSpecial.clear();
      beqala1List.clear();
      beqala2List.clear();
      beqala3List.clear();
      beqala4List.clear();
      beqala5List.clear();

      etata1List.clear();
      etata2List.clear();
      etata3List.clear();
      etata4List.clear();

      elafa1List.clear();
      elafa2List.clear();

      value.docs.forEach((element) {
        ProductModel productModel = ProductModel.fromJson(element.data());
        if(categoryText == ConstantsManger.Beqala || categoryText == ConstantsManger.Etara ||categoryText == ConstantsManger.Elafa ){
          if (categoryText == ConstantsManger.Beqala) {
            if (productModel.department == ConstantsManger.Beqala1) {
              beqala1List.add(productModel);
            } else if (productModel.department == ConstantsManger.Beqala2) {
              beqala2List.add(productModel);
            } else if (productModel.department == ConstantsManger.Beqala3) {
              beqala3List.add(productModel);
            } else if(productModel.department == ConstantsManger.Beqala4) {
              beqala4List.add(productModel);
            }
            else if(productModel.department == ConstantsManger.Beqala5) {
              beqala5List.add(productModel);
            }
          } else if (categoryText == ConstantsManger.Etara)
          {
            if (productModel.department == ConstantsManger.Etara1) {
              etata1List.add(productModel);
            }
            else if (productModel.department == ConstantsManger.Etara2) {
              etata2List.add(productModel);
            }
            else if (productModel.department == ConstantsManger.Etara3) {
              etata3List.add(productModel);
            } else if (productModel.department == ConstantsManger.Etara4) {
              etata4List.add(productModel);
            }
          }
          else if (categoryText == ConstantsManger.Elafa) {
            if (productModel.department == ConstantsManger.Elafa1) {
              elafa1List.add(productModel);
            }
            else if (productModel.department == ConstantsManger.Elafa2) {
              elafa2List.add(productModel);
            }
          }
        }else{
          if(productModel.category == categoryText){
            productSpecial.add(productModel);
          }
        }
      });
      emit(GetCategorySuccess());
    }).catchError((error) {
      emit(GetCategoryError());
    });
  }

  List<Widget> setUpPageView({required String categoryText}) {
    if (categoryText == ConstantsManger.Etara) {
      List<Widget> pages = [
        CategoryPage(etata1List),
        CategoryPage(etata2List),
        CategoryPage(etata3List),
        CategoryPage(etata4List),
      ];
      return pages;
    } else if (categoryText == ConstantsManger.Beqala) {
      List<Widget> pages = [
        CategoryPage(beqala1List),
        CategoryPage(beqala2List),
        CategoryPage(beqala3List),
        CategoryPage(beqala4List),
        CategoryPage(beqala5List),
      ];
      return pages;
    } else if (categoryText == ConstantsManger.Elafa) {
      List<Widget> pages = [
        CategoryPage(elafa1List),
        CategoryPage(elafa2List),
      ];
      return pages;
    } else {
      return [];
    }
  }

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
}
