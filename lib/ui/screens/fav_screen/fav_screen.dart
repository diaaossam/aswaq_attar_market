import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/ui/screens/fav_screen/custom_fav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../components/app_text.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return cubit.favList.isEmpty
            ? Center(
                child: Column(
                  children: [
                    Icon(Icons.remove_shopping_cart),
                    AppText(
                      text: "سلة المفضلات فارغة",
                      textSize: 40,
                      maxLines: 2,
                      color: ColorsManger.darkGrey,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return CustomFavItem(cubit.favList[index]);
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: getProportionateScreenHeight(10)),
                itemCount: cubit.favList.length);
      },
    );
  }
}
