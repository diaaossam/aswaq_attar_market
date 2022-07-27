import 'package:aswaq_attar_market/ui/screens/complete_profile/complete_profile_screen.dart';
import 'package:aswaq_attar_market/ui/screens/register_screen/cubit/regitser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import '../../components/app_text.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegitserCubit(),
      child: BlocConsumer<RegitserCubit, RegitserState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            showCustomProgressIndicator(context);
          } else if (state is RegisterSuccessState) {
            Navigator.pop(context);
            navigateToAndFinish(context, CompleteProfileScreen());
          } else if (state is RegisterErrorState) {
            Navigator.pop(context);
            showSnackBar(context, state.errorMsg);
          }
        },
        builder: (context, state) {
          RegitserCubit cubit = RegitserCubit.get(context);
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
                              "برجاء إدخال البريد الإلكترونى وكلمة السر لتسجيل حساب جديد",
                          maxLines: 2,
                          align: TextAlign.center,
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: SizeConfigManger.bodyHeight * 0.3,
                      ),
                      SizedBox(
                        height: SizeConfigManger.bodyHeight * 0.05,
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
                              height: SizeConfigManger.bodyHeight * 0.02,
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
                              isPassword: true,
                              prefixIcon: 'assets/icons/Lock.svg',
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.03,
                            ),
                            CustomTextFormField(
                              controller: passwordConfirmController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'تأكيد كلمة المرور';
                                }
                              },
                              type: TextInputType.visiblePassword,
                              lableText: '  تأكيد كلمة المرور',
                              isPassword: true,
                              prefixIcon: 'assets/icons/Lock.svg',
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.05,
                            ),
                            CustomButton(
                              text: 'التسجيل',
                              press: () {
                                if (formKey.currentState!.validate()) {
                                  if (passwordController.text == passwordConfirmController.text) {
                                    cubit.registerUser(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  } else {
                                    Toast.show(
                                        "كلمة المرور غير متطابقة", context,
                                        backgroundColor: Colors.red,
                                        duration: 3);
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * 0.02,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(text: "لديك بالفعل حساب ؟ "),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: AppText(
                                        text: "تسجيل الدخول ",
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
