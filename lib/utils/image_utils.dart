import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static pickImage(ImageSource source, BuildContext context, {Function(File)? onPickedImage}) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);

      if (null != image) {
        final filePath = image.path;

        File compressedFile = await FlutterNativeImage.compressImage(
          filePath,
          quality: 50,
        );

        onPickedImage?.call(compressedFile);
      }
    } catch (e) {
      if (e is PlatformException) {
        Get.rawSnackbar(message: e.message);
      }
    }
  }
}
