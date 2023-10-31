import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {

  static void show({String? message, bool short = true}) {
    Fluttertoast.showToast(
        msg: message ?? '',
        toastLength: short ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
    );
  }

  static void cancel() {
    Fluttertoast.cancel();
  }
}