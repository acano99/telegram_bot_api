import 'package:dart_telegram_bot/src/models/message.dart';

class Update {
  final int updateId;
  final Message message;

  Update({required this.updateId, required this.message});

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    updateId: json['update_id'],
    message: Message.fromJson(json['message']),
  );
}
