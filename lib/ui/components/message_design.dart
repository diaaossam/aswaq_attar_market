import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../shared/helper/mangers/colors.dart';
import '../../../../shared/helper/mangers/size_config.dart';
import 'app_text.dart';

class MessageDesign extends StatelessWidget {
  bool isMyMessage;
  String message;
  String? time;

  MessageDesign(
      {required this.isMyMessage,
      required this.message,
      this.time,});

  String formatTime() {
    List list = time!.split(':');
    String ma = time!.substring(time!.length - 2, time!.length);
    String messageTime = '${list[0]}:${list[1]} $ma';

    return messageTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(15),
          vertical: getProportionateScreenHeight(3)),
      child: Column(
        crossAxisAlignment:
            isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMyMessage ? ColorsManger.lightPrimaryMessage : Colors.white,
              borderRadius: BorderRadius.circular(getProportionateScreenHeight(15.0)),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: getProportionateScreenHeight(5),
                  top: getProportionateScreenHeight(1),
                  bottom: getProportionateScreenHeight(5),
                  end: getProportionateScreenHeight(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(10.0)),
                    child: AppText(text: '${message}', maxLines: 100),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        end: getProportionateScreenHeight(10)),
                    child: AppText(
                      text: '${formatTime()}',
                      color: Colors.grey,
                      textSize: getProportionateScreenHeight(14.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
