import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/ui/components/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDesign extends StatelessWidget {
  final String category, image;
  final GestureTapCallback press;

  CategoryDesign(
      {required this.category, required this.image, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: SizeConfigManger.bodyHeight * .165,
        child: Column(
          children: [
            Container(
              width: SizeConfigManger.bodyHeight * .4,
              height: getProportionateScreenHeight(85),
              decoration: BoxDecoration(
                border: Border.all(
                    color: ColorsManger.darkPrimary,
                    width: getProportionateScreenHeight(2.0)),
                color: ColorsManger.black,
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(image)),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(2)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(20)),
              child: AppText(
                  text: category,
                  color: ColorsManger.darkPrimary,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                  textSize: 20,
                  align: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
