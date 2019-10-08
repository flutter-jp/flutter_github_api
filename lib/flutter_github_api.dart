library flutter_github_api;

import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_github_api/entity/github_auth_entity.dart';
import 'package:github/browser.dart';

import 'entity/basic_auth_param.dart';

export 'package:github/server.dart';

final baseURL = 'https://api.github.com';
final user = 'user';

class Oauth {
  /// get github authorization
  static Future<GithubAuthEntity> getAuthorization(
      Auth auth, Account account) async {
    final options = _getOptions(account);
    final client = Dio(options);
    final adapter = client.httpClientAdapter as DefaultHttpClientAdapter;
    adapter.onHttpClientCreate = (client) {
      // 安卓机上面的话自定义证书是不被信任的, 故还需要设置下面这一步:
      client.badCertificateCallback = (cert, host, port) => true;
    };
    Response response = await client.post('/authorizations',
        data: _getBodyJSONString(auth.clientId, auth.clientSecret));
    return GithubAuthEntity.fromJson(response.data);
  }

  /// login
  static Future<User> login(Auth auth, Account account) async {
    GithubAuthEntity entity = await getAuthorization(auth, account);
    final options = _getOptions(account);
    final client = Dio(options);
    Response response = await client.get('$user?access_token=${entity.token}');
    return User.fromJson(response.data);
  }

  static String _getBodyJSONString(String clientId, String clientSecret) {
    final dict = BasicAuthParam(clientId, clientSecret).toDict();
    return json.encode(dict);
  }

  static BaseOptions _getOptions(Account account) {
    final options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
      baseUrl: baseURL,
      headers: _getHeaders(account.email, account.password),
    );
    return options;
  }

  static Map<String, String> _getHeaders(String email, String password) {
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
