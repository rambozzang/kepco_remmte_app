class ResGettokenGraphqlData {
  static const String getToken = r"""
        query Query($userid: String!) {
        getToken(userid: $userid) {
          accessToken {
            ciphertext
            nonce
            tag
          }
          error
          ok
          refreshToken {
            ciphertext
            nonce
            tag
          }
        }
      }
      """;
}
