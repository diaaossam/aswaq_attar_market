/*
import 'package:attar_market/layout/main_layout.dart';
import 'package:attar_market/ui/screens/forget_password/forget_password.dart';
import 'package:attar_market/ui/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import '../../components/app_text.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            Navigator.pop(context);
            showSnackBar(context, state.errorMsg);
          } else if (state is LoginSuccessState) {
            Navigator.pop(context);
            navigateToAndFinish(context, MainLayout());
          } else if (state is LoginLoadingState) {
            showCustomProgressIndicator(context);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfigManger.bodyHeight * 0.02,
                      ),
                      AppText(
                          text: "مرحبا بك في أسواق العطار",
                          textSize: 35,
                          color: ColorsManger.darkPrimary),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(30)),
                        child: AppText(
                          text:
                              "برجاء إدخال البريد الإلكترونى وكلمة السر للإستمرار في تطبيق أسواق العطار",
                          maxLines: 2,
                          align: TextAlign.center,
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: SizeConfigManger.bodyHeight * 0.3,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(30.0)),
                        child: Column(
                          children: [
                            CustomTextFormField(
                                controller: emailController,
                                lableText: 'الإيميل',
                                validate: (String? value) {
                                  String pattern =
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                      r"{0,253}[a-zA-Z0-9])?)*$";
                                  RegExp regex = RegExp(pattern);
                                  if (value == null ||
                                      value.isEmpty ||
                                      !regex.hasMatch(value))
                                    return 'برجاء إدخال البريد الإلكترونى';
                                  else
                                    return null;
                                },
                                type: TextInputType.emailAddress,
                                prefixIcon: 'assets/icons/User.svg'),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.03,
                            ),
                            CustomTextFormField(
                              controller: passwordController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'كلمة المرور مطلوبة';
                                }
                              },
                              type: TextInputType.visiblePassword,
                              lableText: 'كلمة السر',
                              isPassword: cubit.isPassword,
                              prefixIcon: 'assets/icons/Lock.svg',
                              onSuffixPressed: () {
                                cubit.changePasswordVisibalty();
                              },
                              suffixIcon: cubit.isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.03,
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(context, ForgetPasswordScreen());
                              },
                              child: AppText(
                                  text: "نسيت كلمة المرور ؟",
                                  color: ColorsManger.darkPrimary,
                                  textSize: 22,
                                  textDecoration: TextDecoration.underline),
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.02,
                            ),
                            CustomButton(
                              text: 'تسجيل الدخول',
                              press: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.signInUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.02,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                AppText(text: 'أو'),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.02,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(text: "لا تمتلك حساب ؟ "),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: AppText(
                                        text: "إنشاء حساب جديد",
                                        color: ColorsManger.darkPrimary,
                                        textDecoration:
                                            TextDecoration.underline),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/

import 'package:aswaq_attar_market/layout/main_layout.dart';
import 'package:aswaq_attar_market/ui/screens/complete_profile/complete_profile_screen.dart';
import 'package:aswaq_attar_market/ui/screens/forget_password/forget_password.dart';
import 'package:aswaq_attar_market/ui/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import '../../components/app_text.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            Navigator.pop(context);
            showSnackBar(context, state.errorMsg);
          } else if (state is LoginSuccessState) {
            Navigator.pop(context);
            navigateToAndFinish(context, MainLayout());
          } else if (state is LoginLoadingState) {
            showCustomProgressIndicator(context);
          } else if (state is LoginSuccessComState) {
            Navigator.pop(context);
            navigateToAndFinish(context, CompleteProfileScreen());
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      AppText(
                          text: "مرحبا بك في أسواق العطار",
                          textSize: 35,
                          color: ColorsManger.darkPrimary),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(30)),
                        child: AppText(
                          text:
                              "برجاء إدخال البريد الإلكترونى وكلمة السر للإستمرار في تطبيق أسواق العطار",
                          maxLines: 2,
                          align: TextAlign.center,
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: SizeConfigManger.bodyHeight * 0.25,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(30.0)),
                        child: Column(
                          children: [
                            CustomTextFormField(
                                controller: emailController,
                                lableText: 'الإيميل',
                                validate: (String? value) {
                                  String pattern =
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                      r"{0,253}[a-zA-Z0-9])?)*$";
                                  RegExp regex = RegExp(pattern);
                                  if (value == null ||
                                      value.isEmpty ||
                                      !regex.hasMatch(value))
                                    return 'برجاء إدخال البريد الإلكترونى';
                                  else
                                    return null;
                                },
                                type: TextInputType.emailAddress,
                                prefixIcon: 'assets/icons/User.svg'),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.03,
                            ),
                            CustomTextFormField(
                              controller: passwordController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'برجاء إدخال كلمة المرور';
                                }
                              },
                              type: TextInputType.visiblePassword,
                              lableText: 'كلمة السر',
                              isPassword: cubit.isPassword,
                              prefixIcon: 'assets/icons/Lock.svg',
                              onSuffixPressed: () {
                                cubit.changePasswordVisibalty();
                              },
                              suffixIcon: cubit.isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.03,
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(context, ForgetPasswordScreen());
                              },
                              child: AppText(
                                  text: "نسيت كلمة المرور ؟",
                                  color: ColorsManger.darkPrimary,
                                  textSize: 22,
                                  textDecoration: TextDecoration.underline),
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.02,
                            ),
                            CustomButton(
                              text: 'تسجيل الدخول',
                              press: () {
                                if (formKey.currentState!.validate()) {
                                  if (passwordController.text.length < 6) {
                                    Toast.show(
                                        "يجب ان تكون كلمة المرور 6 احرف او أكثر",
                                        context,
                                        duration: 3,
                                        backgroundColor: Colors.red);
                                  }else{
                                  cubit.signInUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                                }
                              },
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                cubit.signInWithGoogle();
                              },
                              child: Container(
                                width: double.infinity,
                                height: getProportionateScreenHeight(60),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorsManger.darkPrimary,
                                        width: getProportionateScreenHeight(1)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        getProportionateScreenHeight(10))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/google-icon.svg'),
                                    SizedBox(
                                        width:
                                            getProportionateScreenHeight(10)),
                                    AppText(
                                      text: "تسجيل بإستخدام",
                                      fontWeight: FontWeight.bold,
                                      color: ColorsManger.darkPrimary,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.02,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                AppText(text: 'أو'),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.02,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(text: "لا تمتلك حساب ؟ "),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: AppText(
                                        text: "إنشاء حساب جديد",
                                        color: ColorsManger.darkPrimary,
                                        textDecoration:
                                            TextDecoration.underline),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
