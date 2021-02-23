import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main_screen.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/texts.dart';
import 'package:emoji_pick/emoji_pick.dart';
import 'package:flutter_app/models/chats.dart';
import 'package:flutter_app/models/databasehelper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class ChatWith extends StatefulWidget {
  final int userId; // receives the value

  ChatWith({Key key, this.userId}) : super(key: key);
  @override
  _ChatWithState createState() => _ChatWithState();
}

bool firstload = true;
int other_user = 1;

class _ChatWithState extends State<ChatWith> {
  // ignore: non_constant_identifier_names

  String _message = '';
  var emojiheight = 0.0;
  TextEditingController textFieldController;
  final _controller = ScrollController();

  Timer timer;

  @override
  void initState() {
    other_user = widget.userId;
    newmessages[other_user] = false;
    super.initState();
    textFieldController = new TextEditingController()
      ..addListener(() {
        setState(() {
          _message = textFieldController.text.trim();
        });
      });

    timer = Timer.periodic(Duration(milliseconds: 200), (Timer t) {
      if (newmessages[other_user]) {
        newmessages[other_user] = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text(
            'chat with $other_user',
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
                              _message = textFieldController.text;
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
                  onPressed: sendMessageButtonPress,
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

  void sendMessageButtonPress() async {
    // databasehelper.query( "insert into message (sender,reciver,msg) values ($this_user,$other_user,'$mesg')");
    if (_message != null && _message != '') {
      Message ms = Message(this_user, other_user, _message);
      ms.id = await databasehelper.insertMsg(ms);
      ms.date = DateTime.now();
      var url = "http://192.168.1.111:80/api/values/insert";
      var body = json.encode(ms.toMap());

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response =
          await http.post(url, body: body, headers: headers);
      final responseJson = json.decode(response.body);
      print(responseJson);
      setState(() {
        messageList[other_user].add(ms);
        messageCount[other_user]++;
        //updatemessagelist();
      });
    }
    textFieldController.clear();
  }

  Widget getlist() {
    int count = messageCount[other_user];
    var list = ListView.builder(
        itemCount: count,
        reverse: true,
        shrinkWrap: true,
        controller: _controller,
        itemBuilder: (BuildContext context, int i) {
          Message msg = messageList[other_user][count - i - 1];
          return GestureDetector(
            onLongPress: () {
              print(msg.id);
              delete(context, msg.id);
            },
            child: Bubble(
                style: bs(msg.sender, count - i - 1),
                child: Container(
                  child: Column(
                    children: [
                      Text(msg.msg,
                          textAlign: ta(msg.msg), textDirection: td(msg.msg)),
                      Text(
                        DateFormat('hh:mm a').format(msg.date),
                        textAlign: msg.sender == this_user
                            ? TextAlign.right
                            : TextAlign.left,
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                    ],
                  ),
                )),
          );
        });
    last = 0;
    return list;
  }

  void delete(BuildContext context, int messageid) async {
    int result = await databasehelper.deleteMsg(messageid);
    setState(() {
      if (result != 0) {
        messageCount[other_user]--;
        messageList[other_user]
            .removeWhere((element) => element.id == messageid);
      }
    });
  }
}
