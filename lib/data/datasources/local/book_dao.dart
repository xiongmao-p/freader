import 'package:reader/data/models/book.dart';
import 'package:reader/data/datasources/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class BookDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertBook(Book book) async {
    Database db = await dbHelper.database;
    return await db.insert('books', book.toMap());
  }

  Future<int> updateBook(Book book) async {
    Database db = await dbHelper.database;
    return await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future<Book?> findBookById(int id) async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Book.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Book>> findAllBooks() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }
}
