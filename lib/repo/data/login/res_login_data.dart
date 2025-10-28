// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lamp_remote_app/repo/data/user_info_data.dart';

class ResLoginData {
  bool? ok;
  String? error;
  String? msg;
  int? type;
  UserInfoData? userInfo;
  String? url;
  ResLoginData({
    this.ok,
    this.error,
    this.msg,
    this.type,
    this.userInfo,
    this.url,
  });

  ResLoginData copyWith({
    bool? ok,
    String? error,
    String? msg,
    int? type,
    UserInfoData? userInfo,
    String? url,
  }) {
    return ResLoginData(
      ok: ok ?? this.ok,
      error: error ?? this.error,
      msg: msg ?? this.msg,
      type: type ?? this.type,
      userInfo: userInfo ?? this.userInfo,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ok': ok,
      'error': error,
      'msg': msg,
      'type': type,
      'userInfo': userInfo?.toMap(),
      'url': url,
    };
  }

  factory ResLoginData.fromMap(Map<String, dynamic> map) {
    return ResLoginData(
      ok: map['ok'] != null ? map["ok"] ?? false as bool : null,
      error: map['error'] != null ? map["error"] ?? '' as String : null,
      msg: map['msg'] != null ? map["msg"] ?? '' as String : null,
      type: map['type'] != null ? map["type"] ?? 0 as int : null,
      userInfo: map['userInfo'] != null
          ? UserInfoData.fromMap((map["userInfo"] ??
              Map<String, dynamic>.from({})) as Map<String, dynamic>)
          : null,
      url: map['url'] != null ? map["url"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResLoginData.fromJson(String source) =>
      ResLoginData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResLoginData(ok: $ok, error: $error, msg: $msg, type: $type, userInfo: $userInfo, url: $url)';
  }

  @override
  bool operator ==(covariant ResLoginData other) {
    if (identical(this, other)) return true;

    return other.ok == ok &&
        other.error == error &&
        other.msg == msg &&
        other.type == type &&
        other.userInfo == userInfo &&
        other.url == url;
  }

  @override
  int get hashCode {
    return ok.hashCode ^
        error.hashCode ^
        msg.hashCode ^
        type.hashCode ^
        userInfo.hashCode ^
        url.hashCode;
  }
}
