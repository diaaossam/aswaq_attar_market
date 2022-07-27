import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/components/app_text.dart';
import 'package:aswaq_attar_market/ui/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tbib_toast/tbib_toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';

class SettingsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var fullName = TextEditingController();
  var password = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var addressDetails = TextEditingController();

  var passOldChange = TextEditingController();
  var passNewChange = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is SignOutState) {
          navigateToAndFinish(context, LoginScreen());
        } else if (state is ChangePasswordSucces) {
          Toast.show("تم تغير كلمة المرور بنجاح", context,
              duration: 3, backgroundColor: Colors.green);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: ColorsManger.lightGrey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(10)),
              child: Column(
                children: [
                  SizedBox(height: SizeConfigManger.bodyHeight * .05),
                  CustomTextFormField(
                      isEnable: false,
                      controller: fullName
                        ..text =
                            MainCubit.get(context).userModel!.fullName ?? '',
                      lableText: "الإسم بالكامل",
                      hintText: "برجاء إدخال الإسم بالكامل",
                      type: TextInputType.text,
                      prefixIcon: "assets/icons/User.svg",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'برجاء إدخال الإسم بالكامل';
                        }
                      }),
                  SizedBox(height: SizeConfigManger.bodyHeight * .02),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            _showMyDialog(context, MainCubit.get(context));
                          },
                          child: AppText(
                              text: "تغييــر",
                              textSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorsManger.darkPrimary)),
                      SizedBox(width: getProportionateScreenWidth(10)),
                      Expanded(
                        child: CustomTextFormField(
                          isEnable: false,
                          controller: password..text = "*********",
                          lableText: "كلمة المرور",
                          hintText: "برجاء إدخال رقم كلمة المرور",
                          type: TextInputType.visiblePassword,
                          prefixIcon: 'assets/icons/Lock.svg',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'برجاء إدخال كلمة المرور';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfigManger.bodyHeight * .02),
                  CustomTextFormField(
                    isEnable: false,
                    controller: phoneNumber
                      ..text =
                          MainCubit.get(context).userModel!.phoneNumber ?? '',
                    lableText: "رقم الهاتف",
                    hintText: "برجاء إدخال رقم الهاتف",
                    type: TextInputType.phone,
                    prefixIcon: 'assets/icons/Phone.svg',
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء إدخال رقم الهاتف';
                      }
                    },
                  ),
                  SizedBox(height: SizeConfigManger.bodyHeight * .02),
                  CustomTextFormField(
                    controller: address
                      ..text = MainCubit.get(context).userModel!.adress ?? '',
                    isEnable: false,
                    lableText: "العنوان",
                    hintText: "برجاء إدخال العنوان",
                    type: TextInputType.streetAddress,
                    prefixIcon: "assets/icons/Location point.svg",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء إدخال العنوان';
                      }
                    },
                    isPassword: false,
                  ),
                  SizedBox(height: SizeConfigManger.bodyHeight * .02),
                  CustomTextFormField(
                    controller: addressDetails
                      ..text = MainCubit.get(context).userModel!.details ?? '',
                    isEnable: false,
                    lableText: "تفاصيل العنوان",
                    hintText: "تفاصيل العنوان",
                    type: TextInputType.streetAddress,
                    prefixIcon: "assets/icons/Location point.svg",
                    isPassword: false,
                    maxLines: 3,
                  ),
                  SizedBox(height: SizeConfigManger.bodyHeight * .02),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenHeight(15)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenHeight(20)),
                          border:
                              Border.all(color: ColorsManger.black, width: 2)),
                      child: Column(
                        children: [
                          AppText(
                            text: "توصل معنا",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            textSize: 30,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/Phone.svg",
                                  width: getProportionateScreenHeight(40),
                                  height: getProportionateScreenHeight(40)),
                              SizedBox(width: getProportionateScreenHeight(20)),
                              InkWell(
                                onTap: () async {
                                  await launchUrl(
                                      Uri.parse("tel://01206974265"));
                                },
                                child: AppText(
                                  text: "01206974265",
                                  color: Colors.blue,
                                  textSize: 22,
                                  fontWeight: FontWeight.bold,
                                  textDecoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: SizeConfigManger.bodyHeight * .02),
                          Row(
                            children: [
                              Image.asset("assets/images/whatslogo.png",
                                  width: getProportionateScreenHeight(30),
                                  height: getProportionateScreenHeight(30)),
                              SizedBox(width: getProportionateScreenHeight(20)),
                              InkWell(
                                onTap: () async {
                                  _launchWhatsapp();
                                },
                                child: AppText(
                                  text: "01206974265",
                                  color: Colors.blue,
                                  textSize: 22,
                                  fontWeight: FontWeight.bold,
                                  textDecoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: SizeConfigManger.bodyHeight * .02),
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/facebook-2.svg",
                                  width: getProportionateScreenHeight(40),
                                  height: getProportionateScreenHeight(40)),
                              SizedBox(width: getProportionateScreenHeight(20)),
                              InkWell(
                                onTap: (){
                                  launchUrl(Uri.parse("https://www.fb.com/SystemError32/"));
                                },
                                child: AppText(
                                  text: "https://www.fb.com/SystemError32/",
                                  color: Colors.blue,
                                  textSize: 15,
                                  maxLines: 2,
                                  fontWeight: FontWeight.bold,
                                  textDecoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfigManger.bodyHeight * .05),
                  CustomButton(
                      text: 'تسجيل الخــــروج',
                      press: () {
                        MainCubit.get(context).signOut();
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _launchWhatsapp() async {
    var whatsapp = "1206974265";
    var whatUrl = 'https://wa.me/${20}$whatsapp?text=اهلا بيك ممكن مساعده ؟ ';
    await launchUrl(Uri.parse(whatUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> _showMyDialog(context, MainCubit cubit) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText(text: 'تغير كلمة المرور', textSize: 25),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CustomTextFormField(
                  controller: passOldChange,
                  lableText: "كلمة المرور القديمة",
                  hintText: "برجاء إدخال المرور القديمة",
                  type: TextInputType.visiblePassword,
                  prefixIcon: 'assets/icons/Lock.svg',
                  validate: (value) {
                    if (value!.isEmpty) {
                      return ' برجاء إدخال كلمة المرور القديمة';
                    }
                  },
                ),
                SizedBox(
                  height: SizeConfigManger.bodyHeight * .03,
                ),
                CustomTextFormField(
                  controller: passNewChange,
                  lableText: "كلمة المرور الحديثة",
                  hintText: "برجاء إدخال المرور الحديثة",
                  type: TextInputType.visiblePassword,
                  prefixIcon: 'assets/icons/Lock.svg',
                  validate: (value) {
                    if (value!.isEmpty) {
                      return ' برجاء إدخال كلمة المرور الحديثة';
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('تغييـــر'),
              onPressed: () {
                cubit.changeUserPassword(
                  newPass: passNewChange.text,
                  oldPass: passOldChange.text,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
