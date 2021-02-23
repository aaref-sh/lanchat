import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/models/chats.dart';
import 'package:flutter_app/models/databasehelper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tabber(title: 'Motion Tab Bar Sample');
  }
}

Databasehelper databasehelper = Databasehelper();
Map<int, List<Message>> messageList;
Map<int, int> messageCount = {};
Set<int> ids = {};
Map<int, bool> newmessages = {};

class Tabber extends StatefulWidget {
  Tabber({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TabberState createState() => _TabberState();
}

// ignore: non_constant_identifier_names
int this_user = 2;
bool b = true;

class _TabberState extends State<Tabber> with TickerProviderStateMixin {
  MotionTabController _tabController;
  Timer timer;
  int val = 0;
  @override
  void initState() {
    //updatemessagelist();
    super.initState();

    timer = Timer.periodic(
        Duration(milliseconds: 400), (Timer t) => importnewmessages());
    // timer = Timer.periodic(Duration(milliseconds: 300), (Timer t) => print(val++));
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ids.isEmpty && b) {
      updatemessagelist();
      b = false;
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        bottomNavigationBar: MotionTabBar(
          labels: ["Account", "Home", "Dashboard"],
          initialSelectedTab: "Home",
          tabIconColor: Colors.green[900],
          tabSelectedColor: Colors.red[900],
          onTabItemSelected: (int value) {
            print(value);
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [Icons.account_box, Icons.home, Icons.menu],
          textStyle: TextStyle(color: Colors.red[900]),
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: Center(
                child: Text("Account"),
              ),
            ),
            Container(child: chatList()),
            Container(
              child: Center(
                child: Text("Dashboard"),
              ),
            ),
          ],
        ));
  }

  chatList() {
    int count = ids.length;
    var list = ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text(ids.elementAt(i).toString()),
            subtitle: Text("chat with ${ids.elementAt(i)}"),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatWith(userId: ids.elementAt(i)))),
            leading: Icon(Icons.person),
            onLongPress: () async {
              await deletechat(ids.elementAt(i));
            },
          );
        });
    return list;
  }

  void importnewmessages() async {
    Map<String, String> imp = {"receiver": "$this_user"};
    var url = "http://192.168.1.111:80/api/values/gets";
    var body = json.encode(imp);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    int old = messageList.length;
    http.Response response = await http.post(url, body: body, headers: headers);
    List<dynamic> responseJson = json.decode(response.body);
    Message ms;
    String msg, dat;
    int sender;
    if (responseJson != null) {
      for (int i = 0; i < responseJson.length; i++) {
        msg = responseJson[i]["msg"];
        sender = responseJson[i]["sender"];
        ms = Message(sender, this_user, msg);
        ms.id = await databasehelper.insertMsg(ms);
        dat = responseJson[i]["date"].toString().replaceAll('T', ' ');
        ms.date = DateTime.parse(dat);
        if (messageList[ms.sender] == null)
          messageList[ms.sender] = <Message>[];
        messageList[ms.sender].add(ms);
        if (messageCount[ms.sender] == null) messageCount[ms.sender] = 0;
        messageCount[ms.sender]++;
        ids.add(ms.sender);
        newmessages[ms.sender] = true;
      }
      setState(() {});
    }
    print(responseJson);
  }

  updatemessagelist() {
    final Future<Database> dbFuture = databasehelper.initializedatabase();
    dbFuture.then((database) {
      Future<List<Message>> messageListFuture = databasehelper.getMessaeList();
      messageListFuture.then((msglst) {
        messageList = {};
        for (int i = 0; i < msglst.length; i++) {
          Message m = msglst[i];
          if (m.sender == this_user) {
            ids.add(m.receiver);
            if (messageList[m.receiver] == null)
              messageList[m.receiver] = <Message>[];
            messageList[m.receiver].add(m);
            if (messageCount[m.receiver] == null) messageCount[m.receiver] = 0;
            messageCount[m.receiver]++;
          } else {
            ids.add(m.sender);
            if (messageList[m.sender] == null)
              messageList[m.sender] = <Message>[];
            messageList[m.sender].add(m);
            if (messageCount[m.sender] == null) messageCount[m.sender] = 0;
            messageCount[m.sender]++;
          }
        }
        setState(() {});
      });
    });
  }

  deletechat(int id) async {
    messageList.removeWhere((key, v) => key == id);
    messageCount.removeWhere((key, value) => key == id);
    ids.remove(id);
    setState(() {});
  }
}
