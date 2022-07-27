import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../components/app_text.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Center(
          child: Padding(
            padding:  EdgeInsets.only(bottom: getProportionateScreenHeight(50)),
            child: AppText(
              text: 'مرحباً بك فى أسواق العطار',
              color: ColorsManger.darkPrimary,
              textSize: 36,
            ),
          ),
        ),
        Spacer(flex: 2),
        SvgPicture.asset(image!,height: getProportionateScreenHeight(240),
            width: getProportionateScreenWidth(210)),
        Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: AppText(
            text: text!,
            align: TextAlign.center,
            maxLines: 3,
            textSize: 20,
            color: ColorsManger.darkPrimary,
          ),
        ),
      ],
    );
  }
}
