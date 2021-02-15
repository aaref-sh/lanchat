class Message {
  int _id;
  String _msg;
  int _sender;
  int _reciver;
  DateTime _date;
  Message(this._sender, this._reciver, this._msg);
  Message.withId(this._id, this._msg, this._sender, this._reciver);
  int get id => _id;
  int get sender => _sender;
  int get reciver => _reciver;
  String get msg => _msg;
  DateTime get date => _date;
  set id(int id) => this._id = id;
  set date(DateTime date) => this._date = date;

  set msg(String newmsg) {
    if (newmsg.length < 200) this._msg = newmsg;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['msg'] = _msg;
    map['sender'] = _sender;
    map['reciver'] = _reciver;
    return map;
  }

  Message.fromMap(Map<String, dynamic> map) {
    this._id = int.parse(map['id'].toString());
    this._msg = map['msg'].toString();
    this._sender = int.parse(map['sender'].toString());
    this._reciver = int.parse(map['reciver'].toString());
    this._date = DateTime.parse(map['date'].toString());
  }
}
