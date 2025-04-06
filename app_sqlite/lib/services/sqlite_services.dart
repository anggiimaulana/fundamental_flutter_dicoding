import 'package:app_sqlite/model/profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SqliteServices {
  static const String _databaseName = "profilelist.db";
  static const String _tableName = "profile";
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute("""
        CREATE TABLE $_tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          name TEXT, email TEXT, 
          phone_number TEXT, 
          marital_status INTEGER
        )
      """);
  }

  Future<Database> _initializeDb() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, _databaseName);
    return openDatabase(
      path,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // membuat item baru

  Future<int> insertItem(Profile profile) async {
    final db = await _initializeDb();

    final data = profile.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // membaca seluruh item
  Future<List<Profile>> getAllItems() async {
    final db = await _initializeDb();
    final result = await db.query(_tableName, orderBy: "id");

    return result.map((result) => Profile.fromJson(result)).toList();
  }

  // mencari item berdasarkan nilai id
  Future<Profile> getItemById(int id) async {
    final db = await _initializeDb();
    final result = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    return result.map((result) => Profile.fromJson(result)).first;
  }

  // memperbarui item berdasarkan nilai id nya
  Future<int> updateItem(int id, Profile profile) async {
    final db = await _initializeDb();
    final data = profile.toJson();
    final result = await db.update(
      _tableName,
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  // menghapus item berdasarkan nilai id nya
  Future<int> removeItem(int id) async {
    final db = await _initializeDb();
    final result = await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }
}
