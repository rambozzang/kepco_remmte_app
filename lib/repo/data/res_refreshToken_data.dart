// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResRefreshTokenData {
  String? ciphertext;
  String? nonce;
  String? tag;
  ResRefreshTokenData({
    this.ciphertext,
    this.nonce,
    this.tag,
  });

  ResRefreshTokenData copyWith({
    String? ciphertext,
    String? nonce,
    String? tag,
  }) {
    return ResRefreshTokenData(
      ciphertext: ciphertext ?? this.ciphertext,
      nonce: nonce ?? this.nonce,
      tag: tag ?? this.tag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ciphertext': ciphertext,
      'nonce': nonce,
      'tag': tag,
    };
  }

  factory ResRefreshTokenData.fromMap(Map<String, dynamic> map) {
    return ResRefreshTokenData(
      ciphertext:
          map['ciphertext'] != null ? map["ciphertext"] ?? '' as String : null,
      nonce: map['nonce'] != null ? map["nonce"] ?? '' as String : null,
      tag: map['tag'] != null ? map["tag"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResRefreshTokenData.fromJson(String source) =>
      ResRefreshTokenData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ResRefreshTokenData(ciphertext: $ciphertext, nonce: $nonce, tag: $tag)';

  @override
  bool operator ==(covariant ResRefreshTokenData other) {
    if (identical(this, other)) return true;

    return other.ciphertext == ciphertext &&
        other.nonce == nonce &&
        other.tag == tag;
  }

  @override
  int get hashCode => ciphertext.hashCode ^ nonce.hashCode ^ tag.hashCode;
}
