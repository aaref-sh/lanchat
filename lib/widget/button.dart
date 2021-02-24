import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inputEmail.dart';
import 'password.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/screens/main_screen.dart';

class ButtonLogin extends StatefulWidget {
  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300],
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          onPressed: () {
            checkuser(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OK',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> checkuser(context) async {
  String user, pass;
  user = usernamecontroller.text;
  pass = passwordcontroller.text;
  Map<String, String> lgn = {'name': user, "pass": pass};
  var url = "http://192.168.1.111:80/api/values/signin";
  var body = json.encode(lgn);
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  http.Response response = await http.post(url, body: body, headers: headers);
  var responseJson = json.decode(response.body);
  try {
    int id = int.parse(responseJson.toString());
    if (id > 0) {
      thisUser = id;
      await save(id);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      return;
    }
  } catch (e) {}
  usernamecontroller.clear();
  passwordcontroller.clear();
  wrongalert(context);
  print(responseJson);
}

void wrongalert(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
          title: Text("Wrong Information"),
          content: Text("Your username or password is incorrect"),
        ));

save(int id) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'id';
  final value = id;
  prefs.setInt(key, value);
  print('saved $value');
}
