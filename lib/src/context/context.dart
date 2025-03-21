import 'package:dart_telegram_bot/src/dart_telegram_bot_base.dart';
import 'package:dart_telegram_bot/src/models/message.dart';
import 'package:dart_telegram_bot/src/models/update.dart';

class Context {
  final DartTelegramBot bot;
  final Update update;
  final Message? message;

  Context({required this.bot, required this.update, required this.message});

  Future<void> reply(String text) async {
    print('Context: $message');
    if (message == null) return;
    print('Context: $message');
    await bot.sendMessage(chatId: message!.chat.id, text: text);
  }
}
