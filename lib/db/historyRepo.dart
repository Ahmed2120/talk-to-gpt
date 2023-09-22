import 'package:sqflite/sqflite.dart';


import '../model/chat.dart';
import 'DatabaseHandler.dart';

class HistoryRepository{
  static const String TABLE_NAME = "historyChats";
  DatabaseHandler databaseHandler = DatabaseHandler();
  Future<int> insert(Chat chat) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.insert(TABLE_NAME, chat.toMap());
    return result;
  }

  Future<List<Chat>> retrieve() async {
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(TABLE_NAME);
    print('queryResult: $queryResult');
    return queryResult.map((e) => Chat.fromMap(e)).toList();
  }

  Future<int> update(Chat chat) async{
    final Database db = await databaseHandler.initializeDB();
    return db.update(TABLE_NAME, chat.toMap(),where: "id = ?",whereArgs: [chat.id]);
  }

  Future<int> batch(List<Chat> chats) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    for(var chat in chats){
      result = await db.insert(TABLE_NAME, chat.toMap());
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