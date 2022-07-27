import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:aswaq_attar_market/ui/screens/chat_screen/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../components/message_design.dart';

class ChatScreen extends StatelessWidget {

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..readMessages(),
      child: BlocConsumer<ChatCubit, ChatState> (
        listener: (context, state) {
        },
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/chat_background.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: getProportionateScreenHeight(5)),
                Expanded(
                  child: ListView.builder(
                      itemCount: cubit.userMessageList.length,
                      itemBuilder: (context, index) {
                        return MessageDesign(
                          isMyMessage: cubit.userMessageList[index].sender == cubit.getCurrentUserUid() ? true : false,
                          time: cubit.userMessageList[index].time,
                          message: cubit.userMessageList[index].message ?? '',);
                      }),
                ),
                Material(
                  elevation: 20,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(5)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: getProportionateScreenHeight(6.0)),
                            child: Container(
                              height: SizeConfigManger.bodyHeight * 0.075,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    getProportionateScreenHeight(
                                        20.0)),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Message..',
                                      focusedBorder: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(6)),
                          child: InkWell(
                            onTap: () {
                              cubit.sendMessage(receiver: ConstantsManger.ADMIN_ID, message: messageController.text);
                              messageController.clear();
                            },
                            child: CircleAvatar(
                                radius: getProportionateScreenHeight(27.0),
                                backgroundColor: ColorsManger.lightPrimary,
                                child: const Icon(
                                  Icons.send, color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}