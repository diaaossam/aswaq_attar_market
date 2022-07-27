import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../layout/cubit/main_cubit.dart';
import '../../../../model/product_model.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../../shared/helper/methods.dart';
import '../../../components/app_text.dart';
import '../../../components/custom_button.dart';
import '../../details/details_screen.dart';
import 'custom_bottom_sheet.dart';

class CustomDiscountCard extends StatelessWidget {
  ProductModel productModel;
  MainCubit cubit;

  CustomDiscountCard({required this.productModel,required this.cubit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, DetailsScreen(productModel));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(getProportionateScreenHeight(20)),
            boxShadow: [
              BoxShadow(
                  color: ColorsManger.lightGrey,
                  offset: Offset(0, 50),
                  blurRadius: 6)
            ]),
        child: Column(
          children: [
            Container(
              width: SizeConfigManger.screenWidth * .5,
              height: SizeConfigManger.bodyHeight * .25,
              child: CachedNetworkImage(
                imageUrl: "${productModel.image}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CupertinoActivityIndicator(
                    radius: getProportionateScreenHeight(25)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
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
                    text: "${productModel.newPrice}",
                    fontWeight: FontWeight.w600,
                    textSize: 24,
                    color: ColorsManger.darkPrimary),
                SizedBox(width: getProportionateScreenHeight(5)),
                AppText(
                    text: "جنيه",
                    textSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsManger.darkPrimary),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                    text: "${productModel.price}",
                    fontWeight: FontWeight.w600,
                    textDecoration: TextDecoration.lineThrough,
                    textSize: 18,
                    color: ColorsManger.black),
                SizedBox(width: getProportionateScreenHeight(5)),
                AppText(
                    text: "جنيه",
                    textDecoration: TextDecoration.lineThrough,
                    textSize: 18,
                    fontWeight: FontWeight.w400,
                    color: ColorsManger.black),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            CustomButton(
                press: () {
                /*  cubit.addProductToCart(
                      title: "${productModel.title}",
                      image: "${productModel.image}", price: null,
                    //  price: productModel.hasDiscount==true  ?  productModel.newPrice! : productModel.price!

                  );*/
                  showModalBottomSheet(context: context, builder: (BuildContext context){
                    return CustomBottomSheetDesign(productModel: productModel,cubit:cubit);
                  });
                },
                text: "إضافة للعربة",
                width: SizeConfigManger.screenWidth * .45),
          ],
        ),
      ),
    );
  }
}
