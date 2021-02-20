import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tabber(title: 'Motion Tab Bar Sample');
  }
}

class Tabber extends StatefulWidget {
  Tabber({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TabberState createState() => _TabberState();
}

class _TabberState extends State<Tabber> with TickerProviderStateMixin {
  MotionTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
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
            Container(
                child: ListView(children: [
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text("the chat"),
                  subtitle: Text("Click to chat"),
                  trailing: Icon(Icons.message),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatWith()));
                  }),
            ])),
            Container(
              child: Center(
                child: Text("Dashboard"),
              ),
            ),
          ],
        ));
  }
}

class Mimg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage ass = AssetImage("images/grid.png");
    Image img = Image(image: ass);
    return Container(
      child: img,
      width: 150,
      height: 150,
    );
  }
}

class Gfys extends StatelessWidget {
  Gfys({this.b});
  final bool b;
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          _save(b);
          doalert(context, b);
        },
        color: Colors.black54,
        child: Text(
          b ? "visited" : "unvisited",
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 3,
      ),
    );
  }

  void doalert(BuildContext context, bool state) => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(state ? "visited" : "unvisited"),
            content: Text(state ? "fancy is on" : "fancy is off"),
          ));
}

_save(bool b) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'vis';
  final value = b ? 1 : 0;
  prefs.setInt(key, value);
  print('saved $value');
}
