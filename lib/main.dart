import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/fancy.dart';
import 'package:flutter_app/screens/login.page.dart';
import 'package:flutter_app/screens/main_screen.dart';

void main() {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ]);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    print(isAllowed);
    if (!isAllowed) {
      print(isAllowed);
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  runApp(MaterialApp(
    title: 'this app',
    initialRoute: '/',
    routes: {
      "/": (context) => Login(),
      "/chat": (context) => ChatWith(),
      "/fancy": (context) => Fancy(),
      "/home": (context) => Home(),
    },
  ));
}
