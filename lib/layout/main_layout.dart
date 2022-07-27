import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/ui/screens/my_orders/my_orders_screen.dart';
import 'package:aswaq_attar_market/ui/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/helper/methods.dart';
import '../ui/components/app_text.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..getUserInfo(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state is ErrorConnection) {
            showSnackBar(context, "من فضلك تحقق من إتصال الانترنت");
          }
        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return state is GetUserLoadingState
              ? Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  appBar: AppBar(
                    leading:IconButton(onPressed: (){
                      navigateTo(context, MyOrdersScreen());
                    }, icon: Icon(Icons.credit_card_outlined,color: Colors.black,)),
                    actions: [
                      IconButton(onPressed: (){
                        navigateTo(context, SearchScreen());
                      }, icon: Icon(Icons.search,color: Colors.black,)),
                    ],
                      centerTitle: true,
                      title: Text('أسواق العطار' ,style: TextStyle(
                        fontSize: getProportionateScreenHeight(30),
                        fontWeight: FontWeight.bold,
                        fontFamily: "ReemKufi",
                        color: Colors.black
                      ),),

                  ),
                  body: cubit.screens[cubit.currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    items: cubit.bottomItems,
                    showSelectedLabels: false,
                    currentIndex: cubit.currentIndex,
                    onTap: (index) => cubit.changeBottomNav(index),
                  ),
                );
        },
      ),
    );
  }
}
