import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Show {
  static var _loadDialog;

  static showLoading({bool barrierDismissible = false}) {
    if (_loadDialog == null) {
      _loadDialog = _showLoadingDialog(barrierDismissible: barrierDismissible);
    }
  }

  static stopLoading() {
    if (_loadDialog != null) {
      Get.back();
      _loadDialog = null;
    }
  }

  static Future _showLoadingDialog({bool barrierDismissible = false}) {
    return Get.dialog(
        WillPopScope(
          onWillPop: () {
            if(!barrierDismissible) {
              return Future.value(false);
            }
            _loadDialog = null;
            return Future.value(true);
          },
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        )
    );
  }
}