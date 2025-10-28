// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lamp_remote_app/repo/data/res_accessToken_data.dart';
import 'package:lamp_remote_app/repo/data/res_refreshToken_data.dart';

class ResGettokenData {
  ResAccessTokenData? accessToken;
  String? error;
  bool? ok;
  ResRefreshTokenData? refreshToken;
  ResGettokenData({
    this.accessToken,
    this.error,
    this.ok,
    this.refreshToken,
  });

  ResGettokenData copyWith({
    ResAccessTokenData? accessToken,
    String? error,
    bool? ok,
    ResRefreshTokenData? refreshToken,
  }) {
    return ResGettokenData(
      accessToken: accessToken ?? this.accessToken,
      error: error ?? this.error,
      ok: ok ?? this.ok,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken?.toMap(),
      'error': error,
      'ok': ok,
      'refreshToken': refreshToken?.toMap(),
    };
  }

  factory ResGettokenData.fromMap(Map<String, dynamic> map) {
    return ResGettokenData(
      accessToken: map['accessToken'] != null ? ResAccessTokenData.fromMap((map["accessToken"] ?? Map<String, dynamic>.from({})) as Map<String, dynamic>) : null,
      error: map['error'] != null ? map["error"] ?? '' as String : null,
      ok: map['ok'] != null ? map["ok"] ?? false as bool : null,
      refreshToken: map['refreshToken'] != null ? ResRefreshTokenData.fromMap((map["refreshToken"] ?? Map<String, dynamic>.from({})) as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResGettokenData.fromJson(String source) {
    if (source == "") return ResGettokenData();
    return ResGettokenData.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() {
    return 'ResGettokenData(accessToken: $accessToken, error: $error, ok: $ok, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(covariant ResGettokenData other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken && other.error == error && other.ok == ok && other.refreshToken == refreshToken;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^ error.hashCode ^ ok.hashCode ^ refreshToken.hashCode;
  }
}
