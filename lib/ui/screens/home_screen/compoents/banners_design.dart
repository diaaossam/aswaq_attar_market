import 'package:aswaq_attar_market/shared/helper/mangers/colors.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/cubit/main_cubit.dart';

class BannersDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: SizeConfigManger.bodyHeight * .25,
              width: double.infinity,
              child: CarouselSlider(
                items: MainCubit.get(context).bannersList
                    .map((e) => Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    /*decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(e),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(15)),*/child: CachedNetworkImage(
                    imageUrl: "${e.image}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                  ),
                ))
                    .toList(),
                options: CarouselOptions(
                  onPageChanged: (int index, reason) {
                    MainCubit.get(context).changeIndicator(index);
                  },
                  viewportFraction: 1.0,
                  height:  SizeConfigManger.bodyHeight * .25,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    MainCubit.get(context).bannersList.length,
                    (index) => Indicator(
                        isActive:
                            MainCubit.get(context).currentIndicator == index
                                ? true
                                : false))
              ],
            ),
          ],
        );
      },
    );
  }

/*  List<String> appBannerList = [
    "assets/images/monzfat.jpg",
    "assets/images/zeyot.jpg",
    "assets/images/beqala.jpg",
    "assets/images/etara.jpg",
  ];*/
}

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 22.0 : 8,
      height: 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? ColorsManger.darkPrimary: Colors.grey),
    );
  }
}
