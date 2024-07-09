import 'package:get/get.dart';
import 'package:test2/utils/hive_box_helper.dart';

enum DismissableWidgetType { success, error }

enum RequestType { get, post, put, delete, patch }

enum EnvType {
  dev,
  prod;

  static Map<String, EnvType> _properties = {
    'dev': EnvType.dev,
    'prod': EnvType.prod,
  };

  static EnvType get currentEnv =>
      _properties[
          const String.fromEnvironment("FLAVOR", defaultValue: "dev")] ??
      EnvType.dev;
}
