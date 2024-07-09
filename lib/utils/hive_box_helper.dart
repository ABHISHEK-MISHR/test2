
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxHelper {
  static final _hiveBox = HiveBoxHelper();
  static HiveBoxHelper get instance => _hiveBox;


  Future<void> init() async {
    await Hive.initFlutter();
  }

}