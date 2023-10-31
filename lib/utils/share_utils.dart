import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:share/share.dart';
import 'package:flutter_base_null_safe/res/label.dart';
import 'package:flutter_base_null_safe/utils/toast_utils.dart';

class ShareUtils {
  
  static Future<void> share(String text, {String? subject}) async {
    await Share.share(text, subject: subject);
  }

  static void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ToastUtils.show(message: Label.copied_to_clipboard.tr);
  }
}