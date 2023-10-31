import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {

  static Future<bool> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
      return true;
    } else {
      return false;
    }
  }
}