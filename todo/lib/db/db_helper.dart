import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static const int _version = 1;
  static const String _dbName = 'task.db';
  static const String table = 'tasks';
  static Database? _db;

  static Future<void> initDB() async {
    if (_db != null) {
      return Future.value();
    } else {
      return openDatabase(
        _dbName,
        version: _version,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING, color INTEGER, isCompleted INTEGER)',
          );
        },
      ).then((value) => _db = value);
    }
  }

  static Future<int> insert(Task task) async {
    return await _db!.insert(table, task.toJson());
  }

  static Future<int> delete(Task task) async {
    return await _db!.delete(table, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> update(Task task) async {
    return await _db!.rawUpdate(
      '''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
    ''',
      [1, task.id],
    );
  }
  
  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(table);
  }
}
