import 'package:reader/data/models/chapter.dart';

abstract class ChapterRepository {
  Future<List<Chapter>> getChaptersByBookId(int bookId);

  Future<Chapter?> getChapterById(int id);

  Future<int> addChapter(Chapter chapter);

  Future<int> updateChapter(Chapter chapter);

  Future<int> deleteChapter(int id);
}
