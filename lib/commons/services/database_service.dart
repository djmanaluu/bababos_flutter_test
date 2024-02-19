import 'package:bababos_test/cart/models/cart_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService shared = DatabaseService();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    const name = "main.db";
    final path = await getDatabasesPath();

    _database = await openDatabase(
      join(path, name),
      version: 1,
      onCreate: (db, version) {
        // Put all createTable from all tables here!!!
        CartDb.createTable(db);
      },
      singleInstance: true,
    );

    return _database!;
  }
}

class TodoDB {
  final tableName = "todos";

  Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXIST $tableName (
        "id" INTEGER NOT NULL,
        "title" TEXT NOT NULL,
        PRIMARY KEY("id" AUTOINCREMENT)
      );
    """);
  }

  Future<int> create({required String title}) async {
    final database = await DatabaseService.shared.database;

    return await database.rawInsert(
      """INSERT INTO $tableName (title, created_at) VALUES (?, ?)""",
      [title, DateTime.now().millisecondsSinceEpoch],
    );
  }
}
