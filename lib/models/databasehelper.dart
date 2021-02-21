import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'chats.dart';

class Databasehelper {
  static Databasehelper _databasehelper;
  static Database _database;
  String chattable = 'message';
  String colid = 'id';
  String colsender = 'sender';
  String colreceiver = 'receiver';
  String colmsg = 'msg';
  String coldate = 'date';

  Databasehelper._createinstance();

  factory Databasehelper() {
    if (_databasehelper == null)
      _databasehelper = Databasehelper._createinstance();
    return _databasehelper;
  }
  Future<Database> initializedatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'chats.db';

    var chatsdatabase =
        await openDatabase(path, version: 1, onCreate: _crearedb);
    return chatsdatabase;
  }

  Future<Database> get database async {
    if (_database == null) _database = await initializedatabase();
    return _database;
  }

  void _crearedb(Database db, int newvers) async {
    await db.execute(
        '''CREATE TABLE $chattable ($colid INTEGER PRIMARY KEY AUTOINCREMENT, $colmsg TEXT, 
        $colsender TEXT,$colreceiver TEXT,$coldate DATETIME DEFAULT (DATETIME('now')))''');

    query("insert into message (sender,receiver,msg) values (1,5,'Hi')");
    query(
        "insert into message (sender,receiver,msg) values (5,1,'السلام عليكم')");
    query(
        "insert into message (sender,receiver,msg) values (5,1,'Hi you too')");
  }

  Future<List<Map<String, dynamic>>> getMsgMap(int sender, int receiver) async {
    Database db = await this.database;
    var result = await db.query(chattable,
        where:
            '($colsender = ? and $colreceiver = ?) OR ($colsender = ? and $colreceiver = ?)',
        whereArgs: [sender, receiver, receiver, sender]);
    return result;
  }

  Future<int> insertMsg(Message msg) async {
    Database db = await this.database;
    var result = await db.insert(chattable, msg.toMap());
    return result;
  }

  Future<int> deleteMsg(int msgid) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $chattable WHERE $colid = $msgid');
    return result;
  }

  Future<void> query(String query) async {
    var db = await this.database;
    await db.execute(query);
  }

  Future<int> getcount(int sender, int receiver) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery(
        'Select * FROM $chattable WHERE ( $colsender = $sender AND $colreceiver = $receiver )OR ($colreceiver = $sender AND $colsender = $receiver )');
    return Sqflite.firstIntValue(x);
  }

  Future<List<Message>> getMessaeList(int sender, int receiver) async {
    var msgMapList = await getMsgMap(sender, receiver);
    int count = msgMapList.length;
    List<Message> msgList = <Message>[];
    for (int i = 0; i < count; i++) {
      msgList.add(Message.fromMap(msgMapList[i]));
    }
    return msgList;
  }
}
