// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResAccessTokenData {
  String? ciphertext;
  String? nonce;
  String? tag;
  ResAccessTokenData({
    this.ciphertext,
    this.nonce,
    this.tag,
  });

  ResAccessTokenData copyWith({
    String? ciphertext,
    String? nonce,
    String? tag,
  }) {
    return ResAccessTokenData(
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

  factory ResAccessTokenData.fromMap(Map<String, dynamic> map) {
    return ResAccessTokenData(
      ciphertext:
          map['ciphertext'] != null ? map["ciphertext"] ?? '' as String : null,
      nonce: map['nonce'] != null ? map["nonce"] ?? '' as String : null,
      tag: map['tag'] != null ? map["tag"] ?? '' as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResAccessTokenData.fromJson(String source) =>
      ResAccessTokenData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ResAccessTokenData(ciphertext: $ciphertext, nonce: $nonce, tag: $tag)';

  @override
  bool operator ==(covariant ResAccessTokenData other) {
    if (identical(this, other)) return true;

    return other.ciphertext == ciphertext &&
        other.nonce == nonce &&
        other.tag == tag;
  }

  @override
  int get hashCode => ciphertext.hashCode ^ nonce.hashCode ^ tag.hashCode;
}
