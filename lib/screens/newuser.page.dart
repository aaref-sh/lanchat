import 'package:flutter/material.dart';
import 'package:flutter_app/widget/buttonNewUser.dart';
import 'package:flutter_app/widget/newEmail.dart';
import 'package:flutter_app/widget/newName.dart';
import 'package:flutter_app/widget/password.dart';
import 'package:flutter_app/widget/singup.dart';
import 'package:flutter_app/widget/textNew.dart';
import 'package:flutter_app/widget/userOld.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
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
                Row(
                  children: <Widget>[
                    SingUp(),
                    TextNew(),
                  ],
                ),
                NewNome(),
                PasswordInput(),
                ButtonNewUser(),
                UserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
