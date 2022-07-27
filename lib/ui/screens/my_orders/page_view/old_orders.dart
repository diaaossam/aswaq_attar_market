import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:flutter/material.dart';
import '../../../../model/order_model.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import '../../../components/app_text.dart';
import '../../../components/custom_order_item.dart';

class AllOrders extends StatelessWidget {
  List<OrderModel> ordersList;


  AllOrders(this.ordersList);

  @override
  Widget build(BuildContext context) {
    return ordersList.isEmpty
        ? SafeArea(
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.remove_shopping_cart),
                  AppText(
                    text: "طلباتك فارغة",
                    textSize: 40,
                    maxLines: 2,
                    color: ColorsManger.darkGrey,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
          )
        : SafeArea(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return CustomOrderItem(ordersList[index],false);
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: getProportionateScreenHeight(10)),
                itemCount: ordersList.length),
          );
  }
}
