import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/model/cart_model.dart';
import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../components/app_text.dart';


class CustomCategoryDesign extends StatelessWidget {

  ProductModel productModel;
  CustomCategoryDesign(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: (){
          navigateTo(context, DetailsScreen(productModel));
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorsManger.lightGrey,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black12)

          ),
          child: Padding(
            padding: EdgeInsets.all( getProportionateScreenHeight(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfigManger.bodyHeight*.2,
                  height: SizeConfigManger.bodyHeight*.2,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsManger.black,
                      ),
                      borderRadius: BorderRadius.circular(getProportionateScreenHeight(10)),
                      image: DecorationImage(
                        image: NetworkImage(
                          productModel.image!,
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: getProportionateScreenHeight(20),
                ),
                Expanded(
                  child: Container(
                    height: SizeConfigManger.bodyHeight*.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: productModel.title!,
                          maxLines: 2,
                          textSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: getProportionateScreenHeight(10),),
                        Expanded(
                          child: AppText(
                            text: productModel.description!,
                            maxLines: 4,
                            textSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10),),
                        Row(
                          children: [

                            AppText(
                              text: "${productModel.hasDiscount ==true  ? productModel.newPrice: productModel.price}",
                              maxLines: 1,
                              textSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(width: getProportionateScreenHeight(5),),
                            AppText(
                              text: 'جنيــه',
                              textSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
