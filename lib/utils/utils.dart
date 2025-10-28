import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Utils {
  static void toastL(String text, ToastGravity grty) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: grty, //ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 18.0);
  }

  static void toastS(String text, ToastGravity grty) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: grty, //ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 8.0);
  }

  static void alert(String msg) {
    BotToast.showText(text: msg, contentColor: Colors.black.withOpacity(0.67), textStyle: const TextStyle(fontSize: 14, color: Colors.white), duration: const Duration(seconds: 5), onlyOne: false);
  }

  static Widget loadingWidget(String msg, context) {
    Color clr = msg == "" ? Colors.transparent : Colors.white;
    return Positioned.fill(
        child: Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: clr,
          boxShadow: [BoxShadow(color: clr, blurRadius: 15, offset: Offset(4.0, 6.0))],
          // borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LoadingAnimationWidget.threeRotatingDots(
              color: const Color(0xFFEA3799),
              size: 50,
            ),
            const SizedBox(
              height: 35,
            ),
            Text(msg),
          ],
        ),
      ),
    ));
  }

  static Widget secureWidget(context) {
    //  Color clr = msg == "" ? Colors.transparent : Colors.white;
    return Positioned.fill(
      child: SvgPicture.asset(
        'assets/new_splash.svg',
      ),
    );
  }
}
