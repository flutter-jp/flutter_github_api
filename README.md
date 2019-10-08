# flutter github api
flutter github v3 api library based on github.dart
[![Pub](https://img.shields.io/pub/v/flutter_github_api.svg)](https://pub.dartlang.org/packages/flutter_github_api)

# api extension
- get authorization
- third part login
- get token

# getting start
```yaml
dependencies:
  github: ^0.2.0
```


# usage
1. get token 

```dart
    import 'package:flutter_github_api/flutter_github_api.dart';
    import 'package:flutter_github_api/entity/result.dart';
    User user;

    login(String username,String password){
    	// how to get clientId and clientSecret please visit https://github.com/settings/apps/new
        Auth auth = Auth('your clientId', 'your clientSecret');
        GithubOauth oauth = GithubOauth(auth);
        oauth.login(username,password).then((result){
        	if(result.data == null){
        		// 1. this means your clientId or clientSecret is error
        		// 2. this means your username or password is error
        		// 3. detail information please see result.code and result.message
        	} else {
        		setState((){
        		  this.user = result.data;
        		});
        	}
        });
    }
```



2. get token

```dart
  import 'package:flutter_github_api/flutter_github_api.dart';
  import 'package:flutter_github_api/entity/result.dart';
  
    String token='';
    getToken(String username,String password){
	    GithubOauth oauth = GithubOauth(auth);
	    oauth.login(username,password).then((result){
            if(result.data == null){
                // 1. this means your clientId or clientSecret is error
                // 2. this means your username or password is error
                // 3. detail information please see result.code and result.message
            } else {
                setState((){
                  this.token = result.data;
                });
            }
        });
    }
```

# image
![](image/demo.png)


# detail 
please visit [github.dart](https://github.com/SpinlockLabs/github.dart)