class chat {
  int _id;
  String _msg;
  int _sender;
  int _reciver;
  DateTime _date;
  chat(this._id, this._msg, this._sender, this._reciver, this._date);
  int get id => _id;
  int get user => _sender;
  int get reciver => _reciver;
  String get msg => _msg;
  DateTime get date => _date;
  double x = 1e18;
  set msg(String newmsg) {
    if (newmsg.length < 200) this._msg = newmsg;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['msg'] = _msg;
    map['date'] = _date;
    map['sender'] = _sender;
    map['reciver'] = _reciver;
    return map;
  }

  chat.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._msg = map['msg'];
    this._sender = map['sender'];
    this._reciver = map['reciver'];
    this._date = map['date'];
  }
}
