// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReqAdduserData {
  String? phoneno;
  String? empno;
  int? floor;
  String? direction;
  ReqAdduserData({
    this.phoneno,
    this.empno,
    this.floor,
    this.direction,
  });

  ReqAdduserData copyWith({
    String? phoneno,
    String? empno,
    int? floor,
    String? direction,
  }) {
    return ReqAdduserData(
      phoneno: phoneno ?? this.phoneno,
      empno: empno ?? this.empno,
      floor: floor ?? this.floor,
      direction: direction ?? this.direction,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneno': phoneno,
      'empno': empno,
      'floor': floor,
      'direction': direction,
    };
  }

  factory ReqAdduserData.fromMap(Map<String, dynamic> map) {
    return ReqAdduserData(
      phoneno: map['phoneno'] != null ? map["phoneno"] ?? '' as String : null,
      empno: map['empno'] != null ? map["empno"] ?? '' as String : null,
      floor: map['floor'] != null ? map["floor"] ?? 0 as int : null,
      direction:
          map['direction'] != null ? map["direction"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqAdduserData.fromJson(String source) =>
      ReqAdduserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReqAdduserData(phoneno: $phoneno, empno: $empno, floor: $floor, direction: $direction)';
  }

  @override
  bool operator ==(covariant ReqAdduserData other) {
    if (identical(this, other)) return true;

    return other.phoneno == phoneno &&
        other.empno == empno &&
        other.floor == floor &&
        other.direction == direction;
  }

  @override
  int get hashCode {
    return phoneno.hashCode ^
        empno.hashCode ^
        floor.hashCode ^
        direction.hashCode;
  }
}
