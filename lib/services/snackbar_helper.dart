import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:test2/provider/global_provider.dart';
import 'package:test2/utils/enum_utils.dart';

class SnackBarHelper {
  static final _snackBarHelper = SnackBarHelper();
  static SnackBarHelper get instance => _snackBarHelper;
  static Flushbar? flushbar;
  GlobalStore? _globalStore;

  void init(GlobalStore g) {
    _globalStore = g;
  }

  void showBaseSnackBar(
      {required String title,
      DismissableWidgetType type = DismissableWidgetType.success,
      String? buttonText,
      Function(BuildContext ctx)? onPressed}) {
    if (_globalStore?.navigatorKey.currentContext != null) {
      if (flushbar != null && flushbar!.isShowing()) {
        return;
      }
      flushbar = Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        backgroundColor: Colors.white,
        isDismissible: false,
        duration: const Duration(seconds: 5),
        mainButton: GestureDetector(
            onTap: () {
              flushbar?.dismiss();
            },
            child: const Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ))),
        messageText: Text(
          title,
          // style: QB19BLT.copyWith(color: AppColors.ctPrimary),
        ),
      )..show(_globalStore!.navigatorKey.currentContext!);
    }
  }
}
