import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/texts.dart';
import 'package:emoji_pick/emoji_pick.dart';

class ChatWith extends StatefulWidget {
  @override
  _ChatWithState createState() => _ChatWithState();
}

class _ChatWithState extends State<ChatWith> {
  List<String> _messages = [];
  String _message = '';

  //MOST IMP
  var emojiheight = 0.0;

  TextEditingController textFieldController;

  @override
  void initState() {
    // TODO: implement initState
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
    'بسم الله الرحمن الرحيم',
    'ورفعنا بعضكم فوق بعض درجات',
    'ليتخذ بعضكم بعضا سخريا',
    'ورحمة ربك خير مما يجمعون.'
  ];
  List<int> sender = [3, 2, 2, 1, 1];
  String msg = '';
  @override
  Widget build(BuildContext context) {
    List<String> _tabsname = ["🙂", "Fruits", "Fruits", "Asif"];
    List<dynamic> _tabsemoji = [
      ["☕", "❤", "☕", "☕", "☕", "❤"],
      ["☕", "❤", "☕", "☕", "☕", "❤", "☕", "❤", "☕", "☕", "☕", "❤"],
      [
        "☕",
        "❤",
        "☕",
        "☕",
        "☕",
        "❤",
        "☕",
        "❤",
        "☕",
      ]
    ];

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
                                    if (emojiheight == 0.0) {
                                      setState(() {
                                        emojiheight = 255.0;
                                      });
                                    } else {
                                      setState(() {
                                        emojiheight = 0.0;
                                      });
                                    }
                                  },
                                ),
                                Flexible(
                                  child: TextField(
                                    onChanged: (String input) {
                                      setState(() {
                                        if (input != null) msg = input;
                                      });
                                    },
                                    style: TextStyle(color: Color(0xFFFFFFFF)),
                                    textAlign: ta(msg),
                                    textDirection: td(msg),
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
                              setState(() {
                                _messages
                                    .add(textFieldController.text.toString());
                              });

                              textFieldController.clear();
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  //MOST IMP
                  Emojies(
                      tabsname: _tabsname,
                      tabsemoji: _tabsemoji,
                      maxheight: emojiheight,
                      inputtext: textFieldController,
                      bgcolor: Colors.white),
                ],
              ),
            ],
          )),
    );
  }
}

int last = 0;
BubbleStyle bs(int x) {
  if (x == 3) return heading;
  if (x == last) {
    last = x;
    return x == 1 ? me2 : he2;
  }
  last = x;
  return x == 1 ? me : he;
}

Widget getlist(List<String> lst, List<int> sender) {
  var list = ListView.builder(itemBuilder: (context, i) {
    print(i);
    if (i < lst.length)
      return Bubble(
          style: bs(sender[i]),
          child:
              Text(lst[i], textAlign: ta(lst[i]), textDirection: td(lst[i])));
  });
  return list;
}
