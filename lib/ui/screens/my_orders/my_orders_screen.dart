import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/components/custom_order_item.dart';
import 'package:aswaq_attar_market/ui/screens/my_orders/cubit/my_orders_cubit.dart';
import 'package:aswaq_attar_market/ui/screens/my_orders/page_view/current_orders.dart';
import 'package:aswaq_attar_market/ui/screens/my_orders/page_view/old_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../components/app_text.dart';

class MyOrdersScreen extends StatelessWidget {
  var boardController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyOrdersCubit()..getMyOrdersHistory(),
      child: BlocConsumer<MyOrdersCubit, MyOrdersState>(
        listener: (context, state) {
          if (state is GetAllOrdersLoading) {
            showCustomProgressIndicator(context);
          }
        },
        builder: (context, state) {
          MyOrdersCubit cubit = MyOrdersCubit.get(context);
          return Scaffold(
              body:SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(SizeConfigManger.bodyHeight * 0.01),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: getProportionateScreenHeight(10.0)),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: getProportionateScreenHeight(20)),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    boardController.animateToPage(0,
                                        duration: Duration(milliseconds: 1),
                                        curve: Curves.fastLinearToSlowEaseIn);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ColorsManger.lightGrey,
                                      border: Border.all(color: ColorsManger.black),

                                    ),
                                    child: AppText(
                                      text: 'الطلبات الحالية',
                                      textSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ReemKufi",
                                    ),
                                  )),
                              SizedBox(width: getProportionateScreenHeight(40.0)),
                              InkWell(
                                onTap: () {
                                  if (boardController.page != 2) {
                                    boardController.animateToPage(2,
                                        duration: Duration(milliseconds: 1),
                                        curve: Curves.fastLinearToSlowEaseIn);
                                  }
                                },
                                child:  Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: ColorsManger.lightGrey,
                                    border: Border.all(color: ColorsManger.black),

                                  ),
                                  child: AppText(
                                    text: 'الطلبات السابقة',
                                    textSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ReemKufi",
                                  ),
                                )),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfigManger.bodyHeight * 0.02),
                        Expanded(
                          child: PageView(
                            controller: boardController,
                            physics: BouncingScrollPhysics(),
                            children: [
                              CurrentOrders(cubit.currentOrdersList),
                              AllOrders(cubit.oldOrdersList),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
  /*Widget grt(){
    return   cubit.ordersList.isEmpty
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
            return CustomOrderItem(cubit.ordersList[index]);
          },
          separatorBuilder: (context, index) =>
              SizedBox(height: getProportionateScreenHeight(10)),
          itemCount: cubit.ordersList.length),
    )
  }*/
}
