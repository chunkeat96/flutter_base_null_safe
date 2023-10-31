import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_null_safe/widget/message_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_base_null_safe/res/label.dart';
import 'package:flutter_base_null_safe/utils/image_utils.dart';
import 'package:flutter_base_null_safe/utils/permission_utils.dart';

class ImagePickerDialog extends StatelessWidget {
  final Function(File)? onPickImage;

  const ImagePickerDialog({
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () async {
                  PermissionUtils.requestPermission(context, Permission.camera, isOpenSettingIfPermanentDenied: true,
                      onPermissionGranted: () {
                    ImageUtils.pickImage(ImageSource.camera, context, onPickedImage: (file) {
                      Get.back();
                      onPickImage?.call(file);
                    });
                  }, onPermissionDenied: () {
                    Get.dialog(MessageDialog(Label.camera_and_photos_permission_is_required.tr, isError: true));
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(Label.take_from_camera.tr,
                          style: Theme.of(context).textTheme.headline2?.copyWith(
                                fontSize: 16.0,
                              ))
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  PermissionUtils.requestPermission(context, Platform.isAndroid ? Permission.storage : Permission.photos,
                      isOpenSettingIfPermanentDenied: true, onPermissionGranted: () {
                    ImageUtils.pickImage(ImageSource.gallery, context, onPickedImage: (file) {
                      Get.back();
                      onPickImage?.call(file);
                    });
                  }, onPermissionDenied: () {
                    Get.dialog(MessageDialog(Label.camera_and_photos_permission_is_required.tr, isError: true,));
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_library,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(Label.choose_from_gallery.tr,
                          style: Theme.of(context).textTheme.headline2?.copyWith(
                                fontSize: 16.0,
                              ))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
