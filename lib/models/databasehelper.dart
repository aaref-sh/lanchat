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
  String usertable = 'users';
  String colname = 'name';
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
    await db.execute(
        '''CREATE TABLE $usertable ( $colid INTEGER, $colname TEXT )''');
  }

  Future<List<Map<String, dynamic>>> getMsgMap() async {
    Database db = await this.database;
    var result = await db.query(chattable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getUserMap() async {
    Database db = await this.database;
    var result = await db.query(usertable);
    return result;
  }

  Future<int> insertMsg(Message msg) async {
    Database db = await this.database;
    var result = await db.insert(chattable, msg.toMap());
    return result;
  }

  Future<int> insertuser(User user) async {
    Database db = await this.database;
    var result = await db.insert(usertable, user.toMap());
    return result;
  }

  Future<int> deleteMsg(int msgid) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $chattable WHERE $colid = $msgid');
    return result;
  }

  Future<int> deleteList(int otherUser) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $chattable WHERE $colsender = $otherUser OR $colreceiver = $otherUser');
    return result;
  }

  Future<void> query(String query) async {
    var db = await this.database;
    await db.execute(query);
  }

  Future<List<Message>> getMessaeList() async {
    var msgMapList = await getMsgMap();
    int count = msgMapList.length;
    List<Message> msgList = <Message>[];
    for (int i = 0; i < count; i++) {
      msgList.add(Message.fromMap(msgMapList[i]));
    }
    return msgList;
  }

  Future<List<User>> getUserList() async {
    var userMapList = await getUserMap();
    List<User> userList = <User>[];
    for (int i = 0; i < userMapList.length; i++)
      userList.add(User.fromMap(userMapList[i]));
    return userList;
  }
}
