import 'package:get/get.dart';
import 'package:lamp_remote_app/cntr/login_controller.dart';
import 'package:lamp_remote_app/pages/login/login_page.dart';

import 'package:lamp_remote_app/pages/webview/webview_page.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = '/login';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/webview',
      page: () => const WebviewPage(),
      // transition: Transition.fade,
      //  binding: HomeBinding(),
    ),
  ];
}
