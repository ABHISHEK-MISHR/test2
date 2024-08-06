import 'package:logger/logger.dart';

var logger = Logger(
  filter: DevelopmentFilter(),
  level: Level.all,
  printer: PrettyPrinter(
    errorMethodCount: 5,
    excludeBox: {
      Level.info: true,
    },
    methodCount: 2,
    colors: true,
    noBoxingByDefault: false,
    printTime: true,
  ),
);
