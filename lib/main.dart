import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lamp_remote_app/route/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: "Application",
      navigatorKey: GlobalKey<NavigatorState>(),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0Xff5965F5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
