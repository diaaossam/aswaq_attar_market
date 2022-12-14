import 'package:aswaq_attar_market/layout/main_layout.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/ui/screens/complete_profile/cubit/complete_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/methods.dart';
import '../../components/app_text.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';
import 'cubit/complete_profile_cubit.dart';

class CompleteProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var fullName = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var addressDetails = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(),
      child: BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
        listener: (context, state) {
          if (state is ErrorUploadUserInfoCompleteProfile)
          {
            Navigator.pop(context);
            showSnackBar(context, state.errorMsg);
          }
          else if (state is LoadingUploadUserInfoCompleteProfile)
          {
            showCustomProgressIndicator(context);
          }
          else if (state is SucessUploadUserInfoCompleteProfile)
          {
            Navigator.pop(context);
            navigateToAndFinish(context, MainLayout());
          }
        },
        builder: (context, state) {
          CompleteProfileCubit cubit = CompleteProfileCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(15)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfigManger.bodyHeight * 0.02,
                        ),
                        AppText(
                            text: "?????????? ???? ???? ?????????? ????????????",
                            textSize: 35,
                            color: ColorsManger.darkPrimary),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(30)),
                          child: AppText(
                            text: "?????????? ?????????? ???????????????? ",
                            maxLines: 2,
                            align: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfigManger.bodyHeight * 0.02,
                        ),
                        CustomTextFormField(
                            controller: fullName,
                            lableText: "?????????? ??????????????",
                            hintText: "?????????? ?????????? ?????????? ??????????????",
                            type: TextInputType.text,
                            prefixIcon: "assets/icons/User.svg",
                            validate: (value) {
                              if (value!.isEmpty) {
                                return '?????????? ?????????? ?????????? ??????????????';
                              }
                            }),
                        SizedBox(height: SizeConfigManger.bodyHeight * .02),
                        CustomTextFormField(
                          controller: phoneNumber,
                          lableText: "?????? ????????????",
                          hintText: "?????????? ?????????? ?????? ????????????",
                          type: TextInputType.phone,
                          prefixIcon: 'assets/icons/Phone.svg',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return '?????????? ?????????? ?????? ????????????';
                            }
                          },
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * .02),
                        CustomTextFormField(
                          controller: address,
                          lableText: "??????????????",
                          hintText: "?????????? ?????????? ??????????????",
                          type: TextInputType.streetAddress,
                          prefixIcon: "assets/icons/Location point.svg",
                          validate: (value) {
                            if (value!.isEmpty) {
                              return '?????????? ?????????? ??????????????';
                            }
                          },
                          isPassword: false,
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * .02),
                        CustomTextFormField(
                          controller: addressDetails,
                          lableText: "???????????? ??????????????",
                          hintText: "???????????? ??????????????",
                          type: TextInputType.streetAddress,
                          prefixIcon: "assets/icons/Location point.svg",
                          isPassword: false,
                          maxLines: 3,
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * .05),
                        CustomButton(
                            text: '????????????????',
                            press: () {

                              if (_formKey.currentState!.validate()) {
                                if(phoneNumber.text.length != 11){
                                  Toast.show("?????????? ?????????? ?????? ???????? ????????", context,backgroundColor: Colors.red,duration: 3);
                                }else{
                                  cubit.setUserInfo(
                                      phone: phoneNumber.text,
                                      address: address.text,
                                      fullName: fullName.text,
                                      details: addressDetails.text);
                                }

                              }
                            })
                      ],
                    ),
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
