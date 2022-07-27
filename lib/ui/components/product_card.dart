/*
import 'package:attar_market/model/product_model.dart';
import 'package:attar_market/shared/helper/mangers/colors.dart';
import 'package:attar_market/shared/helper/methods.dart';
import 'package:attar_market/ui/components/app_text.dart';
import 'package:attar_market/ui/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/helper/mangers/size_config.dart';

class ProductCard extends StatelessWidget {
  ProductModel productModel;

  ProductCard(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, DetailsScreen(productModel));
        },
        child: Container(
          height: SizeConfigManger.bodyHeight * .3,
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          decoration: BoxDecoration(
            color: ColorsManger.lightPrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.network("${productModel.image}",
                  height: SizeConfigManger.bodyHeight * .28,
                  width: double.infinity,
                  fit: BoxFit.cover),
              SizedBox(height: getProportionateScreenHeight(10)),
              AppText(
                text: "${productModel.title}",
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/components/app_text.dart';
import 'package:aswaq_attar_market/ui/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/helper/mangers/size_config.dart';

class ProductCard extends StatelessWidget {
  ProductModel productModel;

  ProductCard(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, DetailsScreen(productModel));
        },
        child: Container(
          height: SizeConfigManger.bodyHeight * .2,
          width: SizeConfigManger.screenWidth*.45,
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          decoration: BoxDecoration(
            color: ColorsManger.lightPrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.network("${productModel.image}",
                  height: SizeConfigManger.bodyHeight * .2,
                  width: SizeConfigManger.screenWidth*.45,
                  fit: BoxFit.cover),
              SizedBox(height: getProportionateScreenHeight(10)),
              AppText(
                text: "${productModel.title}",
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

