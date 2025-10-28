// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lamp_remote_app/cntr/login_controller.dart';
// import 'package:lamp_remote_app/utils/enum.dart';

// class LifecycleController extends SuperController {
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onDetached() {
//     debugPrint("--------------------------------------------------");
//     debugPrint("onDetached!!");
//     debugPrint("--------------------------------------------------");
//   }

//   // background 로 넘어갔을떄...
//   @override
//   void onInactive() {
//     // LoginController.to.isAuthProcessing.value = LoginStatus.login;
//     debugPrint("--------------------------------------------------");
//     // debugPrint("onInactive!!  ${Get.find<LoginController>().isAuthProcessing.value}");
//     debugPrint("onInactive!!");
//     debugPrint("--------------------------------------------------");
//   }

//   // background 로 넘어갔을떄...
//   @override
//   void onPaused() {
//     debugPrint("--------------------------------------------------");
//     debugPrint("onPaused!! ");
//     debugPrint("--------------------------------------------------");
//   }

//   // foreground 로 넘어갔을떄...
//   @override
//   void onResumed() {
//     debugPrint("--------------------------------------------------");
//     debugPrint("onResumed!!");
//     debugPrint("--------------------------------------------------");
//     //  LoginController.to.isAuthProcessing.value = LoginStatus.none;
//   }
// }
