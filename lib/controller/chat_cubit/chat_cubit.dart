import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../helpers/cash_helper.dart';
import '../../models/chat_msg_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  List<ChatMessageModel> messages = [];

  ChatCubit() : super(ChatInitial()) {}

  static ChatCubit get(context) => BlocProvider.of(context);

  void getCash() {
    String? msg = CashHelper.getData(key: 'chatMessage');
    if (msg != null) {
      convertStringToList(
        val: msg,
      );
    }
  }

  Future<void> send({required String message}) async {
    emit(SendMessageInProgress());
    await Dio().post(ApiConstants.chatApi,
        queryParameters: {'x': message}).then((value) async {
      messages.add(ChatMessageModel(isSend: true, message: message));
      messages.add(ChatMessageModel(
          isSend: false, message: value.data['matching_medications'][0]));

      await CashHelper.setData(
          key: 'chatMessage', value: convertListToString(list: messages));
      emit(SendMessageSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError());
    });
  }

  String convertListToString({required List list}) {
    return jsonEncode(list);
  }

  convertStringToList({required val}) {
    print(val);
    List value = jsonDecode(val);
    messages = [];
    value.forEach((element) {
      messages.add(ChatMessageModel(
          isSend: element['isSend'], message: element['message']));
    });
  }
}
