import 'package:dart_telegram_bot/src/models/message.dart';

class Update {
  final int updateId;
  final Message? message;

  Update({required this.updateId, required this.message});

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    updateId: json['update_id'],
    message: Message.fromJson(json['message']),
  );
}

  // TODO: Hay un bug con los mensajes editados.
  // Actualmente, solo se esta guardando el mensaje editado, pero no se esta procesando.
  // Se debe agregar la logica para procesar los mensajes editados.
