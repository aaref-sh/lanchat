import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class ChatWith extends StatefulWidget {
  @override
  _ChatWithState createState() => _ChatWithState();
}

class _ChatWithState extends State<ChatWith> {
  // ChatWith({this.opp})
  // final oppo;
  @override
  void initState() {
    super.initState();
  }

  bool ar(String text) {
    if (text.length == 0) return false;
    if (text.codeUnitAt(0) >= 0x600 && text.codeUnitAt(0) <= 0x6ff) return true;
    if (text.codeUnitAt(0) >= 0x750 && text.codeUnitAt(0) <= 0x77f) return true;
    if (text.codeUnitAt(0) >= 0xfb50 && text.codeUnitAt(0) <= 0xfc3f)
      return true;
    if (text.codeUnitAt(0) >= 0xfe70 && text.codeUnitAt(0) <= 0xfefc)
      return true;
    return false;
  }

  BubbleStyle me = BubbleStyle(
    margin: BubbleEdges.only(top: 10),
    alignment: Alignment.topRight,
    nip: BubbleNip.rightTop,
    elevation: 3,
    color: Color.fromRGBO(225, 255, 199, 1.0),
  );
  BubbleStyle me2 = BubbleStyle(
    margin: BubbleEdges.only(top: 2),
    alignment: Alignment.topRight,
    elevation: 3,
    nip: BubbleNip.no,
    color: Color.fromRGBO(225, 255, 199, 1.0),
  );
  BubbleStyle he = BubbleStyle(
    margin: BubbleEdges.only(top: 10),
    alignment: Alignment.topLeft,
    elevation: 3,
    nip: BubbleNip.leftTop,
  );
  BubbleStyle he2 = BubbleStyle(
    margin: BubbleEdges.only(top: 2),
    alignment: Alignment.topLeft,
    elevation: 3,
    nip: BubbleNip.no,
  );
  BubbleStyle heading = BubbleStyle(
    alignment: Alignment.center,
    color: Color.fromARGB(255, 212, 234, 244),
    elevation: 2,
    margin: BubbleEdges.only(top: 8.0),
  );
  TextAlign ta(String messag) {
    return ar(messag) ? TextAlign.right : TextAlign.left;
  }

  TextDirection td(String message) {
    return ar(message) ? TextDirection.rtl : TextDirection.ltr;
  }

  List<String> msg = [
    'بسم الله الرحمن الرحيم',
    'hورفعنا بعضكم فوق بعض درجات',
    'ليتخذ بعضكم بعضا سخريا',
    'ورحمة ربك خير مما يجمعون.'
  ];
  List<int> sender = [2, 2, 1, 1];
  int last = 0;
  BubbleStyle bs(int x) {
    if (x == last) {
      last = x;
      return x == 1 ? me2 : he2;
    }
    last = x;
    return x == 1 ? me : he;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          toolbarHeight: 40,
          title: Text(
            'chat with',
          )),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/chat_back.jpg'), fit: BoxFit.cover),
          ),
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              Bubble(
                  style: heading,
                  child: Text('مبارح', style: TextStyle(fontSize: 10))),
              for (int i = 0; i < 4; i++)
                Bubble(
                    style: bs(sender[i]),
                    child: Text(
                      msg[i],
                      textAlign: ta(msg[i]),
                      textDirection: td(msg[i]),
                    )),
              Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 2, right: 2),
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    minLines: 1,
                    maxLines: 4,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Write your status here',
                      filled: true,
                      fillColor: Color(0xFFDBEDFF),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
