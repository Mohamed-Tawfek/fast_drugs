part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class SendMessageInProgress extends ChatState {}
class SendMessageSuccess extends ChatState {}
class SendMessageError extends ChatState {}

