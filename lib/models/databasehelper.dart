import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'chats.dart';

class databasehelper {
  static databasehelper _databasehelper;
  static Database _database;
  String chattable = 'chat';
  String colid = 'id';
  String colsender = 'sender';
  String colreciver = 'reciver';
  String colmsg = 'msg';
  String coldate = 'date';

  databasehelper._createinstance();
  factory databasehelper() {
    if (_databasehelper == null)
      _databasehelper = databasehelper._createinstance();
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
        '''CREATE TABLE $chattable ($colid INTEGER PRIMARY KEY AUTOINCREMENT,
           $colmsg TEXT, $colsender TEXT,$colreciver TEXT, $coldate DATETIME)''');
  }

  Future<List<Map<String, dynamic>>> getmsgmap(int sender, int reciver) async {
    Database db = await this.database;
    var result = await db.query(chattable,
        where: '$colsender = ? and $colreciver = ?',
        whereArgs: [sender, reciver]);
    return result;
  }

  Future<int> insertmsg(chat msg) async {
    Database db = await this.database;
    var result = await db.insert(chattable, msg.toMap());
    return result;
  }

  Future<int> deletemsg(int msgid) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $chattable WHERE $colid = $msgid');
    return result;
  }
}
