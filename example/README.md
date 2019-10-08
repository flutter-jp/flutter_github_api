# example

A Third Part Github Login Flutter application Example.

## Getting Started
detail information please see [example/lib/main.dart](lib/main.dart)

```dart
  User user;
  String username;
  String password;
  userLogin() {
    if (username.isEmpty || password.isEmpty) {
      return;
    }
    oauth.login(username, password).then((OauthResult<User> result) {
      if (result.data != null) {
        setState(() {
          this.user = result.data;
        });
      } else {
        print(result.code.toString() + ':' + result.message.toString() ?? '');
      }
    });
  }
```
