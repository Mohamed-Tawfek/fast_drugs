class ChatMessageModel{
  String message;
  bool isSend;
  ChatMessageModel({required this.isSend,required this.message});
  Map toJson() => {
    'message': message,
    'isSend': isSend,
  };
}