import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lamp_remote_app/cntr/login_controller.dart';
import 'package:lamp_remote_app/repo/data/addUser/res_adduser_data.dart';
import 'package:lamp_remote_app/repo/data/login/res_login_data.dart';
import 'package:lamp_remote_app/utils/enum.dart';
import 'package:lamp_remote_app/utils/utils.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  void alert(String? msg) {
    String text = '잠시 후 다시 시도해 주세요!';
    if (msg == 'null' || msg == '' || msg == null) {
      text = '잠시 후 다시 시도해 주세요!';
    } else {
      text = msg;
    }

    BotToast.showText(
      text: text.toString(),
      contentColor: Colors.black.withOpacity(0.67),
      textStyle: const TextStyle(fontSize: 14, color: Colors.white),
    );
  }

  // 로그인 폼 체크
  bool isLoginFormChecked() {
    if (controller.userIdController.text.length != 8) {
      alert("User ID를 정확히 입력해주세요.(8자리)");
      controller.userIdFocusNode.requestFocus();
      return false;
    }
    controller.loginFormKey.currentState!.save();
    return true;
  }

  // 사용자 승인요청 폼 체크
  bool isAdduserFormChecked() {
    if (controller.userIdController.text.length != 8) {
      alert("User ID를 정확히 입력해주세요.(8자리) ");
      controller.userIdFocusNode.requestFocus();
      return false;
    }

    if (controller.floorController.text.isEmpty) {
      alert("근무 충수를 입력해주세요. ");
      // Utils.toastS("floor를 입력해주세요. ", ToastGravity.BOTTOM);
      controller.floorFocusNode.requestFocus();
      return false;
    }

    if (controller.direction.value == "") {
      alert("근무 위치를 선택해주세요. ");
      return false;
    }

    controller.addUserFormKey.currentState!.save();
    return true;
  }

  // 패스워드 로그인 버튼
  Future<void> passwordProcess(context) async {
    if (!isLoginFormChecked()) {
      return;
    }
    ResLoginData result = await controller.passwordProcess();

    // controller.passwdController.clear();
    if (result.ok == true && result.type.toString() == "4") {
      return;
    }

    // 사용 승인 신청 화면 호출
    if (result.type.toString() == "5") {
      WidgetsBinding.instance.addPostFrameCallback((_) => addUserDialog(controller.currentContext));
      return;
    }
    alert(result.msg.toString());
  }

  //생체인증 버튼
  Future<void> bioProcess(context) async {
    //입력값 체크
    if (!isLoginFormChecked()) {
      return;
    }

    ResLoginData result = await controller.bioProcess();
    debugPrint("result : $result");
    // controller.passwdController.clear();
    if (result.ok == true && result.type.toString() == "1") {
      return;
    }
    // 사용 승인 시청화면 회원가입여부 체크
    if (result.type == 5) {
      WidgetsBinding.instance.addPostFrameCallback((_) => addUserDialog(controller.currentContext));
      return;
    }
    alert(result.msg.toString());
  }

  Future<void> addUserProcess(context) async {
    //입력값 체크
    if (!isAdduserFormChecked()) {
      return;
    }
    ResAdduserData result = await controller.addUserProcess();

    if (result.ok == true) {
      controller.passwdController.clear();
      Navigator.pop(context);
    }
    alert(result.msg.toString());
  }

  DateTime? _currentBackPressTime;
  //뒤로가기 로직(핸드폰 뒤로가기 버튼 클릭시)
  onGoBack() async {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null || now.difference(_currentBackPressTime!) > const Duration(seconds: 3)) {
      _currentBackPressTime = now;
      Utils.toastL("한번 더 뒤로가기 선택시 앱이 종료됩니다.", ToastGravity.BOTTOM);
      return Future.value(false);
    }
    //   Get.find<LoginController>().isKeepon.value = true;
    Get.find<LoginController>().isAuthProcessing.value = LoginStatus.background;
    SystemNavigator.pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    controller.currentContext = context;

    return Obx(() {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          final result = await onGoBack();
          if (result) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
            backgroundColor: controller.isAuthProcessing.value == LoginStatus.background ? const Color(0Xff5965F5) : Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  if (controller.isAuthProcessing.value == LoginStatus.login) ...[
                    Utils.loadingWidget('사용자 확인중...', context),
                  ] else if (controller.isAuthProcessing.value == LoginStatus.appconfirm) ...[
                    Utils.loadingWidget('인증앱 설치확인중...', context),
                  ] else if (controller.isAuthProcessing.value == LoginStatus.callauth) ...[
                    Utils.loadingWidget('인증 요청중...', context),
                  ] else if (controller.isAuthProcessing.value == LoginStatus.authresult) ...[
                    Utils.loadingWidget('인증 확인중...', context),
                  ] else if (controller.isAuthProcessing.value == LoginStatus.background) ...[
                    Utils.secureWidget(context),
                  ] else if (controller.isAuthProcessing.value == LoginStatus.none) ...[
                    SingleChildScrollView(child: bodyWidget(context))
                  ] else if (controller.isAuthProcessing.value == LoginStatus.loading) ...[
                    Utils.loadingWidget('', context),
                  ] else ...[
                    Utils.loadingWidget('', context),
                  ]
                ],
              ),
            )),
      );
    });
  }

  Widget bodyWidget(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisSize: MainAxisSize.max,
          children: [
            bodyTopWidget(),
            bodyLogoWidget(context),
            bodyInputAndSave(),
            bodyButton(context),
            bodySelectServer(context),
            bodybottomLogo(context)
          ],
        ),
      ),
    );
  }

  Widget bodyTopWidget() {
    return SizedBox(
      //     color: Colors.cyanAccent,
      height: 45,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/login_icon.svg',
            width: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            '스마트 조명제어',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0Xff5965F5),
            ),
          )
        ],
      ),
    );
  }

  Widget bodyLogoWidget(context) {
    return Container(
      //  margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * .4,
      padding: const EdgeInsets.all(50),
      //  color: Colors.red,
      child: SvgPicture.asset(
        'assets/login_icon.svg',
        // width: (MediaQuery.of(context).size.height * .47) - 100,
      ),
    );
  }

  Widget bodyInputAndSave() {
    return SizedBox(
      //   color: Colors.brown,
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 9),
            height: 80,
            child: TextFormField(
              focusNode: controller.userIdFocusNode,
              style: const TextStyle(fontSize: 18),
              maxLength: 8,
              textAlign: TextAlign.center,
              controller: controller.userIdController,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: '',
                counterText: '',
                hintText: '사번을 입력해주세요',
                prefixText: '',
                // filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.0, color: Color(0Xff5965F5)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color(0Xff5965F5),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 19,
            child: GestureDetector(
              onTap: () => controller.savechecked(),
              child: Row(
                children: [
                  SizedBox(
                    width: 35,
                    child: Checkbox(
                      value: controller.isChecked.value,
                      checkColor: Colors.yellowAccent, // color of tick Mark
                      activeColor: const Color(0Xff5965F5),
                      onChanged: (value) {
                        controller.savechecked();
                      },
                    ),
                  ),
                  const Text(
                    '사번 저장',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyButton(context) {
    return SizedBox(
      //  color: Colors.red,
      height: 138,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          height: 66,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // background (button) color
                foregroundColor: Colors.white, //
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                side: const BorderSide(
                  width: 2.0,
                  color: Color(0Xff5965F5),
                )),
            onPressed: () => bioProcess(context),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.fingerprint,
                  size: 24,
                  color: Color(0Xff5965F5),
                ),
                SizedBox(width: 5),
                Text(
                  "생체인증 로그인",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0Xff5965F5)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          height: 66,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                side: const BorderSide(
                  width: 2.0,
                  color: Color(0Xff5965F5),
                )),
            onPressed: () {
              //addUserDialog(context);
              if (!isLoginFormChecked()) {
                return;
              }
              passwordDialog(context);
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.lock_clock_outlined, size: 24, color: Color(0Xff5965F5)),
                SizedBox(width: 4),
                Text(
                  "패스워드 로그인",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0Xff5965F5)),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget bodySelectServer(context) {
    return Container(
      alignment: Alignment.bottomRight,
      // color: Colors.white,
      height: 50,
      width: double.infinity,
      // child: DropdownButton(
      //   hint: const Text(
      //     '연결 서버',
      //   ),
      //   onChanged: (newValue) {
      //     controller.setServerSelected(newValue.toString());
      //   },
      //   // menuMaxHeight: 50,
      //   value: controller.serverSelected.value,
      //   items: controller.listServer.map((e) {
      //     return DropdownMenuItem(
      //       value: e,
      //       child: Text(e),
      //     );
      //   }).toList(),
      // ),
    );
  }

  Widget bodybottomLogo(context) {
    return Container(
        alignment: Alignment.center,
        //    color: Colors.yellow,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.8,

        //  color: Colors.amber,
        child: SvgPicture.asset(
          'assets/KEPCO1.svg',
          width: 160,
        ));
  }

  // 패스워드 로그인 팝업창
  void passwordDialog(cntx) async {
    await showDialog(
      context: cntx,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            height: 48,
            width: double.infinity,
            color: const Color(0Xff5965F5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    '패스워드',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.close_outlined), color: Colors.white, iconSize: 20.0, onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          //
          contentPadding: const EdgeInsets.all(10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 60,
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0Xff5965F5),
                  ),
                  autofocus: true,
                  focusNode: controller.passwordFocusNode,
                  controller: controller.passwdController,
                  obscureText: true,
                  validator: (String? arg) {
                    if (arg!.length < 2) {
                      Utils.toastS("Password를 입력해주세요", ToastGravity.BOTTOM);
                      return 'Password를 입력해주세요';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password 입력',
                    hintText: 'Password를 입력해주세요',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0Xff5965F5),
                        )),
                    suffixIcon: controller.kepcoUserId.value.isNotEmpty //엑스버튼
                        // ignore: avoid_unnecessary_containers
                        ? Container(
                            child: IconButton(
                              alignment: Alignment.centerRight,
                              icon: const Icon(
                                Icons.cancel,
                                color: Color(0Xff5965F5),
                              ),
                              onPressed: () {
                                controller.passwdController.clear();
                              },
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0Xff5965F5),
                  //  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              onPressed: () {
                if (controller.passwdController.text.length < 3) {
                  Utils.toastS("패스워를 입력해주세요.", ToastGravity.BOTTOM);
                  controller.passwordFocusNode.requestFocus();
                  return;
                }
                controller.passwordFocusNode.unfocus();
                controller.userIdFocusNode.unfocus();
                Navigator.pop(context);
                passwordProcess(context);
              },
              child: const Text(
                '      로그인      ',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        );
      },
    ).then((val) {
      debugPrint('=========> $val');
      // FocusScope.of(cntx).requestFocus(FocusNode());
      controller.passwordFocusNode.requestFocus();
      // FocusScope.of(cntx).requestFocus(controller.passwordFocusNode);
    });
  }

  // 회원 가입 팝업창

  Future<void> addUserDialog(BuildContext cntx) async {
    showDialog(
      context: cntx,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            height: 45,
            width: double.infinity,
            color: const Color(0Xff5965F5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 1,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "사용자 승인요청",
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.close_outlined), color: Colors.white, iconSize: 20.0, onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          //
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Form(
              key: controller.addUserFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "근무 층",
                          style: TextStyle(
                            color: Color(0Xff5965F5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F4Fc),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 223, 228, 242),
                      ),
                    ),
                    child: Obx(
                      () => DropdownButton(
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.expand_more,
                          size: 30,
                        ),
                        // style: const TextStyle(
                        //     color: Colors.black, decorationColor: Colors.black),
                        hint: const Text(
                          '근무 층수',
                        ),
                        onChanged: (newValue) {
                          controller.setSelected(newValue.toString());
                        },
                        menuMaxHeight: 300,
                        value: controller.floorSelected.value == "" ? null : controller.floorSelected.value,
                        items: controller.listfloor.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text("      $e"),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F4Fc),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(255, 223, 228, 242),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => controller.radiochecked("NORTH"),
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              height: 45,
                              child: Row(
                                children: [
                                  if (controller.direction.value == "NORTH") ...[
                                    const Icon(
                                      Icons.check,
                                      size: 20,
                                      color: Color(0Xff5965F5),
                                    ),
                                  ] else ...[
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  // Radio(
                                  //   value: "NORTH",
                                  //   // toggleable: true,
                                  //   groupValue:
                                  //       controller.direction.value.toString(),
                                  //   onChanged: (String? value) {
                                  //     controller.radiochecked(value!);
                                  //   },
                                  // ),
                                  const Text("북측"),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 2,
                            color: Color(0Xff5965F5),
                          ),
                          GestureDetector(
                            onTap: () => controller.radiochecked("SOUTH"),
                            child: Container(
                              width: double.infinity,
                              height: 44,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  if (controller.direction.value == "SOUTH") ...[
                                    const Icon(
                                      Icons.check,
                                      size: 20,
                                      color: Color(0Xff5965F5),
                                    ),
                                  ] else ...[
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("남측")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.all(0),
          actionsOverflowButtonSpacing: 0,
          actions: <Widget>[
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => addUserProcess(context),
                        child: Container(
                          height: 47,
                          width: double.infinity,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: const Text(
                            "승인 요청",
                            style: TextStyle(
                              color: Color(0Xff5965F5),
                            ),
                          ),
                        ),
                      ),
                      // child: ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color.fromARGB(255, 255, 255, 255),
                      //       backgroundColor:
                      //           const Color.fromARGB(255, 255, 255, 255),
                      //       //  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      //       textStyle: const TextStyle(
                      //           fontSize: 14, fontWeight: FontWeight.bold)),
                      //   onPressed: () => addUserProcess(context),
                      //   child: const Text(
                      //     "승인 요청",
                      //     style: TextStyle(
                      //       color: Color(0Xff5965F5),
                      //     ),
                      //   ),
                      // ),
                    ),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: const Text(
                            "취소",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      // child: ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color.fromARGB(255, 255, 255, 255),
                      //       //  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      //       textStyle: const TextStyle(
                      //           fontSize: 14, fontWeight: FontWeight.bold)),
                      //   onPressed: () => Navigator.pop(context),
                      //   child: const Text(
                      //     "취소",
                      //     style: TextStyle(color: Colors.grey),
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ).then((val) {
      debugPrint('=========> $val');
      FocusScope.of(cntx).requestFocus(FocusNode());
    });
  }
}
