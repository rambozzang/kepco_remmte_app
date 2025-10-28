import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lamp_remote_app/cntr/app_state.dart';
import 'package:lamp_remote_app/config/base_url_config.dart';
import 'package:lamp_remote_app/repo/api_repo.dart';
import 'package:lamp_remote_app/repo/data/addUser/req_adduser_data.dart';
import 'package:lamp_remote_app/repo/data/addUser/res_adduser_data.dart';
import 'package:lamp_remote_app/repo/data/res_data.dart';
import 'package:lamp_remote_app/repo/data/res_gettoken_data.dart';
import 'package:lamp_remote_app/repo/data/login/res_login_data.dart';
import 'package:lamp_remote_app/repo/data/user_info_data.dart';
import 'package:lamp_remote_app/repo/graphql_api.dart';
import 'package:lamp_remote_app/utils/enum.dart';
import 'package:lamp_remote_app/utils/utils.dart';
// import 'package:privacy_screen/privacy_screen.dart';

import 'package:crypto/crypto.dart';

class LoginBinding extends Bindings {
  @override
  dependencies() => Get.lazyPut<LoginController>(() => LoginController());
}

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  //Server  Select
  var serverSelected = 'PROD'.obs;
  // 백그라운드 실행 여부(안드 selectbox 오픈시 백그라운드 진입 안되게)
  var isKeepon = false.obs;
  // 아이디 저장여부
  var isChecked = true.obs;
  // 결과 조회 변수
  int duTimeSec = 1;
  int forCount = 60; // x번 동안 실행한다. -> duTimeSec * x = 초 동안 호출.

  final listServer = ['PROD', 'DEV'];
  var apiURL = BaseUrlConfig.apiUrlDev.obs;
  // 기본 상태관리
  Rx<LoginStatus> isAuthProcessing = LoginStatus.loading.obs;

  // value 인증요청한 idx 값.fisAuthProcessing
  var kepcoUserId = "".obs;
  var kepcoUserIdx = "".obs;
  var direction = "".obs;

  // - mSaber 앱 호출 정보
  // android 패키지명 : com.semo.msaber.KEPCO
  // android 클래스명 : 패키지명.Activity_intro
  // ios : “msaber.kepco://auth”
  // var appId = Platform.isAndroid ? '304608425' : '304608425';

  late String appUrl;
  late String appUrlPath;
  // webviewUrl ;
  late String webviewUrl;

  late BuildContext currentContext;
  final ApiRepo apirepo = ApiRepo();
  final GraphqlApi graphqlApi = GraphqlApi();
  final FToast fToast = FToast();

  //층수 SelectBox
  var floorSelected = "".obs;
  final listfloor = List<String>.generate(30, (index) => "${index + 5} 층");

  final navigatorKey = GlobalKey<NavigatorState>();

  //flutter_secure_storage 사용을 위한 초기화 작업
  static const storage = FlutterSecureStorage();

  Rx<UserInfoData> userInfoData = UserInfoData().obs;
  Rx<ResGettokenData> tokenData = ResGettokenData().obs;

  late FocusNode userIdFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode floorFocusNode;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addUserFormKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController empnoController = TextEditingController();
  final TextEditingController mailnoController = TextEditingController();
  final TextEditingController phonenoController = TextEditingController();
  final TextEditingController deptNameController = TextEditingController();
  final TextEditingController floorController = TextEditingController();

  @override
  void onInit() async {
    userIdFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    floorFocusNode = FocusNode();

    Get.log("serverSelected.value  : ${serverSelected.value}");
    apiURL.value = serverSelected.value == "PROD" ? BaseUrlConfig.apiUrlProd : BaseUrlConfig.apiUrlDev;

    appUrl = Platform.isAndroid ? 'com.semo.msaber.KEPCO' : 'msaber.kepco://auth';
    appUrlPath = Platform.isAndroid ? 'Activity_intro' : 'auth';

    userIdController.addListener(() => kepcoUserId.value = userIdController.text);

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    // WidgetsBinding.instance.addPostFrameCallback((_) => initSetting());
    initSetting();
    direction.value = "NORTH";
    // passwdController.text = "test_pwd";

    super.onInit();
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwdController.dispose();
    super.dispose();
  }

  void initSetting() async {
    try {
      String? secureUserId = await storage.read(key: "userID");

      if (secureUserId != null) {
        kepcoUserId.value = secureUserId;
        userIdController.text = secureUserId;
      }
      // 테스트코드
      // await storage.delete(key: 'token');
      // await storage.delete(key: 'webviewLoginUrl');

      String? webviewLoginUrl = await storage.read(key: "webviewLoginUrl");
      String? token = await storage.read(key: "token");
      // Utils.alert(token.toString());

      if (token != null && webviewLoginUrl != null) {
        Timer(const Duration(milliseconds: 400), () async {
          Get.put(LifeCycleGetx());
          await Get.toNamed('/webview', arguments: [webviewLoginUrl, token.toString()]);
        });
      } else {
        isAuthProcessing.value = LoginStatus.none;
        Get.put(LifeCycleGetx());
      }
    } catch (e) {
      //  Utils.alert(e.toString());
      isAuthProcessing.value = LoginStatus.none;
      Get.put(LifeCycleGetx());
    }
  }

  // 아이디 저장여부
  Future<void> savechecked() async {
    isChecked.value = !isChecked.value;
    debugPrint('isChecked.value : ${isChecked.value}');
  }

  // 동관/서관 라디오버튼 클릭
  Future<void> radiochecked(String text) async {
    direction.value = text;
  }

  // 층수 선택
  void setSelected(dynamic value) {
    debugPrint("adfasdfasdfasfdd: $value");
    floorSelected.value = value;
    floorController.text = value.toString().replaceAll(' 층', '');
  }

  String generateMBase64(String input) {
    return base64.encode(md5.convert(utf8.encode(input)).bytes);
  }

  // 서버 선택
  void setServerSelected(dynamic value) {
    serverSelected.value = value;
    apiURL.value = value == "PROD" ? BaseUrlConfig.apiUrlProd : BaseUrlConfig.apiUrlDev;
  }

  //-----------------------------------------------------
  // 호출 : https://auth.kepco.co.kr:21443/module/auth/?code=kepco&id=아이디&otp=567423&autype=2
  // 결과 : JSON String
  // {‘result’ : 1, ‘value’ : 100, ‘description’:’성공’}
  // siteCode : kepco ,  subsystem Code : 13

  Future<bool> callAuthReq() async {
    var userid = userIdController.text;

    debugPrint("callAuthReq 호출! $userid");
    ResData res = await apirepo.callAuth(userid);

    if (res.result == 1 && res.value == 'ew==') {
      // await storage.write(key: 'userID', value: '');
      await storage.delete(key: 'userID');
      isAuthProcessing.value = LoginStatus.none;
      isKeepon.value = false;
      Utils.alert("생체인증요청 호출에 실패하였습니다. 다시 시도해주세요!");
      return false;
    }

    if (res.value == '') {
      isAuthProcessing.value = LoginStatus.none;
      isKeepon.value = false;
      Utils.alert("생체인증요청 호출에 실패하였습니다. 다시 시도해주세요!");
      return false;
    }
    kepcoUserIdx.value = res.value!;

    // 아이디 저장 여부
    if (isChecked.value == true) {
      await storage.write(key: 'userID', value: userid);
    } else {
      await storage.delete(key: 'userID');
    }

    openKepcoAuthApp();
    return true;
  }

  //-----------------------------------------------------
  // - mSaber 앱 호출 정보
  // android 패키지명 : com.semo.msaber.KEPCO
  // android 클래스명 : 패키지명.Activity_intro
  // ios : “msaber.kepco://auth”
  //-----------------------------------------------------
  Future<void> openKepcoAuthApp() async {
    var openAppResult = await LaunchApp.openApp(androidPackageName: appUrl, iosUrlScheme: appUrl, openStore: false);

    if (openAppResult == 1) {
      Future.delayed(const Duration(seconds: 2), () => callAuthResult());
    } else {
      isAuthProcessing.value = LoginStatus.none;
      isKeepon.value = false;
      Utils.alert('mSafer인증앱이 설치되어 있지 않습니다!');
      // Utils.alert('mSafer인증앱이 설치되어 있지 않습니다!' );
    }
  }

  //-----------------------------------------------------
  // 인증결과 가져오기 :  호출 : https://auth.kepco.co.kr:21443:21443/module/result/?idx=인증번호
  //  결과 : JSON String
  //  {‘result’ : 1, ‘iResult: 1, ‘description’:’성공’}
  // iResult 가  0,1,4 가 아닌 경우는 실패로 간주 다시 인증요청부터 다시 해야함.
  // (0:인증진행중, 1:성공, 2:취소, 3:실패, 4차단,
  //-----------------------------------------------------
  Future<void> callAuthResult() async {
    int counter = 0;
    isAuthProcessing.value = LoginStatus.authresult;
    Timer.periodic(Duration(seconds: duTimeSec), (timer) async {
      var rst = await apirepo.callAuthResult(kepcoUserIdx.value);

      if (rst.toString() == '1') {
        timer.cancel();
        await storage.write(key: 'token', value: tokenData.value.toJson());
        await storage.write(key: 'webviewLoginUrl', value: webviewUrl);
        Get.toNamed('/webview', arguments: [webviewUrl, tokenData.value.toJson()]);
      }

      if (counter == forCount) {
        timer.cancel();
        isAuthProcessing.value = LoginStatus.none;
        isKeepon.value = false;
        Utils.alert('mSafer인증이 확인 되지 않았습니다. 다시 시도 해주세요!');
      }
      counter++;
    });
  }

  // bio 로그인
  Future<ResLoginData> bioProcess() async {
    isAuthProcessing.value = LoginStatus.login;
    ResLoginData result = ResLoginData();

    try {
      if (!await LaunchApp.isAppInstalled(
        androidPackageName: appUrl,
        iosUrlScheme: appUrl,
      )) {
        // Utils.alert("mSafer인증앱이 설치되어 있지 않습니다!");
        result.msg = 'mSafer인증앱이 설치되어 있지 않습니다!';
        result.ok = false;
        Future.delayed(const Duration(seconds: 1), () async {
          isAuthProcessing.value = LoginStatus.none;
        });

        return result;
      }

      var userid = userIdController.text;
      result = await graphqlApi.loginProc(apiURL.value, userid, "");
      debugPrint("bioProcess().result : $result ");
      //  bool? ok = result.ok;
      if (result.ok == true && result.type.toString() == "1") {
        webviewUrl = result.url!;
        empnoController.text = result.userInfo!.KEPCO_USER_TBL!.SSO_EMPNO ?? '';
        mailnoController.text = result.userInfo!.KEPCO_USER_TBL!.MAIN_EMAIL_ADDR ?? '';
        nameController.text = result.userInfo!.KEPCO_USER_TBL!.SSO_USER_NM ?? '';
        phonenoController.text = result.userInfo!.SMS_RCVR_TEL_NO ?? '';

        if (result.userInfo!.USER_ID != "") {
          isKeepon.value = true;
          getTokenProcess(result.userInfo!.USER_ID.toString());
          return result;
        }
      }
      isAuthProcessing.value = LoginStatus.none;
      return result;
    } catch (e) {
      debugPrint(e.toString());
      isAuthProcessing.value = LoginStatus.none;
    }
    isAuthProcessing.value = LoginStatus.none;
    return ResLoginData();
  }

  // 패스워드 로그인
  Future<ResLoginData> passwordProcess() async {
    isAuthProcessing.value = LoginStatus.login;
    ResLoginData result = ResLoginData();

    try {
      var userid = userIdController.text;
      var passwd = generateMBase64(passwdController.text);
      debugPrint("passwordProcess() : $userid , $passwd ");
      result = await graphqlApi.loginProc(apiURL.value, userid, passwd);

      debugPrint("passwordProcess().result : $result ");
      // tuype : 5
      if (result.ok == true && result.userInfo != null) {
        webviewUrl = result.url!;
        // //   directionController.text;
        empnoController.text = result.userInfo!.KEPCO_USER_TBL!.SSO_EMPNO ?? '';
        mailnoController.text = result.userInfo!.KEPCO_USER_TBL!.MAIN_EMAIL_ADDR ?? '';
        nameController.text = result.userInfo!.KEPCO_USER_TBL!.SSO_USER_NM ?? '';
        phonenoController.text = result.userInfo!.SMS_RCVR_TEL_NO ?? '';
      }

      //  bool? ok = result.ok;  로그인 타입 : 4
      if (result.ok == true && result.type.toString() == "4") {
        // 아이디 저장 여부
        if (isChecked.value == true) {
          await storage.write(key: 'userID', value: userid);
        } else {
          await storage.delete(key: 'userID');
        }

        ResGettokenData token = await graphqlApi.getToken(apiURL.value, result.userInfo!.USER_ID.toString());
        // webview 호출
        await storage.write(key: 'token', value: token.toJson());
        await storage.write(key: 'webviewLoginUrl', value: webviewUrl);
        Get.toNamed('/webview', arguments: [webviewUrl, token.toJson()]);
        return result;
      }

      isAuthProcessing.value = LoginStatus.none;
    } catch (e) {
      debugPrint(e.toString());
      isAuthProcessing.value = LoginStatus.none;
    }
    isAuthProcessing.value = LoginStatus.none;
    return result;
  }

  //사용자 등록요청
  Future<ResAdduserData> addUserProcess() async {
    try {
      ReqAdduserData reqAdduserData = ReqAdduserData();

      reqAdduserData.direction = direction.value;
      reqAdduserData.empno = userIdController.text;
      reqAdduserData.floor = int.parse(floorController.text);
      reqAdduserData.phoneno = phonenoController.text;
      debugPrint("reqAdduserData : ${reqAdduserData.toString()}");

      ResAdduserData result = await graphqlApi.addUserProc(apiURL.value, reqAdduserData);

      if (result.ok == true) {}
      debugPrint("addUserProcess().result : $result ");
      isAuthProcessing.value = LoginStatus.none;

      return result;
    } catch (e) {
      debugPrint(e.toString());
      isAuthProcessing.value = LoginStatus.none;
    }
    isAuthProcessing.value = LoginStatus.none;

    return ResAdduserData();
  }

  //토큰 조회
  Future<ResGettokenData> getTokenProcess(String id) async {
    try {
      debugPrint("getTokenProcess().id : $id ");
      tokenData.value = await graphqlApi.getToken(apiURL.value, id);
      callAuthReq();
    } catch (e) {
      debugPrint(e.toString());
      isKeepon.value = false;
    }
    return tokenData.value;
  }

  logout() {}
}
