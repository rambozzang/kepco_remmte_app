import 'package:logger/logger.dart';

class CmmConfig {
  static var log = Logger(
    printer: PrettyPrinter(),
  );

  static var logNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
}
