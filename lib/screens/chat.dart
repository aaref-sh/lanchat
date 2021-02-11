import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/texts.dart';

class ChatWith extends StatefulWidget {
  @override
  _ChatWithState createState() => _ChatWithState();
}

class _ChatWithState extends State<ChatWith> {
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
              Expanded(flex: 1, child: getlist(lst, sender)),
              TextField(
                onChanged: (String input) {
                  setState(() {
                    if (input != null) msg = input;
                  });
                },
                textAlign: ta(msg),
                textDirection: td(msg),
                autofocus: false,
                style: TextStyle(fontSize: 16.0, color: Color(0xFFbdc6cf)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0x6F000000),
                  hintText: 'Type here',
                  hintStyle:
                      TextStyle(fontSize: 16.0, color: Color(0xFFbdc6cf)),
                  contentPadding: const EdgeInsets.only(
                      left: 14.0, right: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
                minLines: 1,
                maxLines: 3,
              )
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
