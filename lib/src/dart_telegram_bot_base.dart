import 'dart:convert';

import 'package:dart_telegram_bot/src/context/context.dart';
import 'package:dart_telegram_bot/src/models/update.dart';
import 'package:http/http.dart' as http;

typedef Middleware = Future<void> Function(Context context, Function next);

class DartTelegramBot {
  final String token;
  final String _telegramApi = 'https://api.telegram.org/bot';
  final Map<String, Future<void> Function(Context)> _commands = {};
  final List<Middleware> _middleware = [];

  DartTelegramBot({required this.token});

  void command(String name, Future<void> Function(Context) handler) {
    _commands[name] = handler;
    print('Comando $name registrado');
    print(_commands);
  }

  void use(Middleware middleware) {
    _middleware.add(middleware);
  }

  Future<void> sendMessage({required int chatId, required String text}) async {
    await http.post(
      Uri.parse('$_telegramApi$token/sendMessage'),
      body: {'chat_id': chatId.toString(), 'text': text},
    );
  }

  Future<void> start({int pollingInterval = 1}) async {
    int lastUpdate = 0;
    print("Iniciando bot...");
    while (true) {
      try {
        print('Consultando updates desde $lastUpdate');
        final updates = await _fetchUpdates(lastUpdate);
        print('Updates recibidos: ${updates.length}');
        for (final update in updates) {
          lastUpdate = update.updateId + 1;
          final context = Context(
            bot: this,
            update: update,
            message: update.message,
          );
          print('Procesando mensaje ${context.message?.text}');
          await _processMessage(context);
        }
      } catch (e) {
        print('Error: $e');
        await Future.delayed(Duration(seconds: pollingInterval));
      }
    }
  }

  Future<void> _processMessage(Context context) async {
    await _runMiddleware(context);
    final command = _extractCommand(context.message?.text);
    print('Comando encontrado: $command');
    if (command != null) {
      final handler = _commands[command];
      if (handler != null) {
        await handler(context);
      } else {
        print("No hay handler para el comando $command");
      }
    }
  }

  Future<void> _runMiddleware(Context context) async {
    Future<void> next(int index) async {
      if (index < _middleware.length) {
        await _middleware[index](context, () => next(index + 1));
      }
    }

    await next(0);
  }

  Future<List<Update>> _fetchUpdates(int offset) async {
    final response = await http.get(
      Uri.parse('$_telegramApi$token/getUpdates?offset=$offset'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data['result']);
      return (data['result'] as List).map((e) => Update.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener updates: ${response.statusCode}');
    }
  }

  String? _extractCommand(String? text) {
    if (text == null || !text.startsWith('/')) return null;
    return text.split(' ')[0].substring(1).toLowerCase();
  }
}
