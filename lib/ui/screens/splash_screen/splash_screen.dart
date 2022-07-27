import 'package:aswaq_attar_market/layout/main_layout.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/ui/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../../shared/helper/methods.dart';
import '../../components/app_text.dart';
import '../complete_profile/complete_profile_screen.dart';
import '../on_boarding/on_boarding_screen.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfigManger().init(context);
    return BlocProvider(
      create: (context) => SplashCubit()..checkUserState(context),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoginState) {
            navigateToAndFinish(context, LoginScreen());
          } else if (state is SplashCompleteProfileState) {
            navigateToAndFinish(context, CompleteProfileScreen());
          } else if (state is SplashMainLayouState) {
            navigateToAndFinish(context, MainLayout());
          } else if (state is SplashOnBoardingState) {
            navigateToAndFinish(context, OnBoardingScreen());
          } else if (state is ErrorInConnection) {
            showSnackBar(context, "من فضلك تحقق من إتصال الانترنت");
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: SizeConfigManger.bodyHeight * .4,
                      height: SizeConfigManger.bodyHeight * .4,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: SizeConfigManger.bodyHeight * .008),
                  Text('أسواق العطار',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(40),
                        fontFamily: "ReemKufi",
                        color: ColorsManger.darkPrimary,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
