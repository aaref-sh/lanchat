class Message {
  int _id;
  String _msg;
  int _sender;
  int _receiver;
  DateTime _date;
  Message(this._sender, this._receiver, this._msg);
  Message.withId(this._id, this._msg, this._sender, this._receiver);
  int get id => _id;
  int get sender => _sender;
  int get receiver => _receiver;
  String get msg => _msg;
  DateTime get date => _date;
  set id(int id) => this._id = id;
  set sender(int sender) => this._sender = sender;
  set receiver(int receiver) => this._receiver = receiver;
  set date(DateTime date) => this._date = date;

  set msg(String newmsg) {
    if (newmsg.length < 200) this._msg = newmsg;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['msg'] = _msg;
    map['sender'] = _sender;
    map['receiver'] = _receiver;
    return map;
  }

  Message.fromMap(Map<String, dynamic> map) {
    this._id = int.parse(map['id'].toString());
    this._msg = map['msg'].toString();
    this._sender = int.parse(map['sender'].toString());
    this._receiver = int.parse(map['receiver'].toString());
    this._date = DateTime.parse(map['date'].toString());
  }
}

class User {
  int _id;
  String _name;
  User(this._id, this._name);
  int get id => _id;
  String get name => _name;
  set id(int id) => this._id = id;
  set name(String name) => this._name = name;

  Map<String, dynamic> toMap() {
    var user = Map<String, dynamic>();
    if (id != null) user['id'] = _id;
    user['name'] = _name;
    return user;
  }

  User.fromMap(Map<String, dynamic> user) {
    this._id = int.parse(user['id'].toString());
    this._name = user['name'].toString();
  }
}

class UnReaded {
  int _sender;
  int _count;
  UnReaded(this._sender, this._count);
  set sender(int sender) => this._sender = sender;
  set count(int count) => this._count = count;
  int get sender => _sender;
  int get count => _count;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['sender'] = this._sender;
    map['count'] = this._count;
    return map;
  }

  UnReaded.fromMap(unreaded) {
    this._sender = int.parse(unreaded['sender'].toString());
    this._count = int.parse(unreaded['count'].toString());
  }
}

class ToSend {
  int _id;
  String _msg;
  int _receiver;
  ToSend(this._id, this._msg, this._receiver);
  set id(id) => this._id = id;
  int get id => this._id;
  int get receiver => this._receiver;
  String get msg => this._msg;
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = this._id;
    map['msg'] = this._msg;
    map['receiver'] = this._receiver;
    return map;
  }

  ToSend.fromMap(tosend) {
    this._id = int.parse(tosend['id'].toString());
    this._msg = tosend['msg'].toString();
    this._receiver = int.parse(tosend['receiver'].toString());
  }
}
