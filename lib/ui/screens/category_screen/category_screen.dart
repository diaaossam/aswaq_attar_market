import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:aswaq_attar_market/ui/screens/category_screen/compoents/category_page.dart';
import 'package:aswaq_attar_market/ui/screens/category_screen/cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/methods.dart';
import '../../components/app_text.dart';

class CategoryScreen extends StatelessWidget {
  String categoryText;

  CategoryScreen(this.categoryText);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryCubit()..getCategoryList(categoryText: categoryText),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if(state is AddProductToCartState){
            showSnackBar(context, "تمت الإضافة إلي العربة");
          }
        },
        builder: (context, state) {
          if (state is GetCategoryLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return setUpWidget(context, CategoryCubit.get(context));
          }
        },
      ),
    );
  }

  Widget setUpWidget(BuildContext context, CategoryCubit cubit) {
    if (categoryText == ConstantsManger.Beqala ||
        categoryText == ConstantsManger.Etara ||
        categoryText == ConstantsManger.Elafa) {
      return DefaultTabController(
        length: setUpLenght(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: AppText(
              text: '${categoryText}',
              align: TextAlign.center,
              fontFamily: "ReemKufi",
              textSize: 30.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            backgroundColor: ColorsManger.darkPrimary,
            bottom: TabBar(
              isScrollable: setUpScrollable(),
              indicatorSize: TabBarIndicatorSize.tab,
              physics: BouncingScrollPhysics(),
              indicatorColor: ColorsManger.black,
              tabs: CategoryCubit.get(context)
                  .setUpTab(categoryText: categoryText),
            ),
          ),
          body: TabBarView(
              children: CategoryCubit.get(context)
                  .setUpPageView(categoryText: categoryText)),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManger.darkPrimary,
          title: AppText(
            fontFamily: "ReemKufi",
            text: categoryText,
            textSize: 30.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: CategoryPage(cubit.productSpecial),
      );
    }
  }

  int setUpLenght() {
    if (categoryText == ConstantsManger.Etara) {
      return 4;
    } else if (categoryText == ConstantsManger.Beqala) {
      return 5;
    } else if (categoryText == ConstantsManger.Elafa) {
      return 2;
    } else {
      return 0;
    }
  }

   bool setUpScrollable() {
     if (categoryText == ConstantsManger.Beqala ||
         categoryText == ConstantsManger.Etara) {
       return true;
     }else{
       return false;
     }
   }
}
