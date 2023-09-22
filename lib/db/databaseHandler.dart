import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'gpt.db'),
      onCreate: (database, version) async {
        Batch batch = database.batch();
        batch.execute(
          "CREATE TABLE historyChats(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)",
        );
        batch.execute(
          "CREATE TABLE massages(id INTEGER PRIMARY KEY AUTOINCREMENT, chatId INTEGER, isSender INTEGER, txt TEXT)",
        );

        await batch.commit();
      },
      version: 1,
    );
  }

  Future<List<Object?>> clearData() async {
    final Database db = await initializeDB();
    Batch batch = db.batch();
    batch.execute("delete from order");
    return await batch.commit();
  }
}
