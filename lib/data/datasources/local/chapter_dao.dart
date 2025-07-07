import 'package:reader/data/models/chapter.dart';
import 'package:reader/data/datasources/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ChapterDao {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertChapter(Chapter chapter) async {
    Database db = await dbHelper.database;
    return await db.insert('chapters', chapter.toMap());
  }

  Future<void> insertChapters(List<Chapter> chapters) async {
    Database db = await dbHelper.database;
    Batch batch = db.batch();
    for (var chapter in chapters) {
      batch.insert('chapters', chapter.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<int> updateChapter(Chapter chapter) async {
    Database db = await dbHelper.database;
    return await db.update(
      'chapters',
      chapter.toMap(),
      where: 'id = ?',
      whereArgs: [chapter.id],
    );
  }

  Future<int> deleteChapter(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('chapters', where: 'id = ?', whereArgs: [id]);
  }

  Future<Chapter?> findChapterById(int id) async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'chapters',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Chapter.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Chapter>> findChaptersByBookId(int bookId) async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'chapters',
      where: 'bookId = ?',
      whereArgs: [bookId],
    );
    return List.generate(maps.length, (i) {
      return Chapter.fromMap(maps[i]);
    });
  }
}
