import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:aswaq_attar_market/ui/components/custom_text_form_field.dart';
import 'package:aswaq_attar_market/ui/screens/search_screen/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../category_screen/compoents/custom_category_item.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(10)),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: "في ماذا تفكر ؟",
                      type: TextInputType.text,
                      onChange: (String? value) {
                        if (value!.isNotEmpty) {
                          SearchCubit.get(context)
                              .serachQuery(query: value as String);
                        }
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                CustomCategoryDesign(SearchCubit.get(context)
                                    .productList[index]),
                            separatorBuilder: (context, index) => SizedBox(
                                height: getProportionateScreenHeight(10)),
                            itemCount:
                                SearchCubit.get(context).productList.length))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
