import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'password.dart';
import 'newName.dart';

class ButtonNewUser extends StatefulWidget {
  @override
  _ButtonNewUserState createState() => _ButtonNewUserState();
}

class _ButtonNewUserState extends State<ButtonNewUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.blue[300],
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              5.0, // horizontal, move right 10
              5.0, // vertical, move down 10
            ),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: FlatButton(
          onPressed: () {
            createuser(context);
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

Future<void> createuser(BuildContext context) async {
  String user, pass;
  user = newusernamecontroller.text;
  pass = passwordcontroller.text;
  if (pass.isEmpty || pass.length < 5 || user.isEmpty || user.length < 5) {
    wrongalert(context, true);
    return;
  }
  Map<String, String> lgn = {'name': user, "pass": pass};
  var url = "http://192.168.1.111:80/api/values/signup";
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
      await save(id);
      thisUser = id;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      return;
    }
  } catch (e) {}
  newusernamecontroller.clear();
  passwordcontroller.clear();
  wrongalert(context, false);
  print(responseJson);
}

void wrongalert(BuildContext context, bool x) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
          title: Text(x
              ? "Good username and password are reqiered"
              : "This username is unavilable"),
          content: Text(x
              ? "Please enter 5 latter at least as a username and a password"
              : "Please enter another username"),
        ));

save(int id) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'id';
  prefs.setInt(key, id);
  print('saved $id');
}
