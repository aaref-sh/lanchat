import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tabber(title: 'Motion Tab Bar Sample');
  }
}

Databasehelper databasehelper = Databasehelper();
List<User> onlineuserslist = <User>[];
Map<int, List<Message>> messageList = {};
Map<int, int> messageCount = {};
Set<int> ids = {};
Map<int, int> newmessages = {};
Map<int, String> names = {};
int thisUser;
bool loading = true;

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
  ScrollController _scrollControlleronlineusers = ScrollController();
  int val = 0;
  Timer timer;
  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
    setState(() {});

    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      // connect();
      setState(() {});
    });
    var dbFuture = databasehelper.initializedatabase();
    dbFuture.then((database) {
      updatemessagelist();
      initSignalR();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          tabIconColor: Colors.blue[500],
          tabSelectedColor: Colors.blue[400],
          onTabItemSelected: (int value) {
            print(value);
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [Icons.account_box, Icons.home, Icons.menu],
          textStyle: TextStyle(color: Colors.blue[500]),
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: Center(
                child: Text("Account"),
              ),
            ),
            getHomeContainer(),
            getOnlineUsers(),
          ],
        ));
  }

  Widget getHomeContainer() {
    if (ids.isEmpty) {
      if (loading) return Center(child: CircularProgressIndicator());

      return Center(
        child: Text(
          "No messages yet",
        ),
      );
    }
    return Container(child: chatList());
  }

  initSignalR() async {
    hubConnection = HubConnectionBuilder().withUrl(serverurl).build();
    hubConnection
        .onclose((error) => print('connection closed because of: $error'));
    hubConnection.on("newmessages", _newmessages);
    hubConnection.on("getid", _getid);
    hubConnection.on("getonlineusers", _getonlineusers);
    try {
      await hubConnection.start();
    } catch (_) {}
    //connect();
  }

  _getid(List<Object> arguments) async {
    //connect();
    await hubConnection.invoke("confid", args: <Object>[thisUser]);
    await sendpendingmessages();
  }

  Future<void> _newmessages(List<Object> ar) async {
    print(ar.length);
    List<dynamic> l = ar[0];
    for (var msg in l) {
      int sender = msg['sender'];

      ids.add(sender);
      Message m = Message.fromMap(msg);

      m.id = await databasehelper.insertMsg(Message(sender, m.receiver, m.msg));
      msg['date'] = DateTime.parse(msg['date'].toString().replaceAll('T', ' '));

      if (messageList[sender] == null) messageList[sender] = <Message>[];
      messageList[sender].add(m);
      if (messageCount[sender] == null) messageCount[sender] = 0;
      messageCount[sender]++;
      if (names[sender] == null) {
        names[sender] =
            await hubConnection.invoke("getidname", args: <Object>[sender]);
        databasehelper.insertuser(User(sender, names[sender]));
      }
      if (newmessages[sender] == null) newmessages[sender] = 0;
      newmessages[sender]++;
      await databasehelper.deleteUnreaded(sender);
      await databasehelper
          .insertunreaded(UnReaded(sender, newmessages[sender]));

      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: msg['id'],
              channelKey: 'grouped',
              title: names[sender],
              summary: newmessages[otherUser].toString(),
              body: msg['msg']));
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

  updatemessagelist() async {
    List<Message> msglst = await databasehelper.getMessaeList();
    List<User> usrlst = await databasehelper.getUserList();
    List<UnReaded> unreadedlst = await databasehelper.getUnReadedList();

    for (var m in msglst) {
      if (m.sender == thisUser) {
        newmessages[m.receiver] = 0;
        ids.add(m.receiver);
        if (messageList[m.receiver] == null)
          messageList[m.receiver] = <Message>[];
        messageList[m.receiver].add(m);
        if (messageCount[m.receiver] == null) messageCount[m.receiver] = 0;
        messageCount[m.receiver]++;
      } else {
        newmessages[m.sender] = 0;
        ids.add(m.sender);
        if (messageList[m.sender] == null) messageList[m.sender] = <Message>[];
        messageList[m.sender].add(m);
        if (messageCount[m.sender] == null) messageCount[m.sender] = 0;
        messageCount[m.sender]++;
      }
    }
    for (var i in unreadedlst) newmessages[i.sender] = i.count;
    for (var i in usrlst) names[i.id] = i.name;
    loading = false;
    setState(() {});
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

  sendpendingmessages() async {
    List<ToSend> tosend = await databasehelper.getToSendList();
    for (var i in tosend) {
      if (hubConnection.state == HubConnectionState.Connected) {
        await hubConnection
            .invoke("sendmessage", args: <Object>[thisUser, i.receiver, i.msg]);
        await databasehelper.deleteToSend(i.id);
      }
    }
  }

  String lastMessage(int id) {
    String ms = messageList[id][messageList[id].length - 1].msg;
    if (messageList[id][messageList[id].length - 1].sender == thisUser)
      ms = 'You: ' + ms;
    if (ms.length > 40) ms = ms.substring(0, 40) + '...';
    return ms;
  }

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
                    await databasehelper.deleteUnreaded(id);
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

  Widget getOnlineUsers() {
    if (onlineuserslist.isEmpty)
      return Center(
        child: CircularProgressIndicator(),
      );
    int count = ids.length;
    var list = CupertinoScrollbar(
        controller: _scrollControlleronlineusers,
        child: ListView.builder(
            controller: _scrollControlleronlineusers,
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

  void _getonlineusers(List<Object> arguments) {}
}

connect() {
  if (hubConnection.state == HubConnectionState.Disconnected) {
    try {
      hubConnection.stop();
      hubConnection.start();
    } catch (_) {}
  }
}
