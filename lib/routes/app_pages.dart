import 'package:flutter_base_null_safe/bindings/landing_binding.dart';
import 'package:flutter_base_null_safe/page/landing_page.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPage {
  static final routes = [
    GetPage(
      name: AppRoutes.landingPage,
      page: () => LandingPage(),
      binding: LandingBinding()
    ),
  ];
}