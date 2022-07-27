/*
import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../details/details_screen.dart';

class CustomProductCard extends StatelessWidget {
  ProductModel productModel;

  CustomProductCard({required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, DetailsScreen(productModel));
      },
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenHeight(1)),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)
        ]),
        margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(10),
            vertical: getProportionateScreenHeight(10)),

        child: Column(children: [
          Expanded(
            flex: 15,
            child: CachedNetworkImage(
              imageUrl: "${productModel.image}",
              imageBuilder: (context, imageProvider) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              placeholder: (context, url) =>
                  CupertinoActivityIndicator(
                      radius: getProportionateScreenHeight(25)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Expanded(
            flex: 20,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  AppText(
                    text: "${productModel.title}",
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                          text: "جنيه",
                          textSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorsManger.darkPrimary),
                      SizedBox(width: getProportionateScreenHeight(5)),
                      AppText(
                          text: "${productModel.price}",
                          fontWeight: FontWeight.w600,
                          textSize: 18,
                          color: ColorsManger.darkPrimary),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Container(
                      height: getProportionateScreenHeight(40),
                      width: SizeConfigManger.screenWidth * .3,
                      decoration: BoxDecoration(
                          color: ColorsManger.darkPrimary,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: MaterialButton(
                        child: AppText(
                          text: 'إضافة للسلة', color: Colors.white,),
                        onPressed: () {},
                      )),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

}

*/

import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/screens/details/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../home_screen/compoents/custom_bottom_sheet.dart';
import '../cubit/category_cubit.dart';

class CustomProductCard extends StatelessWidget {
  ProductModel productModel;
  CategoryCubit cubit;

  CustomProductCard({required this.productModel ,required this.cubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, DetailsScreen(productModel));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, //add this
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: "${productModel.image}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CupertinoActivityIndicator(radius: getProportionateScreenHeight(25)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Center(
              child:Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ),

                  AppText(
                    text: "${productModel.title}",
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                          text: "جنيه",
                          textSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorsManger.darkPrimary),
                      SizedBox(width: getProportionateScreenHeight(5)),
                      AppText(
                          text: "${productModel.hasDiscount ==true  ? productModel.newPrice: productModel.price}",
                          fontWeight: FontWeight.w600,
                          textSize: 18,
                          color: ColorsManger.darkPrimary),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Container(
                      height: getProportionateScreenHeight(40),
                      width: SizeConfigManger.screenWidth * .3,
                      decoration: BoxDecoration(
                          color: ColorsManger.darkPrimary,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: MaterialButton(
                        child: AppText(
                          text: 'إضافة للسلة', color: Colors.white,),
                        onPressed: () {
                          showModalBottomSheet(context: context, builder: (BuildContext context){
                            return CustomBottomSheetDesign(productModel: productModel,cubitCat: cubit,);
                          });
                        },
                      )),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

