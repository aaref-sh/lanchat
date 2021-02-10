import 'package:flutter/material.dart';
import 'package:flutter_app/screens/fancy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'main_screen.dart';

class Dosplash extends StatefulWidget {
  @override
  _DosplashState createState() => _DosplashState();
}

class _DosplashState extends State<Dosplash> {
  @override
  void initState() {
    _read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: AfterSplash(),
        title: Text(
          'Welcome you little shit',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset("images/ss.png"),
        imageBackground: AssetImage("images/back.jpg"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.red);
  }
}

int val = 0;
_read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'vis';
  val = prefs.getInt(key) ?? 0;
  print('read: $val');
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: "fuhen title", home: val > 0 ? Home() : Fancy());
}
