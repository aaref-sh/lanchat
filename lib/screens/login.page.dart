import 'package:flutter/material.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_app/widget/button.dart';
import 'package:flutter_app/widget/first.dart';
import 'package:flutter_app/widget/inputEmail.dart';
import 'package:flutter_app/widget/password.dart';
import 'package:flutter_app/widget/textLogin.dart';
import 'package:flutter_app/widget/verticalText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

int val;

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(context) {
    if (val == null) return Center(child: CircularProgressIndicator());
    if (val == 0) return LoginPage();
    return Home();
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    val = prefs.getInt(key) ?? 0;
    print('read: $val');
    thisUser = val;
    setState(() {});
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                InputEmail(),
                PasswordInput(),
                ButtonLogin(),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
