import 'package:flutter/material.dart';
import 'package:flutter_github_api/entity/basic_auth_param.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              user.login,
            ),
            Text(
              user.email,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: userLogin,
        tooltip: 'login',
        child: Icon(Icons.people),
      ),
    );
  }


  userLogin(){
    Auth auth = Auth('Iv1.ed1fc0b75ccc5db4', '74381a929bbd17d6cc9c965af8bb46b2eb563689');
    Account account = Account('83387856@qq.com', 'hpandlp8187');
    Oauth.login(auth, account).then((user){
      setState(() {
        this.user = user;
      });
    });
  }









}
