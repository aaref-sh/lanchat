import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/texts.dart';
import 'package:emoji_pick/emoji_pick.dart';
import 'package:flutter_app/models/chats.dart';
import 'package:flutter_app/models/databasehelper.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:intl/intl.dart';

class ChatWith extends StatefulWidget {
  @override
  _ChatWithState createState() => _ChatWithState();
}

// ignore: non_constant_identifier_names
int this_user = 1;
// ignore: non_constant_identifier_names
int other_user = 5;

class _ChatWithState extends State<ChatWith> {
  String _message = '';
  //MOST IMP
  var emojiheight = 0.0;

  TextEditingController textFieldController;
  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    textFieldController = new TextEditingController()..addListener(() {});
  }

  Databasehelper databasehelper = Databasehelper();
  List<Message> msglist;
  int count = 0;
  bool firstload = true;
  List<int> sender = [3, 2, 2, 1, 2];
  String msg = '';
  @override
  Widget build(BuildContext context) {
    if (msglist == null && firstload) {
      msglist = List<Message>();
      updatemessagelist();
      firstload = false;
    }
    Timer(
      Duration(seconds: 1),
      () => _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
      ),
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Text(
            'chat with',
          )),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/chat_back.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: getlist())),
              emojiPad(),
            ],
          )),
    );
  }

  Column emojiPad() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(30.0)),
                      color: Color(0x60000000),
                      border: Border.all(
                        color: Colors.blue[400],
                        width: 1,
                      ),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 4)
                      ]),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        //     splashColor: Colors.white,
                        //    hoverColor: Colors.white,
                        //    highlightColor: Colors.white,
                        disabledColor: Colors.grey,
                        color: Colors.blue[300],
                        icon: Icon(Icons.insert_emoticon),
                        onPressed: () {
                          //MOST IMP
                          setState(() =>
                              emojiheight = emojiheight == 0.0 ? 200.0 : 0.0);
                        },
                      ),
                      Flexible(
                        child: TextField(
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                          textAlign: ta(_message),
                          textDirection: td(_message),
                          autofocus: false,
                          autocorrect: false,
                          controller: textFieldController,
                          onTap: () {
                            //MOST IMP
                            setState(() {
                              emojiheight = 0.0;
                            });
                          },
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(right: 14.0),
                            hintText: 'Type a message',
                            hintStyle:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                            counterText: '',
                          ),
                          minLines: 1,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: FloatingActionButton(
                  elevation: 2.0,
                  backgroundColor: Colors.blue[400],
                  foregroundColor: Colors.white,
                  child: Icon(Icons.send),
                  onPressed: () {
                    String mesg = textFieldController.text;
                    // databasehelper.query( "insert into message (sender,reciver,msg) values ($this_user,$other_user,'$mesg')");
                    if (mesg != null && mesg != '') {
                      setState(() {
                        Message ms = Message(this_user, other_user, mesg);
                        databasehelper.insertMsg(ms);
                        msglist.add(ms);
                        count++;
                        //updatemessagelist();
                      });
                    }
                    textFieldController.clear();
                  },
                ),
              )
            ],
          ),
        ),

        //MOST IMP
        Emojies(
            tabsname: tabsname,
            tabsemoji: tabsemoji,
            maxheight: emojiheight,
            inputtext: textFieldController,
            bgcolor: Color(0x70000000)),
      ],
    );
  }

  Widget getlist() {
    var list = ListView.builder(
        itemCount: count,
        controller: _controller,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            onLongPress: () {
              print(msglist[i].id);
              delete(context, msglist[i].id);
            },
            child: Bubble(
                style: bs(msglist[i].sender),
                child: Text(this.msglist[i].msg,
                    textAlign: ta(this.msglist[i].msg),
                    textDirection: td(this.msglist[i].msg))),
          );
        });
    last = 0;
    return list;
  }

  void delete(BuildContext context, int messageid) async {
    int result = await databasehelper.deleteMsg(messageid);
    setState(() {
      if (result != 0) {
        count--;
        msglist.removeWhere((element) => element.id == messageid);
      }
    });
  }

  void updatemessagelist() {
    final Future<Database> dbFuture = databasehelper.initializedatabase();
    dbFuture.then((database) {
      Future<List<Message>> messageListFuture =
          databasehelper.getMessaeList(this_user, other_user);
      messageListFuture.then((messageList) {
        setState(() {
          this.msglist = messageList;
          this.count = messageList.length;
        });
      });
    });
    print(this.count);
  }
}
