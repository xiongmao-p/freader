import 'package:reader/data/models/book_source.dart';
import 'package:reader/data/datasources/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class BookSourceDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertBookSource(BookSource bookSource) async {
    Database db = await dbHelper.database;
    return await db.insert('book_sources', bookSource.toMap());
  }

  Future<int> updateBookSource(BookSource bookSource) async {
    Database db = await dbHelper.database;
    return await db.update(
      'book_sources',
      bookSource.toMap(),
      where: 'id = ?',
      whereArgs: [bookSource.id],
    );
  }

  Future<int> deleteBookSource(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('book_sources', where: 'id = ?', whereArgs: [id]);
  }

  Future<BookSource?> findBookSourceById(int id) async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'book_sources',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return BookSource.fromMap(maps.first);
    }
    return null;
  }

  Future<List<BookSource>> findAllBookSources() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('book_sources');
    return List.generate(maps.length, (i) {
      return BookSource.fromMap(maps[i]);
    });
  }

  Future<List<BookSource>> findEnabledBookSources() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'book_sources',
      where: 'isEnabled = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return BookSource.fromMap(maps[i]);
    });
  }
}
