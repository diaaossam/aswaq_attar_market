import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/methods.dart';
import 'package:aswaq_attar_market/ui/screens/details/cubit/details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../components/app_text.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_form_field.dart';
import '../../components/rounded_icon_btn.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatelessWidget {
  ProductModel productModel;

  var productDetails = TextEditingController();

  DetailsScreen(this.productModel);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DetailsCubit()
        ..setUpPrice(price: "${productModel.hasDiscount==true  ?  productModel.newPrice! : productModel.price!
            }", productId: productModel.id ?? ""),
      child: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {
          if (state is AddProductToCartState) {
            showSnackBar(context, "تمت الإضافة إلي العربة");
          }
        },
        builder: (context, state) {
          DetailsCubit cubit = DetailsCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF5F6F9),
            body: state is LoadingProductFav
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Hero(
                        tag: productModel.id.toString(),
                        child: Image.network(productModel.image!),
                      ),
                    ),
                  ),
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                              getProportionateScreenWidth(20)),
                          child: AppText(
                            text: "${productModel.title}",
                            textSize: 28,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.addOrRemoveProductFav(
                                productId: productModel.id ?? "",
                                title: productModel.title ?? "",
                                image: productModel.image ?? "",
                                price: productModel.price ?? 0.0,
                                 );
                          },
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(15)),
                              width: getProportionateScreenWidth(70),
                              decoration: BoxDecoration(
                                color: cubit.favModel!.isFav??false
                                    ? Color(0xFFFFE6E6)
                                    : Color(0xFFF5F6F9),
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20)),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Heart Icon_2.svg",
                                color: cubit.favModel!.isFav??false
                                    ? Color(0xFFFF4848)
                                    : Color(0xFFDBDEE4),
                                height: getProportionateScreenWidth(16),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
                          child: AppText(
                            text:productModel.description!,
                            textSize: 24,
                            maxLines: 4,
                          ),
                        ),
                        TopRoundedContainer(
                          color: Color(0xFFF6F7F9),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                      text: 'جنيه',
                                      fontWeight: FontWeight.bold,
                                      textSize: 22),
                                  SizedBox(
                                      width: getProportionateScreenHeight(
                                          5)),
                                  AppText(
                                      text: '${cubit.totalPrice}',
                                      fontWeight: FontWeight.bold,
                                      textSize: 25),
                                  AppText(
                                      text: ' : السعر الكلي ',
                                      fontWeight: FontWeight.bold,
                                      textSize: 22),
                                ],
                              ),
                              SizedBox(
                                  height:
                                  SizeConfigManger.bodyHeight * .03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundedIconBtn(
                                    icon: Icons.remove,
                                    press: () {
                                      cubit.removeNumber();
                                    },
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(
                                          20)),
                                  AppText(
                                      text: "${cubit.number}",
                                      textSize: 22,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                      width: getProportionateScreenWidth(
                                          20)),
                                  RoundedIconBtn(
                                    icon: Icons.add,
                                    showShadow: true,
                                    press: () {
                                      cubit.increaseNumber();
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                  SizeConfigManger.bodyHeight * .03),
/*
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    getProportionateScreenHeight(15)),
                                child: CustomTextFormField(
                                  controller: productDetails,
                                  maxLines: 2,
                                  lableText: "إضافة تفاصيل",
                                  type: TextInputType.text,
                                  suffixIcon: Icons.info_outline,
                                ),
                              ),
*/
                              TopRoundedContainer(
                                color: Colors.white,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfigManger.screenWidth *
                                          0.15,
                                      right:
                                      SizeConfigManger.screenWidth *
                                          0.15,
                                      bottom:
                                      getProportionateScreenWidth(40),
                                      top:
                                      getProportionateScreenWidth(15),
                                    ),
                                    child: CustomButton(
                                      text: "إضافة للعربة",
                                      press: () {
                                        cubit.addProductToCart(
                                            title:
                                            "${productModel.title}",
                                            image:
                                            "${productModel.image}",
                                            price: "${productModel.hasDiscount==true  ?  productModel.newPrice! : productModel.price}",
                                            details: productDetails.text);
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
