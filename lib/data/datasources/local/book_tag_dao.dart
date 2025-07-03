import 'package:reader/data/models/book_tag.dart';
import 'package:reader/data/datasources/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class BookTagDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertBookTag(BookTag bookTag) async {
    Database db = await dbHelper.database;
    return await db.insert('book_tags', bookTag.toMap());
  }

  Future<int> deleteBookTag(int bookId, int tagId) async {
    Database db = await dbHelper.database;
    return await db.delete(
      'book_tags',
      where: 'bookId = ? AND tagId = ?',
      whereArgs: [bookId, tagId],
    );
  }

  Future<List<BookTag>> findTagsByBookId(int bookId) async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'book_tags',
      where: 'bookId = ?',
      whereArgs: [bookId],
    );
    return List.generate(maps.length, (i) {
      return BookTag.fromMap(maps[i]);
    });
  }

  Future<List<BookTag>> findBooksByTagId(int tagId) async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'book_tags',
      where: 'tagId = ?',
      whereArgs: [tagId],
    );
    return List.generate(maps.length, (i) {
      return BookTag.fromMap(maps[i]);
    });
  }
}
