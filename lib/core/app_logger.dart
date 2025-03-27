import 'package:talker_flutter/talker_flutter.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late final Talker talker;

  factory AppLogger() => _instance;

  AppLogger._internal() {
    // Initialize Talker with Flutter-specific settings for console logging
    talker = TalkerFlutter.init(
      settings: TalkerSettings(
        enabled: true,
        useHistory: true,
        maxHistoryItems: 200,
        useConsoleLogs: true, // Ensure logs are printed to console
      ),
    );

    // Log app initialization
    talker.info('AppLogger initialized');
  }

  // Convenience methods for logging
  static void info(String message) => _instance.talker.info(message);
  static void debug(String message) => _instance.talker.debug(message);
  static void warning(String message) => _instance.talker.warning(message);
  static void error(String message) => _instance.talker.error(message);
  static void critical(String message) => _instance.talker.critical(message);
  static void verbose(String message) => _instance.talker.verbose(message);

  static void handle(Object error, StackTrace stackTrace, [String? message]) {
    _instance.talker.handle(error, stackTrace, message);
  }

  // Access the Talker instance directly if needed
  static Talker get instance => _instance.talker;
}
