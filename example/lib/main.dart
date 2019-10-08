import 'package:flutter/material.dart';
import 'package:flutter_github_api/entity/basic_auth_param.dart';
import 'package:flutter_github_api/entity/oauth_result.dart';
import 'package:flutter_github_api/flutter_github_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'flutter github login demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User user;
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GithubOauth oauth;

  String username = '';
  String password = '';

  _MyHomePageState() {
    /// todo input your info and start the app
    Auth auth = Auth('your clientId', 'your clientSectrt');
    this.oauth = GithubOauth(auth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: buildInputs() + buildSubmitButtons(),
          ),
        ));
  }

  // 构建输入框
  List<Widget> buildInputs() {
    return <Widget>[
      SizedBox(
        height: 80,
      ),
      TextFormField(
        key: Key('email'),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onSaved: (String value) {
          username = value;
        },
      ),
      SizedBox(
        height: 30,
      ),
      TextFormField(
        key: Key('password'),
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onSaved: (String value) {
          password = value;
        },
      ),
      SizedBox(
        height: 20,
      ),
    ];
  }

  /// 构建提交按钮
  List<Widget> buildSubmitButtons() {
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 20),
      ),
      RaisedButton(
        padding: EdgeInsets.all(5),
        color: Theme.of(context).primaryColor,
        key: Key('signIn'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child:
            Text('Login', style: TextStyle(fontSize: 20, color: Colors.white)),
        onPressed: userLogin,
      )
    ];
  }

  userLogin() {
    final FormState state = formKey.currentState;
    state.save();
    if (username.isEmpty || password.isEmpty) {
      key.currentState.showSnackBar(SnackBar(
        content: Text('please '
            'input your username and password'),
      ));
      GitHub github = createGitHubClient(auth: Authentication.withToken(''));
      RepositorySlug slug = RepositorySlug("flutter_jp", "flutter_github_api");
      IssueRequest issue = IssueRequest();
      github.issues.create(slug, issue);

      return;
    }
    oauth.login(username, password).then((OauthResult<User> result) {
      if (result.data != null) {
        setState(() {
          this.user = result.data;
          showDialog(
              context: context,
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      user.avatarUrl,
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      user.login,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      user.email ?? '',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )
                  ],
                );
              });
        });
      } else {
        key.currentState.showSnackBar(SnackBar(
          content: Text(
              result.code.toString() + ':' + result.message.toString() ?? ''),
        ));
      }
    });
  }
}
