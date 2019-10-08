library flutter_github_api;

import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_github_api/entity/result.dart';
import 'package:github/server.dart';

import 'entity/basic_auth_param.dart';
import 'entity/github_auth_entity.dart';

export 'package:github/server.dart';

final baseURL = 'https://api.github.com/';
final user = 'user';
final authorizations = 'authorizations';

/// third part login
class GithubOauth {
  Auth auth;

  GithubOauth(Auth auth) {
    this.auth = auth;
  }

  /// exchange token
  Future<OauthResult<String>> getToken(String username, String password) async {
    OauthResult<GithubAuthEntity> result =
        await getAuthorization(username, password);
    if (result.data == null) {
      return OauthResult(code: result.code, message: result.message);
    } else {
      return OauthResult(data: result.data.token);
    }
  }

  /// get github authorization
  Future<OauthResult<GithubAuthEntity>> getAuthorization(
      String username, String password) async {
    final options = _getOptions(username, password);
    final client = Dio(options);
    final adapter = client.httpClientAdapter as DefaultHttpClientAdapter;
    adapter.onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => true;
    };
    Response response;

    try {
      response = await client.post('$authorizations',
          data: _getBodyJSONString(auth.clientId, auth.clientSecret));
      if (response.statusCode == 201) {
        GithubAuthEntity entity = GithubAuthEntity.fromJson(response.data);
        return OauthResult(code: response.statusCode, data: entity);
      } else {
        return OauthResult<GithubAuthEntity>(code: response.statusCode);
      }
    } catch (e) {
      Response response = e.response;
      return OauthResult(
          message: response.statusMessage, code: response.statusCode);
    }
  }

  /// login
  Future<OauthResult<User>> login(String username, String password) async {
    OauthResult result = await getAuthorization(username, password);
    if (result.data == null) {
      return OauthResult<User>(code: result.code, message: result.message);
    }
    final options = _getOptions(username, password);
    final client = Dio(options);
    Response response;
    try {
      response = await client.get('$user?access_token=${result.data.token}');
      if (response.statusCode == 200) {
        User user = User.fromJson(response.data);
        return OauthResult(code: response.statusCode, data: user);
      } else {
        return OauthResult<User>(code: response.statusCode);
      }
    } catch (e) {
      Response response = e.response;
      return OauthResult(
          message: response.statusMessage, code: response.statusCode);
    }
  }

  String _getBodyJSONString(String clientId, String clientSecret) {
    final dict = BasicAuthParam(clientId, clientSecret).toDict();
    return json.encode(dict);
  }

  BaseOptions _getOptions(String username, String password) {
    final options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
      baseUrl: baseURL,
      headers: _getHeaders(username, password),
    );
    return options;
  }

  Map<String, String> _getHeaders(String email, String password) {
    final preStr = '$email:$password';
    final bytes = utf8.encode(preStr);
    final base64Str = base64.encode(bytes);
    final headers = {
      'Accept': 'application/vnd.github.v3+json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic $base64Str',
    };
    return headers;
  }
}
