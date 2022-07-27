import 'package:aswaq_attar_market/layout/cubit/main_cubit.dart';
import 'package:aswaq_attar_market/model/cart_model.dart';
import 'package:aswaq_attar_market/model/fav_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../components/app_text.dart';

class CustomFavItem extends StatelessWidget {
  FavModel favModel;

  CustomFavItem(this.favModel);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        MainCubit.get(context).deleteItemFromFav(id: favModel.productId ?? "");
      },
      key: UniqueKey(),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(5)),
          decoration: BoxDecoration(
              color: ColorsManger.lightGrey,
              borderRadius:
                  BorderRadius.circular(getProportionateScreenHeight(15.0)),
              border: Border.all(color: ColorsManger.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: SizeConfigManger.bodyHeight * 0.17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    AppText(
                      text: '${favModel.title}',
                      textSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                      SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      children: [
                        AppText(text: 'جنيه', color: Colors.black),
                        SizedBox(width: getProportionateScreenHeight(5)),
                        AppText(
                            text: '${favModel.price}',
                            color: Colors.black),
                        AppText(
                            text: ' : السعر ', color: Colors.black),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(8),
              ),
              Container(
                height: SizeConfigManger.bodyHeight * 0.15,
                width: SizeConfigManger.bodyHeight * 0.15,
                child: CachedNetworkImage(
                  imageUrl: "${favModel.image}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CupertinoActivityIndicator(
                      radius: getProportionateScreenHeight(25)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
/*
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(favModel.image ?? ''),
                  ),
                ),
*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}
