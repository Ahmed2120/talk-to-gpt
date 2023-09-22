import 'package:sqflite/sqflite.dart';

import '../model/message.dart';
import 'DatabaseHandler.dart';

class MsgRepository{
  static const String TABLE_NAME = "massages";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Message message) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, message.toMap());
    return result;
  }

  Future<List<Message>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    print('queryResult: $queryResult');
    return queryResult.map((e) => Message.fromMap(e)).toList();
  }

  Future<List<Message>> retrieveByChatId(int chatId) async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME, where: 'chatId=?', whereArgs: [chatId]);
    print('queryResult: $queryResult');
    return queryResult.map((e) => Message.fromMap(e)).toList();
  }

  Future<int> update(Message msg) async{
    final Database db = await databaseHandler.initializeDB();
    return db.update(TABLE_NAME, msg.toMap(),where: "id = ?",whereArgs: [msg.id]);
  }

  Future<int> batch(List<Message> msgs) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var msg in msgs){
      result = await db.insert(TABLE_NAME, msg.toMap());
    }
    return result;
  }

  Future<void> delete(int id) async {
    final db = await databaseHandler.initializeDB();
    await db.delete(
      TABLE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteTable() async {
    final db = await databaseHandler.initializeDB();
    await db.delete(
      TABLE_NAME,
    );
  }
}