import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/screens/forget_password/cubit/forget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../components/app_text.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {

  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetCubit(),
      child: BlocConsumer<ForgetCubit, ForgetState>(
        listener: (context, state) {
          if(state is LoadingForget){
            showCustomProgressIndicator(context);
          }else if(state is SuccessForget){
            Navigator.pop(context);
            Toast.show("تم ارسال رابط استعادة كلمة المرور بنجاح علي البريد", context ,duration: 3,backgroundColor: Colors.green);
          }
        },
        builder: (context, state) {
          ForgetCubit cubit = ForgetCubit.get(context);
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
                          "برجاء إدخال البريد الإلكترونى",
                          maxLines: 2,
                          align: TextAlign.center,
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: SizeConfigManger.bodyHeight * 0.25,
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
                            CustomButton(
                              text: 'إرســال',
                              press: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.sendForgetPassword(email: emailController.text);
                                }
                              },
                            ),
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
