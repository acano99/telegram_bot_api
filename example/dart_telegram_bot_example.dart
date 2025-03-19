import 'package:dart_telegram_bot/dart_telegram_bot.dart';

void main() async {
  final String token = '7801828955:AAGrkCZ1VFxBnhlv5dy6ULB2od9r1NOArBA';
  final bot = DartTelegramBot(token: token);

  bot.command('start', (context) async {
    await context.reply('Hola soy un bot hecho con dart');
  });

  bot.command('hello', (context) async {
    await context.reply('Hello World!');
  });

  await bot.start();
}
