import 'package:flutter/material.dart';

class ShouldUpdateUIHelper {
  static bool shouldUpdateDeviceListing = false;
  static bool showingForceUpdateDialog = false;
  static ValueNotifier<TextInputType?> updateKeyboardType = ValueNotifier(null);

  static void update(ValueNotifier<int> not) {
    not.value = not.value + 1;
  }
}
