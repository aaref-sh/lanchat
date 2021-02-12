import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/texts.dart';
import 'package:emoji_pick/emoji_pick.dart';
//import 'package:intl/intl.dart';

class ChatWith extends StatefulWidget {
  @override
  _ChatWithState createState() => _ChatWithState();
}

int this_user = 1;

class _ChatWithState extends State<ChatWith> {
  List<String> _messages = [];
  String _message = '';
  //MOST IMP
  var emojiheight = 0.0;

  TextEditingController textFieldController;
  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    textFieldController = new TextEditingController()
      ..addListener(() {
        setState(() {
          _message = textFieldController.text;
        });
      });
  }

  List<String> lst = [
    'مبارح🤣',
    'أم آتيناهم ',
    'ورفعنا بعضكم فوق بعض درجات',
    'ليتخذ بعضكم بعضا سخريا',
    'ورحمة ربك خير مما يجمعون.'
  ];
  List<int> sender = [3, 2, 2, 1, 2];
  String msg = '';
  @override
  Widget build(BuildContext context) {
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
                      child: getlist(lst, sender))),
              Column(
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
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(30.0)),
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
                                    setState(() => emojiheight =
                                        emojiheight == 0.0 ? 200.0 : 0.0);
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
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.only(right: 14.0),
                                      hintText: 'Type a message',
                                      hintStyle: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
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
                              if (_message != null && _message != '') {
                                setState(() {
                                  _messages
                                      .add(textFieldController.text.toString());
                                  lst.add(_message);
                                  sender.add(this_user);
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
              ),
            ],
          )),
    );
  }

  Widget getlist(List<String> lst, List<int> sender) {
    var list = ListView.builder(
        controller: _controller,

        //reverse: true,
        //shrinkWrap: true,
        // ignore: missing_return
        itemBuilder: (context, i) {
          //print(i);
          if (i < lst.length)
            return Bubble(
                style: bs(sender[i]),
                child: Text(lst[i],
                    textAlign: ta(lst[i]), textDirection: td(lst[i])));
        });
    return list;
  }
}

int last = 0;
BubbleStyle bs(int x) {
  if (x == 3) return heading;
  if (x == last) {
    last = x;
    return x == this_user ? me2 : he2;
  }
  last = x;
  return x == this_user ? me : he;
}
