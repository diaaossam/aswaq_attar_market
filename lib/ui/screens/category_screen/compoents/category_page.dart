import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/ui/components/app_text.dart';
import 'package:aswaq_attar_market/ui/screens/category_screen/cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_category_item.dart';
import 'custom_product_card.dart';

class CategoryPage extends StatelessWidget {
  List<ProductModel> productList;

  CategoryPage(this.productList);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          child: productList.length == 0
              ? Center(
                  child: AppText(
                      text: 'لا يوجد عناصـــر',
                      color: ColorsManger.grey,
                      fontWeight: FontWeight.bold,
                      textSize: 35),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(10)),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .65,
                    crossAxisSpacing: getProportionateScreenHeight(10),
                    mainAxisSpacing: getProportionateScreenHeight(10.0),
                    shrinkWrap: true,
                    children: List.generate(
                      productList.length,
                      (index) {
                        return CustomProductCard(
                            productModel: productList[index],
                        cubit: CategoryCubit.get(context),
                        );
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}

/*
Padding(
padding: EdgeInsets.symmetric(
horizontal: getProportionateScreenHeight(10)),
child: ListView.separated(
itemCount: productList.length,
separatorBuilder: (context, index) =>
SizedBox(height: getProportionateScreenHeight(10)),
itemBuilder: (context, index) =>
CustomCategoryDesign(productList[index]),
))*/
