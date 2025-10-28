import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gql/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lamp_remote_app/config/base_url_config.dart';
import 'package:lamp_remote_app/repo/data/addUser/req_adduser_data.dart';
import 'package:lamp_remote_app/repo/data/addUser/res_adduser_data.dart';
import 'package:lamp_remote_app/repo/data/addUser/res_adduser_graphql_data.dart';
import 'package:lamp_remote_app/repo/data/res_gettoken_data.dart';
import 'package:lamp_remote_app/repo/data/res_gettoken_graphql_data.dart';
import 'package:lamp_remote_app/repo/data/login/res_login_data.dart';
import 'package:lamp_remote_app/repo/data/login/res_login_graphql_data.dart';
import 'package:gql/language.dart';

class GraphqlRepo {
  static final String apiURL = BaseUrlConfig.apiUrlDev;

  static const storage = FlutterSecureStorage();

  static final HttpLink _httpLink = HttpLink(apiURL);

  static final AuthLink _authLink = AuthLink(getToken: () async {
    String? secureUserId = await storage.read(key: "userID");
    return secureUserId;
  });

  static final Link link = _authLink.concat(_httpLink);

  static var graphQLClient = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(
        store: InMemoryStore(),
        partialDataPolicy: PartialDataCachePolicy.accept),
  );

  static ValueNotifier<GraphQLClient> initializeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(graphQLClient);
    return client;
  }

  static Future<ResLoginData> loginProc(String userid, String password) async {
    Map<String, Object> jsondata;

    if (password == "" || password.isEmpty) {
      jsondata = {"empno": userid, "password": ""};
    } else {
      jsondata = {"empno": userid, "password": password};
    }

    QueryResult result = await graphQLClient.mutate(MutationOptions(
      document: transform(
        parseString(ResLoginGraphqlData.resLoginData),
        [],
      ),
      variables: jsondata,
      update: (cache, result) {
        if (result!.hasException) {
          debugPrint("update: ${result.exception}");
        }
      },
      onCompleted: (dynamic result) {
        if (result != null) {
          return ResLoginData.fromMap(result['login'] as Map<String, dynamic>);
        }
      },
      onError: (e) {
        debugPrint("error = $e");
      },
    ));

    debugPrint("result1 : ${result.data!['login']}");
    return ResLoginData.fromMap(result.data!['login']);
  }

  static Future<ResAdduserData> addUserProc(
      ReqAdduserData reqAdduserData) async {
    QueryResult result = await graphQLClient.mutate(MutationOptions(
      document: transform(
        parseString(ResAdduserGraphqlData.addUserDataQuery),
        [],
      ),
      variables: reqAdduserData.toMap(),
      update: (cache, result) {
        if (result!.hasException) {
          debugPrint("update: ${result.exception}");
        }
      },
      onCompleted: (dynamic result) {
        if (result != null) {
          debugPrint("addUserProc().result  : $result");
          return ResAdduserData.fromMap(
              result['addUserRequest'] as Map<String, dynamic>);
        }
      },
      onError: (e) {
        print("error = $e");
      },
    ));
    debugPrint("result1 : ${result.data!['addUserRequest']}");
    return ResAdduserData.fromMap(result.data!['addUserRequest']);
  }

  static Future<ResGettokenData> getToken(String userid) async {
    QueryResult result = await graphQLClient.query(QueryOptions(
        document: transform(
          parseString(ResGettokenGraphqlData.getToken),
          [],
        ),
        variables: {"userid": "$userid"}));

    debugPrint("getToken().result 1: $result");
    debugPrint("getToken().result 2: ${result.data!['getToken']}");
    return ResGettokenData.fromMap(result.data!['getToken']);
  }
}
