import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lamp_remote_app/config/auth_config.dart';
import 'package:lamp_remote_app/config/base_url_config.dart';
import 'package:lamp_remote_app/repo/data/addUser/req_adduser_data.dart';
import 'package:lamp_remote_app/repo/data/req_data.dart';
import 'package:lamp_remote_app/repo/data/res_data.dart';

/*  호출 : https://auth.kepco.co.kr:21443/module/auth/?siteCode=kepco&userId=아이디
&otp=567432&subSystem=사이트구분값
결과 : JSON String
{‘result’ : 1, ‘value’ : 100, ‘description’:’성공’}
*/

class ApiRepo {
  String baseURL = BaseUrlConfig.authCallUrl;
  String siteCode = AuthConfig.siteCode;
  String otp = AuthConfig.otp;
  String authtype = AuthConfig.authtype;
  String subSystem = AuthConfig.subSystem;

  // 인증 요청 api
  Future<ResData> callAuth(String strUserid) async {
    ReqData reqData = ReqData()
      ..otp = otp
      ..code = siteCode
      ..subSystem = subSystem
      ..authtype = authtype
      ..id = strUserid;

    var res = await Dio()
        .get('$baseURL/module/auth', queryParameters: reqData.toMap());
    debugPrint("auth Call: ${res.toString()}");
    return ResData.fromJson(res.data.toString());
  }

  // 인증 결과 조회 api
  Future<dynamic> callAuthResult(String strIdx) async {
    debugPrint("callAuthResult : ‹›${'$baseURL/module/result?idx=$strIdx'}");
    var res = await Dio().get('$baseURL/module/result?idx=$strIdx');
    debugPrint("result : ‹›${res.toString()}");
    return res;
  }
}
