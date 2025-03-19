# Dart Telegram Bot Library

Una librería simple para crear bots de Telegram en Dart.

## Descripción

Esta librería proporciona una forma sencilla de interactuar con la API de Telegram para crear bots. Permite definir comandos, manejar mensajes y enviar respuestas. Incluye un sistema de logging configurable para facilitar el seguimiento y la depuración del bot.

## Características

*   **Manejo de Comandos:** Define comandos personalizados y sus correspondientes funciones de manejo.
*   **Envío de Mensajes:** Envía mensajes de texto a los usuarios.
*   **Sistema de Logging:** Registra eventos, errores y otra información relevante en la consola y/o en un archivo.
*   **Soporte para Diferentes Niveles de Log:** Utiliza diferentes niveles de log (debug, info, warning, error) para clasificar los mensajes.
*   **Colores en la Consola:** Muestra los mensajes en la consola con colores según su nivel de log.

## Uso

Aquí tienes un ejemplo básico de cómo crear un bot que responde a los comandos `/start`, `/hello` y `/echo`:

```dart
import 'package:dart_telegram_bot/dart_telegram_bot.dart';

void main() async {
  final String token = 'YOUR_BOT_TOKEN'; // Reemplaza con tu token
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
```

## Hoja de Ruta (Roadmap)

Esta es una lista de las funcionalidades que se planean implementar en el futuro:

*   **Procesamiento de Mensajes Editados:**
    *   Actualmente, los mensajes editados se reciben, pero no se procesan. Se debe agregar la lógica para procesar los mensajes editados.
*   **Manejo de Otros Tipos de Mensajes:**
    *   Soporte para imágenes, videos, audios, documentos, etc.
*   **Teclados Personalizados:**
    *   Implementar la posibilidad de enviar teclados personalizados a los usuarios.
*   **Comandos Inline:**
    *   Soporte para comandos inline.
*   **Webhooks:**
    *   Implementar el uso de webhooks en lugar de polling.
*   **Middleware:**
    *   Añadir más funcionalidades a los middleware.
*   **Documentación:**
    *   Añadir documentación a todos los archivos.
*   **Manejo de errores:**
    *   Mejorar el manejo de errores.
*   **Manejo de actualizaciones vacías:**
    *   Mejorar el manejo de actualizaciones vacías.
*   **Manejo de cambios en los miembros del chat:**
    *   Añadir el manejo de cambios en los miembros del chat.

## Bug

*   **Mensajes editados:**
    *   Actualmente, los mensajes editados se reciben, pero no se procesan. Se debe agregar la lógica para procesar los mensajes editados.

