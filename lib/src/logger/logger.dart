import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:ansicolor/ansicolor.dart'; // Importamos ansicolor

/// Represents the different levels of logging.
enum LogLevel {
  /// Debug level for detailed information during development.
  debug,

  /// Informational level for general application events.
  info,

  /// Warning level for potential issues that are not errors.
  warning,

  /// Error level for critical issues that may affect the application.
  error,
}

/// A class for logging messages to the console and optionally to a file.
class Logger {

  /// Creates a new [Logger] instance.
  ///
  /// The [name] parameter is required and identifies the logger.
  /// The [logToFile] parameter determines whether to log to a file (defaults to false).
  /// The [logFilePath] parameter specifies the path to the log file (defaults to 'bot_log.txt').
  Logger({required this.name, this.logToFile = false, String? logFilePath})
    : logFilePath = logFilePath ?? 'bot_log.txt' {
    if (logToFile) {
      final file = File(path.join(Directory.current.path, logFilePath));
      _fileSink = file.openWrite(mode: FileMode.append);
    }
  }
  /// The name of the logger. Used to identify the source of the log message.
  final String name;

  /// Whether to log messages to a file.
  final bool logToFile;

  /// The path to the log file. Defaults to 'bot_log.txt' if not provided.
  final String logFilePath;
  IOSink? _fileSink;

  // Instancias de AnsiPen para cada nivel de log
  final AnsiPen _debugPen = AnsiPen()..gray();
  final AnsiPen _infoPen = AnsiPen()..blue();
  final AnsiPen _warningPen = AnsiPen()..yellow();
  final AnsiPen _errorPen = AnsiPen()..red();

  /// Logs a message with the specified [level].
  ///
  /// The [message] is the content of the log.
  /// The optional [stackTrace] can be provided for error logs or debug logs.
  void log(LogLevel level, String message, [StackTrace? stackTrace]) {
    final timestamp = DateTime.now().toIso8601String();
    final levelString = level.toString().split('.').last.toUpperCase();
    final logMessage = '$timestamp - $levelString - [$name]: $message';

    if (logToFile && _fileSink != null) {
      _fileSink!.writeln(logMessage);
      if (stackTrace != null) _fileSink!.writeln(stackTrace);
    }

    // Coloreamos el mensaje según el nivel
    String coloredLogMessage;
    switch (level) {
      case LogLevel.debug:
        coloredLogMessage = _debugPen(logMessage);
        break;
      case LogLevel.info:
        coloredLogMessage = _infoPen(logMessage);
        break;
      case LogLevel.warning:
        coloredLogMessage = _warningPen(logMessage);
        break;
      case LogLevel.error:
        coloredLogMessage = _errorPen(logMessage);
        break;
    }

    switch (level) {
      case LogLevel.debug:
        print(coloredLogMessage);
        if (stackTrace != null) print(_debugPen(stackTrace.toString()));
        break;
      case LogLevel.info:
        print(coloredLogMessage);
        break;
      case LogLevel.warning:
        print(coloredLogMessage);
        break;
      case LogLevel.error:
        stderr.writeln(coloredLogMessage); // Error en stderr
        if (stackTrace != null) {
          stderr.writeln(_errorPen(stackTrace.toString()));
        }
        break;
    }
  }

  /// Logs a debug message.
  ///
  /// The [message] is the content of the log.
  /// The optional [stackTrace] can be provided.
  void debug(String message, [StackTrace? stackTrace]) =>
      log(LogLevel.debug, message, stackTrace);

  /// Logs an informational message.
  ///
  /// The [message] is the content of the log.
  void info(String message) => log(LogLevel.info, message);

  /// Logs a warning message.
  ///
  /// The [message] is the content of the log.
  void warning(String message) => log(LogLevel.warning, message);

  /// Logs an error message.
  ///
  /// The [message] is the content of the log.
  /// The optional [stackTrace] can be provided.
  void error(String message, [StackTrace? stackTrace]) =>
      log(LogLevel.error, message, stackTrace);

  /// Closes the log file if it's open.
  ///
  /// This should be called when the logger is no longer needed.
  Future<void> close() async {
    if (_fileSink != null) await _fileSink!.close();
  }
}
