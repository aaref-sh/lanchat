import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

TextEditingController passwordcontroller;

class _PasswordInputState extends State<PasswordInput> {
  @override
  void initState() {
    super.initState();
    passwordcontroller = new TextEditingController()..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: passwordcontroller,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
