// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lamp_remote_app/repo/data/user_info_data.dart';

class ResAdduserData {
  String? error;
  bool? ok;
  String? msg;
  UserInfoData? userInfo;
  ResAdduserData({
    this.error,
    this.ok,
    this.msg,
    this.userInfo,
  });

  ResAdduserData copyWith({
    String? error,
    bool? ok,
    String? msg,
    UserInfoData? userInfo,
  }) {
    return ResAdduserData(
      error: error ?? this.error,
      ok: ok ?? this.ok,
      msg: msg ?? this.msg,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'ok': ok,
      'msg': msg,
      'userInfo': userInfo?.toMap(),
    };
  }

  factory ResAdduserData.fromMap(Map<String, dynamic> map) {
    return ResAdduserData(
      error: map['error'] != null ? map["error"] ?? '' as String : null,
      ok: map['ok'] != null ? map["ok"] ?? false as bool : null,
      msg: map['msg'] != null ? map["msg"] ?? '' as String : null,
      userInfo: map['userInfo'] != null
          ? UserInfoData.fromMap((map["userInfo"] ??
              Map<String, dynamic>.from({})) as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResAdduserData.fromJson(String source) =>
      ResAdduserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResAdduserData(error: $error, ok: $ok, msg: $msg, userInfo: $userInfo)';
  }

  @override
  bool operator ==(covariant ResAdduserData other) {
    if (identical(this, other)) return true;

    return other.error == error &&
        other.ok == ok &&
        other.msg == msg &&
        other.userInfo == userInfo;
  }

  @override
  int get hashCode {
    return error.hashCode ^ ok.hashCode ^ msg.hashCode ^ userInfo.hashCode;
  }
}
