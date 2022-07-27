import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/screens/home_screen/compoents/discount_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/app_text.dart';
import 'compoents/banners_design.dart';
import 'compoents/custom_popular.dart';
import 'compoents/special_offers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      MainCubit.get(context).getPopularItems();
      return BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state is AddProductToCartState) {
            showSnackBar(context, "تمت الإضافة إلي العربة");
          }
        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannersDesign(),
                    SpecialOffers(),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorsManger.lightGrey),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: Text('خصومـــات',
                                style: TextStyle(
                                  fontSize: getProportionateScreenHeight(25),
                                  fontFamily: "ReemKufi",
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManger.darkPrimary,
                                )),
                          ),
                          cubit.discountProduct.isEmpty
                              ? Center(
                                  child: AppText(
                                  text: "لا يوجد منتجات خصومات",
                                  textSize: 25,
                                  fontWeight: FontWeight.w800,
                                ))
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenHeight(10)),
                                  child: Container(
                                    height: SizeConfigManger.bodyHeight * .5,
                                    child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return CustomDiscountCard(
                                              productModel:
                                                  cubit.discountProduct[index],
                                              cubit: cubit);
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                                width:
                                                    getProportionateScreenHeight(
                                                        10)),
                                        itemCount:
                                            cubit.discountProduct.length),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorsManger.lightGrey),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: Text('الأكثر مبيعــاً',
                                style: TextStyle(
                                  fontSize: getProportionateScreenHeight(25),
                                  fontFamily: "ReemKufi",
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManger.darkPrimary,
                                )),
                          ),
                          cubit.popularProduct.isEmpty
                              ? Center(
                                  child: AppText(
                                  text: "لا يوجد اكثر مبيعا",
                                  textSize: 25,
                                  fontWeight: FontWeight.w800,
                                ))
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenHeight(10)),
                                  child: Container(
                                    height: SizeConfigManger.bodyHeight * .46,
                                    child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return CustomPopularCard(
                                              productModel:
                                                  cubit.popularProduct[index],
                                              cubit: cubit);
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                                width:
                                                    getProportionateScreenHeight(
                                                        10)),
                                        itemCount: cubit.popularProduct.length),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
