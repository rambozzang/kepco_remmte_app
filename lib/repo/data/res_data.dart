// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResData {
  int? result;
  String? value;
  int? iResult;
  String? desc;

  ResData({
    this.result,
    this.value,
    this.iResult,
    this.desc,
  });

  ResData copyWith({
    int? result,
    String? value,
    int? iResult,
    String? desc,
  }) {
    return ResData(
      result: result ?? this.result,
      value: value ?? this.value,
      iResult: iResult ?? this.iResult,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result': result,
      'value': value,
      'iResult': iResult,
      'desc': desc,
    };
  }

  factory ResData.fromMap(Map<String, dynamic> map) {
    return ResData(
      result: map['result'] != null ? map["result"] ?? 0 as int : null,
      value: map['value'] != null ? map["value"] ?? '' as String : null,
      iResult: map['iResult'] != null ? map["iResult"] ?? 0 as int : null,
      desc: map['desc'] != null ? map["desc"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResData.fromJson(String source) =>
      ResData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResData(result: $result, value: $value, iResult: $iResult, desc: $desc)';
  }

  @override
  bool operator ==(covariant ResData other) {
    if (identical(this, other)) return true;

    return other.result == result &&
        other.value == value &&
        other.iResult == iResult &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return result.hashCode ^ value.hashCode ^ iResult.hashCode ^ desc.hashCode;
  }
}
