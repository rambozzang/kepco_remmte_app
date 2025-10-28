import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lamp_remote_app/cntr/login_controller.dart';
import 'package:lamp_remote_app/config/base_url_config.dart';
import 'package:lamp_remote_app/repo/data/res_gettoken_data.dart';
import 'package:lamp_remote_app/utils/enum.dart';
import 'package:lamp_remote_app/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
/*
https://all-dev-kang.tistory.com/entry/%ED%94%8C%EB%9F%AC%ED%84%B0-%EB%A1%9C%EA%B7%B8%EC%9D%B8-%EA%B2%BD%ED%97%98%EC%9D%84-%ED%95%9C%EB%8B%A8%EA%B3%84-%EB%81%8C%EC%96%B4%EC%98%AC%EB%A6%AC%EA%B8%B0-feat%EC%9B%B9%EB%B7%B0-%EB%A6%AC%EC%95%A1%ED%8A%B8
https://dev-yakuza.posstree.com/ko/flutter/webview_flutter/

flutter <-> react js 통신
https://kbwplace.tistory.com/176
*/

var log = Logger(
  printer: PrettyPrinter(),
);

var logNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final WebViewController webviewCntr;
  final homeUrl = Uri.parse("${BaseUrlConfig.baseWebViewUrlProd}/login");
  final homeUrl2 = Uri.parse("${BaseUrlConfig.baseWebViewUrlDev}/login");

  late DateTime backbuttonpressedTime;
  DateTime? _currentBackPressTime;
  late Uri curentUrl;

  @override
  void initState() {
    super.initState();

    var args = Get.arguments;
    var webviewUrl = args[0];

    if (args[1] == null) {
      Utils.alert("로그아웃되었습니다.!");
      Get.find<LoginController>().isAuthProcessing.value = LoginStatus.none;
      Navigator.of(context).pop(true);
    } else {
      var tokenData = ResGettokenData.fromJson(args[1].toString());

      webviewUrl = webviewUrl
          .replaceAll('#atct', tokenData.accessToken!.ciphertext.toString())
          .replaceAll('#atn', tokenData.accessToken!.nonce.toString())
          .replaceAll('#att', tokenData.accessToken!.tag.toString())
          .replaceAll('#rtct', tokenData.refreshToken!.ciphertext.toString())
          .replaceAll('#rtn', tokenData.refreshToken!.nonce.toString())
          .replaceAll('#rtt', tokenData.refreshToken!.tag.toString());

      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      webviewCntr = WebViewController.fromPlatformCreationParams(params);
      // ···
      if (webviewCntr.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        (webviewCntr.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
      }
      // 페이지 불러오기
      pageLoading(webviewUrl);
    }
  }

  void pageLoading(String url) async {
    webviewCntr
      ..getScrollPosition().ignore()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(0, 191, 209, 243))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            //log.d('progress loading: $progress');
          },
          onPageStarted: (String url) {
            //g.d('onPageStarted : $url');
            developer.log('onPageStarted : $url');
            curentUrl = Uri.parse(url);
            Get.find<LoginController>().isAuthProcessing.value = LoginStatus.loading;
          },
          onPageFinished: (String url) async {
            log.d('onPageFinished : $url');
            Get.find<LoginController>().isAuthProcessing.value = LoginStatus.none;
            Get.find<LoginController>().isKeepon.value = false;
            //  Navigator.of(context).pop(true);
          },
          onWebResourceError: (WebResourceError error) {
            // Utils.alert("다시 로그인 해주세요! +$error");
            log.d('onWebResourceError : ${error.toString()}}');
            // Get.find<LoginController>().isAuthProcessing.value = LoginStatus.none;
            // Navigator.of(context).pop(true);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      //React 에서 호출 하는 함수 데이터
      ..addJavaScriptChannel("flutterFunc", onMessageReceived: (JavaScriptMessage? msg) async {
        var json = jsonDecode(msg!.message);
        log.d("Reactjs -> json : ${json.toString()}");
        var result = json['mode'].toString();

        if (result == 'logout') {
          LoginController.to.isAuthProcessing.value = LoginStatus.none;
          LoginController.to.isKeepon.value = false;

          const storage = FlutterSecureStorage();
          await storage.delete(key: 'token');
          await storage.delete(key: 'webviewLoginUrl');
          if (LoginController.to.isChecked.value == false) {
            LoginController.to.userIdController.clear();
          }
          LoginController.to.passwdController.clear();

          Navigator.of(context).pop(true);
        } else if (result == 'keepon') {
          // 안드 백그라운드 진입시 시크릿화면 안넘어가게
          LoginController.to.isKeepon.value = true;
        } else if (result == 'keepoff') {
          LoginController.to.isKeepon.value = false;
        } else {
          Utils.alert("로그아웃되었습니다.!");
          LoginController.to.isAuthProcessing.value = LoginStatus.none;
          LoginController.to.isKeepon.value = false;
          LoginController.to.passwdController.clear();
          // await storage.delete(key: 'token');
          // await storage.delete(key: 'webviewLoginUrl');
          if (Platform.isIOS) {
            exit(0);
          } else {
            SystemNavigator.pop();
          }
        }
      })
      ..loadRequest(Uri.parse(url.toString()));
  }

  void callReactjsfunction(int index) {
    webviewCntr.runJavaScript('window.gotopage($index)');
  }

  //뒤로가기 로직(핸드폰 뒤로가기 버튼 클릭시)
  Future<bool> onGoBack() {
    var future = webviewCntr.canGoBack();

    return future.then((isbackabled) {
      // ignore: unrelated_type_equality_checks
      if ((isbackabled && (homeUrl2 == curentUrl.toString().split("?")[0])) ||
          (isbackabled && (homeUrl == curentUrl.toString().split("?")[0]))) {
        webviewCntr.goBack();
        return Future.value(false);
      } else {
        DateTime now = DateTime.now();
        if (_currentBackPressTime == null || now.difference(_currentBackPressTime!) > const Duration(seconds: 3)) {
          _currentBackPressTime = now;
          Utils.toastL("한번 더 뒤로가기 선택시 앱이 종료됩니다", ToastGravity.BOTTOM);
          return Future.value(false);
        }
        //  Get.find<LoginController>().isKeepon.value = true;
        Get.find<LoginController>().isAuthProcessing.value = LoginStatus.background;
        SystemNavigator.pop();
        return Future.value(true);
      }
    });
  }

  final Set<Factory<VerticalDragGestureRecognizer>> gestureRecognizers1 = {Factory(() => VerticalDragGestureRecognizer())};
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers2 = {Factory(() => EagerGestureRecognizer())};
  final Set<Factory<PanGestureRecognizer>> gestureRecognizers3 = {Factory(() => PanGestureRecognizer())};

  @override
  Widget build(BuildContext context) {
    var cntr = Get.find<LoginController>();
    return WillPopScope(
      onWillPop: () => onGoBack(),
      child: Obx(() => Scaffold(
            // backgroundColor: const Color(0Xff5965F5),
            backgroundColor: cntr.isAuthProcessing.value == LoginStatus.background ? const Color(0Xff5965F5) : null,
            body: SafeArea(
              child: Stack(
                children: [
                  if (cntr.isAuthProcessing.value == LoginStatus.background) ...[
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/new_splash.svg',
                        //   height: MediaQuery.of(context).size.height,
                      ),
                    ),
                  ] else ...[
                    Positioned.fill(
                      child: WebViewWidget(gestureRecognizers: gestureRecognizers1, controller: webviewCntr),
                    ),
                  ]
                ],
              ),
            ),
          )),
    );
  }
}
