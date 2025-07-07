import 'package:reader/domain/entities/chapter.dart';

abstract class ChapterRepository {
  Future<List<Chapter>> getChaptersByBookId(int bookId);

  Future<Chapter?> getChapterById(int chapterId, int bookId);

  Future<int> addChapter(Chapter chapter);

  Future<void> addChapters(List<Chapter> chapters);

  Future<int> updateChapter(Chapter chapter);

  Future<int> deleteChapter(int id);
}
