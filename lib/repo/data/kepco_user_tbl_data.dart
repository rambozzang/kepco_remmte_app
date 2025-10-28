// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class KepcoUserTblData {
  String? SSO_ID;
  String? FRST_REG_DT;
  String? FRST_REGR_EMPNO;
  String? LST_CHG_DT;
  String? LST_CHGR_EMPNO;
  String? SSO_USER_NM;
  String? SSO_EMPNO;
  String? MAIN_EMAIL_ADDR;
  String? SSO_CERT_KEY;
  String? DEPT_NM;
  KepcoUserTblData({
    this.SSO_ID,
    this.FRST_REG_DT,
    this.FRST_REGR_EMPNO,
    this.LST_CHG_DT,
    this.LST_CHGR_EMPNO,
    this.SSO_USER_NM,
    this.SSO_EMPNO,
    this.MAIN_EMAIL_ADDR,
    this.SSO_CERT_KEY,
    this.DEPT_NM,
  });

  KepcoUserTblData copyWith({
    String? SSO_ID,
    String? FRST_REG_DT,
    String? FRST_REGR_EMPNO,
    String? LST_CHG_DT,
    String? LST_CHGR_EMPNO,
    String? SSO_USER_NM,
    String? SSO_EMPNO,
    String? MAIN_EMAIL_ADDR,
    String? SSO_CERT_KEY,
    String? DEPT_NM,
  }) {
    return KepcoUserTblData(
      SSO_ID: SSO_ID ?? this.SSO_ID,
      FRST_REG_DT: FRST_REG_DT ?? this.FRST_REG_DT,
      FRST_REGR_EMPNO: FRST_REGR_EMPNO ?? this.FRST_REGR_EMPNO,
      LST_CHG_DT: LST_CHG_DT ?? this.LST_CHG_DT,
      LST_CHGR_EMPNO: LST_CHGR_EMPNO ?? this.LST_CHGR_EMPNO,
      SSO_USER_NM: SSO_USER_NM ?? this.SSO_USER_NM,
      SSO_EMPNO: SSO_EMPNO ?? this.SSO_EMPNO,
      MAIN_EMAIL_ADDR: MAIN_EMAIL_ADDR ?? this.MAIN_EMAIL_ADDR,
      SSO_CERT_KEY: SSO_CERT_KEY ?? this.SSO_CERT_KEY,
      DEPT_NM: DEPT_NM ?? this.DEPT_NM,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'SSO_ID': SSO_ID,
      'FRST_REG_DT': FRST_REG_DT,
      'FRST_REGR_EMPNO': FRST_REGR_EMPNO,
      'LST_CHG_DT': LST_CHG_DT,
      'LST_CHGR_EMPNO': LST_CHGR_EMPNO,
      'SSO_USER_NM': SSO_USER_NM,
      'SSO_EMPNO': SSO_EMPNO,
      'MAIN_EMAIL_ADDR': MAIN_EMAIL_ADDR,
      'SSO_CERT_KEY': SSO_CERT_KEY,
      'DEPT_NM': DEPT_NM,
    };
  }

  factory KepcoUserTblData.fromMap(Map<String, dynamic> map) {
    return KepcoUserTblData(
      SSO_ID: map['SSO_ID'] != null ? map["SSO_ID"] ?? '' as String : null,
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
      SSO_USER_NM: map['SSO_USER_NM'] != null
          ? map["SSO_USER_NM"] ?? '' as String
          : null,
      SSO_EMPNO:
          map['SSO_EMPNO'] != null ? map["SSO_EMPNO"] ?? '' as String : null,
      MAIN_EMAIL_ADDR: map['MAIN_EMAIL_ADDR'] != null
          ? map["MAIN_EMAIL_ADDR"] ?? '' as String
          : null,
      SSO_CERT_KEY: map['SSO_CERT_KEY'] != null
          ? map["SSO_CERT_KEY"] ?? '' as String
          : null,
      DEPT_NM: map['DEPT_NM'] != null ? map["DEPT_NM"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KepcoUserTblData.fromJson(String source) =>
      KepcoUserTblData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'KepcoUserTblData(SSO_ID: $SSO_ID, FRST_REG_DT: $FRST_REG_DT, FRST_REGR_EMPNO: $FRST_REGR_EMPNO, LST_CHG_DT: $LST_CHG_DT, LST_CHGR_EMPNO: $LST_CHGR_EMPNO, SSO_USER_NM: $SSO_USER_NM, SSO_EMPNO: $SSO_EMPNO, MAIN_EMAIL_ADDR: $MAIN_EMAIL_ADDR, SSO_CERT_KEY: $SSO_CERT_KEY, DEPT_NM: $DEPT_NM)';
  }

  @override
  bool operator ==(covariant KepcoUserTblData other) {
    if (identical(this, other)) return true;

    return other.SSO_ID == SSO_ID &&
        other.FRST_REG_DT == FRST_REG_DT &&
        other.FRST_REGR_EMPNO == FRST_REGR_EMPNO &&
        other.LST_CHG_DT == LST_CHG_DT &&
        other.LST_CHGR_EMPNO == LST_CHGR_EMPNO &&
        other.SSO_USER_NM == SSO_USER_NM &&
        other.SSO_EMPNO == SSO_EMPNO &&
        other.MAIN_EMAIL_ADDR == MAIN_EMAIL_ADDR &&
        other.SSO_CERT_KEY == SSO_CERT_KEY &&
        other.DEPT_NM == DEPT_NM;
  }

  @override
  int get hashCode {
    return SSO_ID.hashCode ^
        FRST_REG_DT.hashCode ^
        FRST_REGR_EMPNO.hashCode ^
        LST_CHG_DT.hashCode ^
        LST_CHGR_EMPNO.hashCode ^
        SSO_USER_NM.hashCode ^
        SSO_EMPNO.hashCode ^
        MAIN_EMAIL_ADDR.hashCode ^
        SSO_CERT_KEY.hashCode ^
        DEPT_NM.hashCode;
  }
}
