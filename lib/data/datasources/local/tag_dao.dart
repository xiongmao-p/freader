import 'package:reader/data/models/tag.dart';
import 'package:reader/data/datasources/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TagDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertTag(Tag tag) async {
    Database db = await dbHelper.database;
    return await db.insert('tags', tag.toMap());
  }

  Future<int> updateTag(Tag tag) async {
    Database db = await dbHelper.database;
    return await db.update(
      'tags',
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  Future<int> deleteTag(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('tags', where: 'id = ?', whereArgs: [id]);
  }

  Future<Tag?> findTagById(int id) async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Tag.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Tag>> findAllTags() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('tags');
    return List.generate(maps.length, (i) {
      return Tag.fromMap(maps[i]);
    });
  }
}
