import 'package:flutter/material.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_app/widget/button.dart';
import 'package:flutter_app/widget/first.dart';
import 'package:flutter_app/widget/inputEmail.dart';
import 'package:flutter_app/widget/password.dart';
import 'package:flutter_app/widget/textLogin.dart';
import 'package:flutter_app/widget/verticalText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  @override
  Widget build(context) {
    return FutureBuilder<dynamic>(
        future: read(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (val == 0) {
            return LoginPage();
          } else {
            this_user = val;
            return Home();
          }
        });
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

int val = 0;
read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'id';
  val = prefs.getInt(key) ?? 0;
  print('read: $val');
}
