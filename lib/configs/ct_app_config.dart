
import 'package:test2/configs/prod.config.dart';
import 'package:test2/constants/config.constants.dart';
import 'package:test2/utils/typedefs.dart';

import '../utils/enum_utils.dart';
import 'dev.config.dart';

class CtAppConfig {
  EnvType get envType => EnvType.currentEnv;
  static final _instance = CtAppConfig();
  static CtAppConfig get instance => _instance;

  Map<String, String> get envConfig => _environmentMap[envType]!.call();

  bool get logEnabled => envConfig[ConfigConstants.debugLogEnabled] == '1';
  String get baseUrl => envConfig[ConfigConstants.appBaseUrl]!;
}

Map<EnvType, EnvironmentMapBuilder> _environmentMap = {
  EnvType.dev: getDevEnvMap,
  EnvType.prod: getProductionsEnvMap,
};
