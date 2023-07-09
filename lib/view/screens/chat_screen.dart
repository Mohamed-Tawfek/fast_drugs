import 'package:fast_drugs/controller/chat_cubit/chat_cubit.dart';
import 'package:fast_drugs/controller/mode_cubit/mode_cubit.dart';
import 'package:fast_drugs/models/chat_msg_cubit.dart';
import 'package:fast_drugs/shared/components/components.dart';
import 'package:fast_drugs/shared/components/custom_snackBar.dart';
import 'package:fast_drugs/shared/components/dialogs.dart';
import 'package:fast_drugs/shared/components/extensions.dart';
import 'package:fast_drugs/shared/constants/app_strings.dart';
import 'package:fast_drugs/shared/constants/dark_theme_colors.dart';
import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final TextEditingController _chatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context0) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: context0.deviceWidth,
          height: context0.deviceHeight,
          child: BlocProvider(
            create: (context) => ChatCubit()..getCash(),
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is SendMessageInProgress) {
                  showProgressDialog(context);
                }
                if (state is SendMessageSuccess) {
                  context0.pop();
                }
                if (state is SendMessageError) {
                  context0.pop();
                  showCustomSnackBar(context, AppStrings.error);
                }
              },
              builder: (context, state) {
                List<ChatMessageModel> messages =
                    ChatCubit.get(context).messages;
                return Column(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.deviceWidth * 0.06,
                          vertical: context.deviceHeight * 0.04),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          ChatMessageModel currentMessage = messages[index];
                          return currentMessage.isSend
                              ? BuildSendMsg(msg: currentMessage.message)
                              : BuildReceiveMsg(msg: currentMessage.message);
                        },
                        itemCount: messages.length,
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.deviceWidth * 0.04,
                          vertical: context.deviceHeight * 0.02),
                      child: Form(
                        key: _formKey,
                        child: Row(
                          children: [
                            Expanded(
                              child: DefaultFormField(
                                controller: _chatController,
                                hint: AppStrings.whatFeel,
                              ),
                            ),
                            SizedBox(
                              width: context.deviceWidth * 0.03,
                            ),
                            IconButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ChatCubit.get(context)
                                        .send(message: _chatController.text)
                                        .then((value) {
                                      _chatController.clear();
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.send,
                                  size: 30,
                                  color: ModeCubit.isDark
                                      ? DarkColors.sendIcon
                                      : LightColors.sendIcon,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BuildReceiveMsg extends StatelessWidget {
  const BuildReceiveMsg({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ChatBubble(
          backGroundColor: ModeCubit.isDark
              ? DarkColors.receiveChatBubble
              : LightColors.receiveChatBubble,
          clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
          child: Text(
            msg,
            style: TextStyle(
                color: ModeCubit.isDark
                    ? DarkColors.chatMsg
                    : LightColors.chatMsg),
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class BuildSendMsg extends StatelessWidget {
  const BuildSendMsg({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.deviceHeight * 0.01),
      child: Row(
        children: [
          Spacer(),
          ChatBubble(
            backGroundColor: ModeCubit.isDark
                ? DarkColors.sendChatBubble
                : LightColors.sendChatBubble,
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            child: Text(
              msg,
              style: TextStyle(
                  color: ModeCubit.isDark
                      ? DarkColors.chatMsg
                      : LightColors.chatMsg),
            ),
          ),
        ],
      ),
    );
  }
}
