import 'package:reader/data/datasources/local/chapter_dao.dart';
import 'package:reader/data/models/chapter.dart';
import 'package:reader/domain/repositories/chapter_repository.dart';

class ChapterRepositoryImpl implements ChapterRepository {
  final ChapterDao chapterDao;

  ChapterRepositoryImpl({required this.chapterDao});

  @override
  Future<int> addChapter(Chapter chapter) {
    return chapterDao.insertChapter(chapter);
  }

  @override
  Future<int> deleteChapter(int id) {
    return chapterDao.deleteChapter(id);
  }

  @override
  Future<Chapter?> getChapterById(int id) {
    return chapterDao.findChapterById(id);
  }

  @override
  Future<List<Chapter>> getChaptersByBookId(int bookId) {
    return chapterDao.findChaptersByBookId(bookId);
  }

  @override
  Future<int> updateChapter(Chapter chapter) {
    return chapterDao.updateChapter(chapter);
  }
}
