import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> openDB() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'WiZN.db'),
        onCreate: (dB, version) {
      return dB.execute(
          'CREATE TABLE WiZN_Data(albumId INTEGER,id INTEGER PRIMARY KEY,title TEXT,url TEXT,thumbnailUrl TEXT)');
    }, version: 1);
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final db = await DBHelper.openDB();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<dynamic>> fetchingData(String table) async {
    final db = await DBHelper.openDB();
    return db.query(table);
  }

  static Future<int> deleteData(int itemId) async {
    final db = await DBHelper.openDB();
    return db.rawDelete(
      'DELETE FROM WiZN_Data WHERE id = ?',
      [itemId],
    );
  }
}
