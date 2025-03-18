import 'package:dart_telegram_bot/src/models/chat.dart';

class Message {
  final int messageId;
  final Chat chat;
  final String? text;

  Message({required this.messageId, required this.chat, required this.text});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    messageId: json['message_id'],
    chat: Chat.fromJson(json['chat']),
    text: json['text'],
  );
}
