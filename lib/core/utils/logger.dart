import 'package:flutter/foundation.dart';

/// A utility class for logging that only prints in debug mode.
/// This prevents sensitive information or clutter from appearing in production logs.
class Logger {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('StackTrace: $stackTrace');
    }
  }

  static void debug(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
    }
  }
}
