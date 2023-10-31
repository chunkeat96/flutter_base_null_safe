import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'bindings/initial_binding.dart';
import 'global/secure_local_storage.dart';
import 'res/colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {

  String get initialRoute {
    return Get.find<SecureLocalStorage>().accessToken.isEmpty ? AppRoutes.landingPage : AppRoutes.landingPage;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: GetMaterialApp(
        theme: _getTheme(),
        getPages: AppPage.routes,
        initialRoute: initialRoute,
        initialBinding: InitialBinding(),
      ),
    );
  }

  ThemeData _getTheme({bool isDarkMode = false}) {
    return ThemeData(
      errorColor: isDarkMode ? Colors.red : Colors.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: Colours.primary,
      accentColor: Colours.primary,
      scaffoldBackgroundColor: isDarkMode ? Colours.scaffold_dark_bg : Colours.scaffold_bg,
      iconTheme: IconThemeData(color: Colors.white),
      highlightColor: Color.fromRGBO(255, 255, 255, .05),
      splashColor: Colors.transparent,
      bottomAppBarColor: Colors.white,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black
      ),
      appBarTheme: AppBarTheme(color: Colours.primary),
      dialogBackgroundColor: Colors.white,
      textTheme: TextTheme(
        subtitle1: isDarkMode ? TextStyle(fontSize: 14, color: Colors.white) : TextStyle(fontSize: 14, color: Colors.black),
        bodyText1: isDarkMode ? TextStyle(color: Color(0xFF888888), fontSize: 16.0) : TextStyle(color: Color(0xFF888888), fontSize: 16.0),
        bodyText2: isDarkMode ? TextStyle(color: Color(0xffcccccc), fontSize: 14.0) : TextStyle(color: Colors.black54, fontSize: 14.0),
        subtitle2: isDarkMode ? TextStyle(fontSize: 14, color: Colors.white) : TextStyle(fontSize: 14, color: Colors.black),
        // regular
        headline1: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w400),
        // medium
        headline2: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
        // bold
        headline3: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w700),
        // light
        headline4: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w300),
        // black
        headline5: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w900),
        button: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.white,
        labelColor: Colors.white,
      ),
      dividerColor: Colors.grey,
    );
  }
}
