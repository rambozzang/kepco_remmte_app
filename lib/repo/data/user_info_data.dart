// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lamp_remote_app/repo/data/kepco_user_tbl_data.dart';
import 'package:lamp_remote_app/repo/data/user_position_data.dart';

class UserInfoData {
  String? USER_ID;
  String? FRST_REG_DT;
  String? FRST_REGR_EMPNO;
  String? LST_CHG_DT;
  String? LST_CHGR_EMPNO;
  String? SMS_RCVR_TEL_NO;
  UserPositionData? POSITION;
  String? LOC_ID;
  String? APR_USER_CFM_YN;
  String? MNGR_AUTH_YN;
  String? SYS_MNGR_YN;
  KepcoUserTblData? KEPCO_USER_TBL;
  String? SSO_ID;
  UserInfoData({
    this.USER_ID,
    this.FRST_REG_DT,
    this.FRST_REGR_EMPNO,
    this.LST_CHG_DT,
    this.LST_CHGR_EMPNO,
    this.SMS_RCVR_TEL_NO,
    this.POSITION,
    this.LOC_ID,
    this.APR_USER_CFM_YN,
    this.MNGR_AUTH_YN,
    this.SYS_MNGR_YN,
    this.KEPCO_USER_TBL,
    this.SSO_ID,
  });

  UserInfoData copyWith({
    String? USER_ID,
    String? FRST_REG_DT,
    String? FRST_REGR_EMPNO,
    String? LST_CHG_DT,
    String? LST_CHGR_EMPNO,
    String? SMS_RCVR_TEL_NO,
    UserPositionData? POSITION,
    String? LOC_ID,
    String? APR_USER_CFM_YN,
    String? MNGR_AUTH_YN,
    String? SYS_MNGR_YN,
    KepcoUserTblData? KEPCO_USER_TBL,
    String? SSO_ID,
  }) {
    return UserInfoData(
      USER_ID: USER_ID ?? this.USER_ID,
      FRST_REG_DT: FRST_REG_DT ?? this.FRST_REG_DT,
      FRST_REGR_EMPNO: FRST_REGR_EMPNO ?? this.FRST_REGR_EMPNO,
      LST_CHG_DT: LST_CHG_DT ?? this.LST_CHG_DT,
      LST_CHGR_EMPNO: LST_CHGR_EMPNO ?? this.LST_CHGR_EMPNO,
      SMS_RCVR_TEL_NO: SMS_RCVR_TEL_NO ?? this.SMS_RCVR_TEL_NO,
      POSITION: POSITION ?? this.POSITION,
      LOC_ID: LOC_ID ?? this.LOC_ID,
      APR_USER_CFM_YN: APR_USER_CFM_YN ?? this.APR_USER_CFM_YN,
      MNGR_AUTH_YN: MNGR_AUTH_YN ?? this.MNGR_AUTH_YN,
      SYS_MNGR_YN: SYS_MNGR_YN ?? this.SYS_MNGR_YN,
      KEPCO_USER_TBL: KEPCO_USER_TBL ?? this.KEPCO_USER_TBL,
      SSO_ID: SSO_ID ?? this.SSO_ID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'USER_ID': USER_ID,
      'FRST_REG_DT': FRST_REG_DT,
      'FRST_REGR_EMPNO': FRST_REGR_EMPNO,
      'LST_CHG_DT': LST_CHG_DT,
      'LST_CHGR_EMPNO': LST_CHGR_EMPNO,
      'SMS_RCVR_TEL_NO': SMS_RCVR_TEL_NO,
      'POSITION': POSITION?.toMap(),
      'LOC_ID': LOC_ID,
      'APR_USER_CFM_YN': APR_USER_CFM_YN,
      'MNGR_AUTH_YN': MNGR_AUTH_YN,
      'SYS_MNGR_YN': SYS_MNGR_YN,
      'KEPCO_USER_TBL': KEPCO_USER_TBL?.toMap(),
      'SSO_ID': SSO_ID,
    };
  }

