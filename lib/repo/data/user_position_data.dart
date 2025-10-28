// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserPositionData {
  String? LOC_ID;
  String? FRST_REG_DT;
  String? FRST_REGR_EMPNO;
  String? LST_CHG_DT;
  String? LST_CHGR_EMPNO;
  int? FLOR_CNT;
  String? LOC_CL_NM;
  UserPositionData({
    this.LOC_ID,
    this.FRST_REG_DT,
    this.FRST_REGR_EMPNO,
    this.LST_CHG_DT,
    this.LST_CHGR_EMPNO,
    this.FLOR_CNT,
    this.LOC_CL_NM,
  });

  UserPositionData copyWith({
    String? LOC_ID,
    String? FRST_REG_DT,
    String? FRST_REGR_EMPNO,
    String? LST_CHG_DT,
    String? LST_CHGR_EMPNO,
    int? FLOR_CNT,
    String? LOC_CL_NM,
  }) {
    return UserPositionData(
      LOC_ID: LOC_ID ?? this.LOC_ID,
      FRST_REG_DT: FRST_REG_DT ?? this.FRST_REG_DT,
      FRST_REGR_EMPNO: FRST_REGR_EMPNO ?? this.FRST_REGR_EMPNO,
      LST_CHG_DT: LST_CHG_DT ?? this.LST_CHG_DT,
      LST_CHGR_EMPNO: LST_CHGR_EMPNO ?? this.LST_CHGR_EMPNO,
      FLOR_CNT: FLOR_CNT ?? this.FLOR_CNT,
      LOC_CL_NM: LOC_CL_NM ?? this.LOC_CL_NM,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'LOC_ID': LOC_ID,
      'FRST_REG_DT': FRST_REG_DT,
      'FRST_REGR_EMPNO': FRST_REGR_EMPNO,
      'LST_CHG_DT': LST_CHG_DT,
      'LST_CHGR_EMPNO': LST_CHGR_EMPNO,
      'FLOR_CNT': FLOR_CNT,
      'LOC_CL_NM': LOC_CL_NM,
    };
  }

  factory UserPositionData.fromMap(Map<String, dynamic> map) {
    return UserPositionData(
      LOC_ID: map['LOC_ID'] != null ? map["LOC_ID"] ?? '' as String : null,
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
      FLOR_CNT: map['FLOR_CNT'] != null ? map["FLOR_CNT"] ?? 0 as int : null,
      LOC_CL_NM:
          map['LOC_CL_NM'] != null ? map["LOC_CL_NM"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPositionData.fromJson(String source) =>
      UserPositionData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserPositionData(LOC_ID: $LOC_ID, FRST_REG_DT: $FRST_REG_DT, FRST_REGR_EMPNO: $FRST_REGR_EMPNO, LST_CHG_DT: $LST_CHG_DT, LST_CHGR_EMPNO: $LST_CHGR_EMPNO, FLOR_CNT: $FLOR_CNT, LOC_CL_NM: $LOC_CL_NM)';
  }

  @override
  bool operator ==(covariant UserPositionData other) {
    if (identical(this, other)) return true;

    return other.LOC_ID == LOC_ID &&
        other.FRST_REG_DT == FRST_REG_DT &&
        other.FRST_REGR_EMPNO == FRST_REGR_EMPNO &&
        other.LST_CHG_DT == LST_CHG_DT &&
        other.LST_CHGR_EMPNO == LST_CHGR_EMPNO &&
        other.FLOR_CNT == FLOR_CNT &&
        other.LOC_CL_NM == LOC_CL_NM;
  }

  @override
  int get hashCode {
    return LOC_ID.hashCode ^
        FRST_REG_DT.hashCode ^
        FRST_REGR_EMPNO.hashCode ^
        LST_CHG_DT.hashCode ^
        LST_CHGR_EMPNO.hashCode ^
        FLOR_CNT.hashCode ^
        LOC_CL_NM.hashCode;
  }
}
