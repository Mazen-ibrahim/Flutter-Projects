import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqldb {
  Database? db;

  Future<Database?> getDataBase(String dbname, String createquery) async {
    db = await initialdb(dbname, createquery);
    return db;
  }

  Future<Database> initialdb(String dbname, String createquery) async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, dbname);
    Database db = await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(createquery);
      },
      version: 1,
    );
    return db;
  }

  Future<List<Map<String, Object?>>?> loadData(String tablename) async {
    if (db == null) {
      return null;
    }
    return await db!.query(tablename);
  }

  Future<List<Map<String, Object?>>?> select(String query) async {
    if (db == null) {
      return null;
    }
    return await db!.rawQuery(query);
  }

  Future<int> insert(String tablename, Map<String, Object?> row) async {
    if (db == null) {
      return -1;
    }

    return await db!.insert(tablename, row);
  }

  Future<int> update(String query) async {
    if (db == null) {
      return -1;
    }
    return await db!.rawUpdate(query);
  }

  Future<int> delete(String query) async {
    if (db == null) {
      return -1;
    }
    return await db!.rawDelete(query);
  }
}
