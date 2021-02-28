import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/chats.dart';
import 'package:flutter_app/models/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/login.page.dart';
import 'package:flutter_app/widget/button.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:signalr_client/signalr_client.dart';
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
Map<int, int> newmessages = {};
Map<int, String> names = {};
int thisUser;
bool b = true;

class Tabber extends StatefulWidget {
  Tabber({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TabberState createState() => _TabberState();
}

// ignore: non_constant_identifier_names
final serverurl = "http://192.168.1.111:5000/messagehub";
HubConnection hubConnection;

class _TabberState extends State<Tabber> with TickerProviderStateMixin {
  MotionTabController _tabController;
  ScrollController _scrollController = ScrollController();
  int val = 0;
  @override
  void initState() {
    //updatemessagelist();
    super.initState();
    initSignalR();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
    setState(() {});
  }

  @override
  void dispose() {
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
          leading: FlatButton(
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              save(0);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
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

  Future<void> initSignalR() async {
    hubConnection = HubConnectionBuilder().withUrl(serverurl).build();
    hubConnection
        .onclose((error) => print('connection closed because of: $error'));
    hubConnection.on("newmessages", _newmessages);
    hubConnection.on("idok", _idok);
    hubConnection.on("getid", _getid);
    await hubConnection.start();
  }

  Future<void> _getid(List<Object> arguments) async =>
      await hubConnection.invoke("confid", args: <Object>[thisUser]);

  void _idok(List<Object> arguments) => print(arguments[0].toString());

  connect() async {
    await hubConnection.start();
    setState(() {});
  }

  Future<void> _newmessages(List<Object> ar) async {
    print(ar.length);
    List<dynamic> l = ar[0];
    for (var msg in l) {
      int sender = msg['sender'];
      msg['date'] = DateTime.parse(msg['date'].toString().replaceAll('T', ' '));
      if (messageList[sender] == null) messageList[sender] = <Message>[];
      Message m = Message.fromMap(msg);
      messageList[sender].add(m);
      if (messageCount[sender] == null) messageCount[sender] = 0;
      messageCount[sender]++;
      if (names[sender] == null) {
        names[sender] =
            await hubConnection.invoke("getidname", args: <Object>[sender]);
        databasehelper.insertuser(User(sender, names[sender]));
      }
      ids.add(sender);
      await databasehelper.insertMsg(Message(sender, m.receiver, m.msg));
      if (newmessages[sender] == null) newmessages[sender] = 0;
      newmessages[sender]++;
      databasehelper.deleteUnreaded(sender);
      databasehelper.insertunreaded(UnReaded(sender, newmessages[sender]));
    }
    setState(() {});
  }

  chatList() {
    int count = ids.length;
    var list = CupertinoScrollbar(
        controller: _scrollController,
        child: ListView.builder(
            controller: _scrollController,
            itemCount: count,
            itemBuilder: (BuildContext context, int i) {
              int id = ids.elementAt(i);
              return ListTile(
                title: Text(names[id].toString()),
                subtitle: Text(lastMessage(id)),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatWith(userId: id))),
                leading: Icon(Icons.person),
                onLongPress: () => deleteConfirmationDialog(id),
                trailing: gettrailng(id),
              );
            }));
    return list;
  }

  updatemessagelist() {
    final Future<Database> dbFuture = databasehelper.initializedatabase();
    dbFuture.then((database) {
      Future<List<Message>> messageListFuture = databasehelper.getMessaeList();
      Future<List<User>> userListFuture = databasehelper.getUserList();
      Future<List<UnReaded>> unreadedListFuture =
          databasehelper.getUnReadedList();
      messageListFuture.then((msglst) {
        messageList = {};
        for (var m in msglst) {
          if (m.sender == thisUser) {
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
      });
      userListFuture.then((usrlst) {
        for (var i in usrlst) names[i.id] = i.name;
        setState(() {});
      });
      unreadedListFuture.then((unreadedlist) {
        for (var i in unreadedlist) newmessages[i.sender] = i.count;
      });
    });
  }

  gettrailng(int id) {
    if (newmessages[id] == null || newmessages[id] == 0)
      return Icon(Icons.arrow_forward);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("${newmessages[id]}"),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue[800],
          width: 1,
        ),
      ),
    );
  }

  String lastMessage(int id) => messageList[id][messageList[id].length - 1].msg;

  Future<void> deleteConfirmationDialog(id) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Delete Confirmation'),
              content: SingleChildScrollView(
                  child: Text('Delete this convirsation?')),
              actions: <Widget>[
                TextButton(
                  child: Text('Delete'),
                  onPressed: () async {
                    await databasehelper.deleteList(id);
                    messageList.removeWhere((key, v) => key == id);
                    messageCount.removeWhere((key, value) => key == id);
                    ids.remove(id);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
