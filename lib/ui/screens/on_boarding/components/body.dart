import 'package:aswaq_attar_market/ui/screens/on_boarding/components/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../../../shared/helper/mangers/constants.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../components/custom_button.dart';
import '../cubit/on_boarding_cubit.dart';
import '../cubit/on_boarding_states.dart';
import '../on_boarding_screen.dart';

// This is the best practice

class Body extends StatelessWidget {
  int currentPage = 0;
  var boardController = PageController();

  List<Map<String, String>> splashData = [
    {
      "text": "${ConstantsManger.ON_BOARDINGText1}",
      "image": "assets/images/board1.svg"
    },
    {
      "text":
      "${ConstantsManger.ON_BOARDINGText2}",
      "image": "assets/images/board2.svg"
    },
    {
      "text": "${ConstantsManger.ON_BOARDINGText3}",
      "image": "assets/images/board3.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state ) {
       /* if (state is GoToSignIn) {
          navigateToAndFinish(context, SignInScreen());
        } else if (state is GoToHome) {
          navigateToAndFinish(context, MainLayout());
        } else if (state is GoToCompleteProfile) {
          navigateToAndFinish(context, CompleteProfileScreen());
        }*/
      },
      builder: (context, states) {
        OnBoardingCubit cubit = OnBoardingCubit.get(context);
        return Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == splashData.length - 1)
                    cubit.changePageViewState(true);
                  else
                    cubit.changePageViewState(false);
                },
                itemCount: splashData.length,
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]['text'],
                    ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    SmoothPageIndicator(
                      controller: boardController,
                      count: splashData.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: ColorsManger.darkPrimary,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0,
                      ),
                    ),
                    Spacer(flex: 3),
                    CustomButton(text: 'المتابعة',textColor: Colors.white, press: (){
                      if (cubit.isLast) {
                        OnBoardingScreen.submit(context);
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    }),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
