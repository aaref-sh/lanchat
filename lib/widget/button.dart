import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_client/signalr_client.dart';
import 'inputEmail.dart';
import 'password.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter_app/screens/main_screen.dart';

class ButtonLogin extends StatefulWidget {
  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  final serverurl = "http://192.168.1.111:5000/messagehub";
  HubConnection hubConnection;
  int id;
  @override
  void initState() {
    super.initState();
    initSignalR();
  }

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

  void initSignalR() {
    hubConnection = HubConnectionBuilder().withUrl(serverurl).build();
    hubConnection.onclose((error) => print('connection closed'));
    hubConnection.on("getid", _getid);
    hubConnection.on("setid", _setid);
    hubConnection.start();
  }

  void _getid(List<Object> arguments) {}
  checkuser(context) async {
    String user, pass;
    user = usernamecontroller.text;
    pass = passwordcontroller.text;
    try {
      id = await hubConnection.invoke("login", args: <Object>[user, pass]);
      if (id != null) {
        await save(id);
        thisUser = id;
        hubConnection.stop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
        return;
      }
    } catch (e) {}
    usernamecontroller.clear();
    passwordcontroller.clear();
    wrongalert(context);
  }

  void _setid(List<Object> arguments) {
    id = arguments[0] as int;
  }
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
