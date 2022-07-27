import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/components/app_text.dart';
import 'package:aswaq_attar_market/ui/screens/category_screen/category_screen.dart';
import 'package:aswaq_attar_market/ui/screens/home_screen/compoents/category_design.dart';
import 'package:flutter/material.dart';

import '../../../../shared/helper/mangers/size_config.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorsManger.lightGrey
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child:Text('الاقســـا م',
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(25),
                    fontFamily: "ReemKufi",
                    fontWeight: FontWeight.bold,
                    color: ColorsManger.darkPrimary,
                  ))
              ,
            ),
            SizedBox(height: SizeConfigManger.bodyHeight * .005),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryDesign(
                    image: 'assets/images/beqala.jpg',
                    category: "${ConstantsManger.Beqala}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Beqala));
                    },
                  ),
                  CategoryDesign(
                    image: "assets/images/elafa.jpg",
                    category: "${ConstantsManger.Elafa}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Elafa));
                    },
                  ),
                  CategoryDesign(
                    image: "assets/images/etara.jpg",
                    category: "${ConstantsManger.Etara}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Etara));
                    },
                  ),
                  CategoryDesign(
                    image: "assets/images/zeyot.jpg",
                    category: "${ConstantsManger.ZeyoutTabe3ya}",
                    press: () {
                      navigateTo(
                          context, CategoryScreen(ConstantsManger.ZeyoutTabe3ya));
                    },
                  ),
                  CategoryDesign(
                    image: "assets/images/most7drat.jpg",
                    category: "${ConstantsManger.Most7drat}",
                    press: () {
                      navigateTo(
                          context, CategoryScreen(ConstantsManger.Most7drat));
                    },
                  ),
                  CategoryDesign(
                    image: "assets/images/halawany.jpg",
                    category: "${ConstantsManger.Halawany}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Halawany));
                    },
                  ),
                  CategoryDesign(
                    image: "assets/images/monzfat.jpg",
                    category: "${ConstantsManger.Monzefat}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Monzefat));
                    },
                  ),
                  /*SpecialOfferCard(
                    image: 'assets/images/beqala.jpg',
                    category: "${ConstantsManger.Beqala}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Beqala));
                    },
                  ),
                  SpecialOfferCard(
                    image: "assets/images/elafa.jpg",
                    category: "${ConstantsManger.Elafa}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Elafa));
                    },
                  ),
                  SpecialOfferCard(
                    image: "assets/images/etara.jpg",
                    category: "${ConstantsManger.Etara}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Etara));
                    },
                  ),
                  SpecialOfferCard(
                    image: "assets/images/zeyot.jpg",
                    category: "${ConstantsManger.ZeyoutTabe3ya}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.ZeyoutTabe3ya));
                    },
                  ),
                  SpecialOfferCard(
                    image: "assets/images/most7drat.jpg",
                    category: "${ConstantsManger.Most7drat}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Most7drat));
                    },
                  ),
                  SpecialOfferCard(
                    image: "assets/images/halawany.jpg",
                    category: "${ConstantsManger.Halawany}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Halawany));
                    },
                  ),
                  SpecialOfferCard(
                    image: "assets/images/monzfat.jpg",
                    category: "${ConstantsManger.Monzefat}",
                    press: () {
                      navigateTo(context, CategoryScreen(ConstantsManger.Monzefat));
                    },
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(5)),
      child: Container(
        width: SizeConfigManger.screenWidth * .5,
        height: SizeConfigManger.screenWidth * .25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)),
        ),
        child: Stack(
          textDirection: TextDirection.rtl,
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
                width: SizeConfigManger.screenWidth * .5,
                height: SizeConfigManger.screenWidth * .25,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenHeight(15)),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(image)))),
            Container(
              height: SizeConfigManger.screenWidth * .12,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenHeight(15)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF343434).withOpacity(0.4),
                    Color(0xFF343434).withOpacity(0.15),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15.0),
                  vertical: getProportionateScreenWidth(10),
                ),
                child: AppText(
                  text: "$category",
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  textSize: 22,
                )),
          ],
        ),
      ),
    );
  }
}

