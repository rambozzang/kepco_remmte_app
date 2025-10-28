class BaseUrlConfig {
  // Bio auth 관련 url
  static String authCallUrl = "https://auth.kepco.co.kr:21443";

  // webView root Page
  static String baseWebViewUrlProd = 'https://mics_kepco.co.kr';
  static String apiUrlProd = 'https://mlcs.kepco.co.kr/api/graphql';

  // (개발) 서비스 Graphql API
  static String baseWebViewUrlDev =
      'http://ec2-43-201-106-26.ap-northeast-2.compute.amazonaws.com:3000';
  static String apiUrlDev =
      'http://ec2-43-201-106-26.ap-northeast-2.compute.amazonaws.com:3000/api/graphql';

  // (개발2) 서비스 Graphql API
  // static String baseWebViewUrlDev = 'http://59.5.167.73:3002';
  // static String apiUrlDev = 'http://59.5.167.73:3002/api/graphql';
}
