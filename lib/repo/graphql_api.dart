import 'dart:convert';

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

class GraphqlApi {
  Future<ResLoginData> loginProc(String apiURL, String userid, String password) async {
    debugPrint("==========================");
    debugPrint("loginProc() :  $apiURL");
    debugPrint("==========================");

    late Map<String, Object> jsondata;
    if (password == "" || password.isEmpty) {
      jsondata = {"empno": userid, "password": ""};
    } else {
      jsondata = {"empno": userid, "password": password};
    }

    QueryResult result = await GraphQLClient(
      link: HttpLink(apiURL),
      cache: GraphQLCache(store: InMemoryStore(), partialDataPolicy: PartialDataCachePolicy.accept),
    ).mutate(MutationOptions(
      document: transform(
        parseString(ResLoginGraphqlData.resLoginData),
        [],
      ),
      variables: jsondata,
      update: (cache, result) {
        if (result!.hasException) {
          //   debugPrint("update: ${result.exception}");
        }
      },
      onCompleted: (dynamic result) {
        debugPrint("onCompleted: ${result.toString()}");
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

  Future<ResAdduserData> addUserProc(String apiURL, ReqAdduserData reqAdduserData) async {
    QueryResult result = await GraphQLClient(
      link: HttpLink(apiURL),
      cache: GraphQLCache(store: InMemoryStore(), partialDataPolicy: PartialDataCachePolicy.accept),
    ).mutate(MutationOptions(
      document: transform(
        parseString(ResAdduserGraphqlData.addUserDataQuery),
        [],
      ),
      variables: reqAdduserData.toMap(),
      update: (cache, result) {
        if (result!.hasException) {
          print("update: ${result.exception}");
        }
      },
      onCompleted: (dynamic result) {
        if (result != null) {
          debugPrint("addUserProc().result  : $result");
          return ResAdduserData.fromMap(result['addUserRequest'] as Map<String, dynamic>);
        }
      },
      onError: (e) {
        print("error = $e");
      },
    ));
    debugPrint("result1 : ${result.data!['addUserRequest']}");
    return ResAdduserData.fromMap(result.data!['addUserRequest']);
  }

  Future<ResGettokenData> getToken(String apiURL, String userid) async {
    QueryResult result = await GraphQLClient(
      link: HttpLink(apiURL),
      cache: GraphQLCache(store: InMemoryStore(), partialDataPolicy: PartialDataCachePolicy.accept),
    ).query(QueryOptions(
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
