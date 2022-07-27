import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/ui/components/app_text.dart';
import 'package:aswaq_attar_market/ui/components/custom_button.dart';
import 'package:aswaq_attar_market/ui/screens/category_screen/cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../../../components/rounded_icon_btn.dart';

class CustomBottomSheetDesign extends StatefulWidget {
  ProductModel productModel;
  MainCubit ? cubit;
  CategoryCubit ? cubitCat;


  CustomBottomSheetDesign({required this.productModel, this.cubit , this.cubitCat});

  @override
  State<CustomBottomSheetDesign> createState() =>
      _CustomBottomSheetDesignState();
}


class _CustomBottomSheetDesignState extends State<CustomBottomSheetDesign> {
  @override
  void initState() {
    setUpPrice(price: "${widget.productModel.hasDiscount == true ? widget.productModel.newPrice! : widget.productModel.price!}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText(
                    text: "${widget.productModel.title}",
                    textSize: 30,
                    fontWeight: FontWeight.bold,
                    maxLines: 2),
                Spacer(),
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, icon: Icon(Icons.close))),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            AppText(
                text: "${widget.productModel.description}",
                textSize: 20,
                fontWeight: FontWeight.bold,
                maxLines: 4),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Center(
              child: AppText(
                  text:
                  "${totalPrice} ج.م",
                  textSize: 40,
                  fontWeight: FontWeight.bold,
                  maxLines: 1),
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedIconBtn(
                  icon: Icons.remove,
                  press: () {
                    removeNumber();
                  },
                ),
                SizedBox(
                    width: getProportionateScreenWidth(
                        20)),
                AppText(
                    text: "${number}",
                    textSize: 22,
                    fontWeight: FontWeight.bold),
                SizedBox(
                    width: getProportionateScreenWidth(
                        20)),
                RoundedIconBtn(
                  icon: Icons.add,
                  showShadow: true,
                  press: () {
                    increaseNumber();
                  },
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            CustomButton(
              text: "إضافة للعربة",
              press: () {
                if(widget.cubit !=null){
                  widget.cubit!.addProductToCart(
                      title: "${widget.productModel.title}",
                      image: "${widget.productModel.image}",
                      price: totalPrice ?? 0.0,
                      details:"", count: number);
                  Navigator.pop(context);
                }else{
                  widget.cubitCat!.addProductToCart(
                      title: "${widget.productModel.title}",
                      image: "${widget.productModel.image}",
                      price: totalPrice ?? 0.0,
                      details:"", count: number);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
  int number = 1;

  void increaseNumber() {
    setState((){
      this.number++;
      totalPrice = double.parse("${price}") * number;
    });
  }

  void removeNumber() {
    if (number != 1) {
      setState((){
        this.number--;
        totalPrice = double.parse("${price}") * number;
      });

    }
  }

  double? price;
  double? totalPrice;

  void setUpPrice({required String price}) {
    this.price = double.parse(price.toString());
    this.totalPrice = this.price;
  }

}
