import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';

final pageList = [
  PageModel(
      color: const Color(0xFF678FB4),
      heroImagePath: 'images/ss.png',
      title: Text('Hotels',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All hotels and hostels are sorted by hospitality rating',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconImagePath: 'images/ss.png'),
  // SVG Pages Example
  PageModel(
    color: const Color(0xFF9B90BC),
    heroImagePath: 'images/dd.svg',
    title: Text('Store SVG',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        )),
    body: Text('All local stores are categorized for your convenience',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        )),
    iconImagePath: 'images/dd.svg',
  ),
];

class Fancy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _save();
    return Scaffold(
      body: FancyOnBoarding(
          doneButtonText: "Done",
          skipButtonText: "Skip",
          pageList: pageList,
          onDoneButtonPressed: () => Navigator.pushReplacement(
              context, new MaterialPageRoute(builder: (context) => Home())),
          onSkipButtonPressed: () => Navigator.pushReplacement(
              context, new MaterialPageRoute(builder: (context) => Home()))),
    );
  }
}

_save() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('vis', 1);
}
