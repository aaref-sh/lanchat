import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/fancy.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_app/screens/splashscreen.dart';

void main() => runApp(MaterialApp(
      title: 'this app',
      initialRoute: '/',
      routes: {
        "/": (context) => Dosplash(),
        "/home": (context) => Home(),
        "/chat": (context) => ChatWith(),
        "/fancy": (context) => Fancy(),
      },
    ));
