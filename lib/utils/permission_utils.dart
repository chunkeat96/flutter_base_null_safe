import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static void requestPermission(
    BuildContext context,
    Permission permission, {
    String Function(Permission)? permanentDeniedMsg,
    bool isOpenSettingIfPermanentDenied = true,
    Function? onPermissionGranted,
    Function? onPermissionDenied,
  }) async {
    PermissionStatus status = await permission.status;

    if (status.isPermanentlyDenied) {
      if (permanentDeniedMsg != null) Get.rawSnackbar(message: permanentDeniedMsg.call(permission));
      if (isOpenSettingIfPermanentDenied) openAppSettings();
      onPermissionDenied?.call();
    } else if (status.isGranted || status.isLimited) {
      onPermissionGranted?.call();
    } else {
      PermissionStatus requestStatus = await permission.request();
      if (requestStatus.isGranted || status.isLimited) {
        onPermissionGranted?.call();
      } else {
        bool isShown = true;
        if(Platform.isAndroid){
          isShown = await permission.shouldShowRequestRationale;
        }
        if(!isShown){
          if (permanentDeniedMsg != null) Get.rawSnackbar(message: permanentDeniedMsg.call(permission));
          if (isOpenSettingIfPermanentDenied) openAppSettings();
        } else{
          print(requestStatus);
          onPermissionDenied?.call();
        }
      }
    }
  }
}
