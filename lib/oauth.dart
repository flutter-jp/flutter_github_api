library flutter_github_api;

import 'package:github/server.dart';

class Oauth extends Authentication {
  Oauth.basic(String username, String password) : super.basic(username, password);
}
