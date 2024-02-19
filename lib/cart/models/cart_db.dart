import 'package:bababos_test/cart/models/cart_model.dart';
import 'package:bababos_test/commons/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

const _tableName = "carts";

class CartDb {
  static Future<void> createTable(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $_tableName (
        "id" INTEGER NOT NULL,
        "product_id" INTEGER NOT NULL,
        "qty" INTEGER NOT NULL,
        "created_at" INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INT)),
        PRIMARY KEY("id" AUTOINCREMENT)
      );
    """);
  }

  static Future<int> insert({required int productId}) async {
    final database = await DatabaseService.shared.database;

    return await database.insert(
      _tableName,
      {
        "product_id": productId,
        "qty": 1,
      },
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  static Future<List<CartModel>> fetchAll() async {
    final database = await DatabaseService.shared.database;
    final results = await database.rawQuery("""
        SELECT * FROM $_tableName ORDER BY (created_at) DESC
      """);

    return results.map((json) => CartModel.fromJson(json)).toList();
  }

  static Future<void> update({required int id, required int qty}) async {
    final database = await DatabaseService.shared.database;

    await database.update(
      _tableName,
      {"qty": qty},
      where: "id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  static Future<void> delete({required int id}) async {
    final database = await DatabaseService.shared.database;

    await database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteAll() async {
    final database = await DatabaseService.shared.database;

    await database.delete(_tableName);
  }
}