  factory UserInfoData.fromMap(Map<String, dynamic> map) {
    return UserInfoData(
      USER_ID: map['USER_ID'] != null ? map["USER_ID"] ?? '' as String : null,
      FRST_REG_DT: map['FRST_REG_DT'] != null
          ? map["FRST_REG_DT"] ?? '' as String
          : null,
      FRST_REGR_EMPNO: map['FRST_REGR_EMPNO'] != null
          ? map["FRST_REGR_EMPNO"] ?? '' as String
          : null,
      LST_CHG_DT:
          map['LST_CHG_DT'] != null ? map["LST_CHG_DT"] ?? '' as String : null,
      LST_CHGR_EMPNO: map['LST_CHGR_EMPNO'] != null
          ? map["LST_CHGR_EMPNO"] ?? '' as String
          : null,
      SMS_RCVR_TEL_NO: map['SMS_RCVR_TEL_NO'] != null
          ? map["SMS_RCVR_TEL_NO"] ?? '' as String
          : null,
      POSITION: map['POSITION'] != null
          ? UserPositionData.fromMap((map["POSITION"] ??
              Map<String, dynamic>.from({})) as Map<String, dynamic>)
          : null,
      LOC_ID: map['LOC_ID'] != null ? map["LOC_ID"] ?? '' as String : null,
      APR_USER_CFM_YN: map['APR_USER_CFM_YN'] != null
          ? map["APR_USER_CFM_YN"] ?? '' as String
          : null,
      MNGR_AUTH_YN: map['MNGR_AUTH_YN'] != null
          ? map["MNGR_AUTH_YN"] ?? '' as String
          : null,
      SYS_MNGR_YN: map['SYS_MNGR_YN'] != null
          ? map["SYS_MNGR_YN"] ?? '' as String
          : null,
      KEPCO_USER_TBL: map['KEPCO_USER_TBL'] != null
          ? KepcoUserTblData.fromMap((map["KEPCO_USER_TBL"] ??
              Map<String, dynamic>.from({})) as Map<String, dynamic>)
          : null,
      SSO_ID: map['SSO_ID'] != null ? map["SSO_ID"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoData.fromJson(String source) =>
      UserInfoData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfoData(USER_ID: $USER_ID, FRST_REG_DT: $FRST_REG_DT, FRST_REGR_EMPNO: $FRST_REGR_EMPNO, LST_CHG_DT: $LST_CHG_DT, LST_CHGR_EMPNO: $LST_CHGR_EMPNO, SMS_RCVR_TEL_NO: $SMS_RCVR_TEL_NO, POSITION: $POSITION, LOC_ID: $LOC_ID, APR_USER_CFM_YN: $APR_USER_CFM_YN, MNGR_AUTH_YN: $MNGR_AUTH_YN, SYS_MNGR_YN: $SYS_MNGR_YN, KEPCO_USER_TBL: $KEPCO_USER_TBL, SSO_ID: $SSO_ID)';
  }

  @override
  bool operator ==(covariant UserInfoData other) {
    if (identical(this, other)) return true;

    return other.USER_ID == USER_ID &&
        other.FRST_REG_DT == FRST_REG_DT &&
        other.FRST_REGR_EMPNO == FRST_REGR_EMPNO &&
        other.LST_CHG_DT == LST_CHG_DT &&
        other.LST_CHGR_EMPNO == LST_CHGR_EMPNO &&
        other.SMS_RCVR_TEL_NO == SMS_RCVR_TEL_NO &&
        other.POSITION == POSITION &&
        other.LOC_ID == LOC_ID &&
        other.APR_USER_CFM_YN == APR_USER_CFM_YN &&
        other.MNGR_AUTH_YN == MNGR_AUTH_YN &&
        other.SYS_MNGR_YN == SYS_MNGR_YN &&
        other.KEPCO_USER_TBL == KEPCO_USER_TBL &&
        other.SSO_ID == SSO_ID;
  }

  @override
  int get hashCode {
    return USER_ID.hashCode ^
        FRST_REG_DT.hashCode ^
        FRST_REGR_EMPNO.hashCode ^
        LST_CHG_DT.hashCode ^
        LST_CHGR_EMPNO.hashCode ^
        SMS_RCVR_TEL_NO.hashCode ^
        POSITION.hashCode ^
        LOC_ID.hashCode ^
        APR_USER_CFM_YN.hashCode ^
        MNGR_AUTH_YN.hashCode ^
        SYS_MNGR_YN.hashCode ^
        KEPCO_USER_TBL.hashCode ^
        SSO_ID.hashCode;
  }
}
