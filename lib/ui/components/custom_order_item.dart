import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:aswaq_attar_market/ui/components/custom_button.dart';
import 'package:aswaq_attar_market/ui/screens/my_orders/cubit/my_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../layout/cubit/main_cubit.dart';
import '../../model/order_model.dart';
import '../../shared/helper/mangers/size_config.dart';
import 'app_text.dart';

class CustomOrderItem extends StatelessWidget {
  OrderModel orderModel;
  bool isCurrent;

  CustomOrderItem(this.orderModel, this.isCurrent);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyOrdersCubit, MyOrdersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(15)),
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenHeight(10)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                color: ColorsManger.lightPrimary.withOpacity(0.2),
                borderRadius:
                    BorderRadius.circular(getProportionateScreenHeight(15.0)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText(
                          text: "كود الطلـــب : ", fontWeight: FontWeight.bold),
                      AppText(
                          text: "${orderModel.orderId}",
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    children: [
                      AppText(
                          text: "وقت الطلـب : ", fontWeight: FontWeight.bold),
                      AppText(
                          text: "${orderModel.time}",
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    children: [
                      AppText(
                          text: "تاريخ الطلـب : ", fontWeight: FontWeight.bold),
                      AppText(
                          text: "${orderModel.date}",
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    children: [
                      AppText(
                          text: "العنـــــــــوان : ",
                          fontWeight: FontWeight.bold),
                      AppText(
                          text: "${orderModel.address}",
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    children: [
                      AppText(
                          text: "السعر الكلــي : ",
                          fontWeight: FontWeight.bold),
                      AppText(
                          text: "${orderModel.totalPrice}",
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    children: [
                      AppText(
                          text: "حالة الطلـــب : ",
                          fontWeight: FontWeight.bold),
                      AppText(
                          text: setUpString(orderModel.reply),
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  isCurrent
                      ? InkWell(
                          onTap: () {
                            MyOrdersCubit.get(context)
                                .deleteOrder(id: orderModel.orderId ?? "");
                          },
                          child: Container(
                            width: SizeConfigManger.screenWidth * .6,
                            height: getProportionateScreenHeight(50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorsManger.lightGrey,
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: AppText(
                                    text: 'إلغاء الطلـــب',
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      : Center(),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  setUpString(String? reply) {
    if (reply == ConstantsManger.ADMINNo) {
      return "تم رفض الطلــب";
    } else if (reply == ConstantsManger.ADMINOk) {
      return "تم قبول الطلــب";
    } else {
      return "جاري معالجة الطلــب";
    }
  }
}
