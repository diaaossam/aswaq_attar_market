import 'package:aswaq_attar_market/layout/main_layout.dart';
import 'package:aswaq_attar_market/model/cart_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/components/custom_button.dart';
import 'package:aswaq_attar_market/ui/components/custom_text_form_field.dart';
import 'package:aswaq_attar_market/ui/screens/confirm_screen/cubit/confirm_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../../components/app_text.dart';

class ConfirmOrderScreen extends StatelessWidget {
  String address;
  String addressDetails;
  double totalPrice;
  String phone;


  String userName;
  List<CartModel> orderList;

  var anthorAddress = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ConfirmOrderScreen(
      {required this.orderList,
      required this.address,
      required this.userName,
        required this.phone,
      required this.addressDetails,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmOrderCubit(),
      child: BlocConsumer<ConfirmOrderCubit, ConfirmOrderState>(
        listener: (context, state) {
          if (state is SendOrderSuccess) {
            Toast.show("تم توصيل الطلب بنجاح", context,duration: 3,backgroundColor: Colors.green);
            navigateTo(context, MainLayout());
          }
        },
        builder: (context, state) {
          ConfirmOrderCubit cubit = ConfirmOrderCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(10)),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(5),
                              vertical: getProportionateScreenHeight(10)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(15)),
                            border: Border.all(
                                width: 2, color: ColorsManger.darkPrimary),
                          ),
                          child: Column(
                            children: [
                              AppText(
                                  text: 'من فضلك اختر عنوان التوصيل',
                                  maxLines: 2,
                                  fontWeight: FontWeight.bold,
                                  textSize: 24),
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Radio(
                                        value: 2,
                                        groupValue: cubit.groupValue,
                                        onChanged: (value) {
                                          cubit.changeRadioButtonState(value);
                                        }),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenHeight(5.0),
                                  ),
                                  AppText(
                                    text: '${address}',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10.0),
                              ),
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Radio(
                                        hoverColor: ColorsManger.darkPrimary,
                                        activeColor: ColorsManger.darkPrimary,
                                        value: 1,
                                        groupValue: cubit.groupValue,
                                        onChanged: (value) {
                                          cubit.changeRadioButtonState(value);
                                        }),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenHeight(5.0),
                                  ),
                                  AppText(
                                    text: 'إستخدم عنوان أخــــر',
                                  ),
                                ],
                              ),
                              cubit.groupValue == 1
                                  ? CustomTextFormField(
                                      maxLines: 2,
                                      controller: anthorAddress,
                                      hintText: "عنوان التوصيل",
                                      validate: (String? value) {
                                        if(value!.isEmpty){
                                          return 'إدخل عنوان التوصيل' ;
                                        }
                                      },
                                    )
                                  : Center(),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * .08),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(5),
                              vertical: getProportionateScreenHeight(10)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(15)),
                            border: Border.all(
                                width: 2, color: ColorsManger.darkPrimary),
                          ),
                          child: Row(
                            children: [
                              AppText(
                                  text: "السعر الكلي  : ",
                                  fontWeight: FontWeight.bold),
                              AppText(
                                  text: "${totalPrice} ",
                                  fontWeight: FontWeight.bold),
                              AppText(
                                text: " جنيــه",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * .1),
                        CustomButton(
                          text: "تأكيد الطلب",
                          press: () {
                            if (cubit.groupValue == 2) {
                              cubit.sendOrderToAdmin(
                                  order: orderList,
                                  phone: phone,
                                  totalPrice: totalPrice,
                                  userName: userName,
                                  address: "${address} ${addressDetails}");
                            } else {
                              if(formKey.currentState!.validate()){
                                cubit.sendOrderToAdmin(
                                    order: orderList,
                                    phone: phone,
                                    totalPrice: totalPrice,
                                    userName: userName,
                                    address: anthorAddress.text);
                              }

                            }
                          },
                        ),
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
