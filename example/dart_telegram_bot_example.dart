import 'package:dart_telegram_bot/dart_telegram_bot.dart';
import 'package:path/path.dart';

void main() async {
  final String token = '7166276410:AAFB8XogBcbfT1E5605Rzlo86QSKUzhAtrM';
  final bot = DartTelegramBot(token: token);

  bot.command('start', (context) async {
    await context.reply('Hola soy un bot hecho con dart');
  });

  bot.command('hello', (context) async {
    await context.reply('Hello World!');
  });

  bot.command('echo', (context) async {
    final messageText = context.message?.text;
    if (messageText != null) {
      final parts = messageText.split(' ');
      if (parts.length > 1) {
        final textToEcho = parts.sublist(1).join(' ').toUpperCase();
        await context.reply(textToEcho);
      } else {
        await context.reply('Debes escribir algo despues de /echo');
      }
    }
  });

  bot.command('sumar', (context) async {
    context.reply("2+2 = ${2 + 2}");
  });

  await bot.start();
}
