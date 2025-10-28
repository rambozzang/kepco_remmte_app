// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReqData {
  String? otp;
  String? code;
  String? subSystem;
  String? authtype;
  String? id;
  ReqData({
    this.otp,
    this.code,
    this.subSystem,
    this.authtype,
    this.id,
  });

  ReqData copyWith({
    String? otp,
    String? code,
    String? subSystem,
    String? authtype,
    String? id,
  }) {
    return ReqData(
      otp: otp ?? this.otp,
      code: code ?? this.code,
      subSystem: subSystem ?? this.subSystem,
      authtype: authtype ?? this.authtype,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'otp': otp,
      'code': code,
      'subSystem': subSystem,
      'authtype': authtype,
      'id': id,
    };
  }

  factory ReqData.fromMap(Map<String, dynamic> map) {
    return ReqData(
      otp: map['otp'] != null ? map["otp"] ?? '' as String : null,
      code: map['code'] != null ? map["code"] ?? '' as String : null,
      subSystem:
          map['subSystem'] != null ? map["subSystem"] ?? '' as String : null,
      authtype:
          map['authtype'] != null ? map["authtype"] ?? '' as String : null,
      id: map['id'] != null ? map["id"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqData.fromJson(String source) =>
      ReqData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReqData(otp: $otp, code: $code, subSystem: $subSystem, authtype: $authtype, id: $id)';
  }

  @override
  bool operator ==(covariant ReqData other) {
    if (identical(this, other)) return true;

    return other.otp == otp &&
        other.code == code &&
        other.subSystem == subSystem &&
        other.authtype == authtype &&
        other.id == id;
  }

  @override
  int get hashCode {
    return otp.hashCode ^
        code.hashCode ^
        subSystem.hashCode ^
        authtype.hashCode ^
        id.hashCode;
  }
}
