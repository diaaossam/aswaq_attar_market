import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/components/custom_button.dart';
import 'package:aswaq_attar_market/ui/components/custom_cart_item.dart';
import 'package:aswaq_attar_market/ui/screens/confirm_screen/confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return cubit.cartList.isEmpty
            ? Center(
                child: Column(
                  children: [
                    Icon(Icons.remove_shopping_cart),
                    AppText(
                      text: "سلة المشتريات فارغة",
                      textSize: 40,
                      maxLines: 2,
                      color: ColorsManger.darkGrey,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return CustomCartItem(cubit.cartList[index]);
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: getProportionateScreenHeight(10)),
                        itemCount: cubit.cartList.length),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15)),
                        border: Border.all(
                            color: ColorsManger.darkPrimary, width: 2)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                                text: 'جنيه',
                                fontWeight: FontWeight.bold,
                                textSize: 25),
                            SizedBox(width: getProportionateScreenHeight(5)),
                            AppText(
                                text: cubit.setUpTotalPrice(),
                                fontWeight: FontWeight.bold,
                                textSize: 25),
                            AppText(
                                text: ' : السعر الكلي ',
                                fontWeight: FontWeight.bold,
                                textSize: 25),
                          ],
                        ),
                        CustomButton(
                          width: SizeConfigManger.screenWidth,
                          text: "المتابعــة",
                          press: () {
                            navigateTo(
                                context,
                                ConfirmOrderScreen(
                                  address: cubit.userModel!.adress ?? "",
                                  phone: "${cubit.userModel!.phoneNumber}",
                                  addressDetails: cubit.userModel!.details ?? "",
                                  orderList: cubit.cartList,
                                  totalPrice: cubit.totalCartPrice, userName: cubit.userModel!.fullName??"",
                                ));
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        )
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}
