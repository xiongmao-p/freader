import 'package:reader/data/datasources/local/chapter_dao.dart';
import 'package:reader/data/datasources/remote/book_remote_data_source.dart';
import 'package:reader/domain/entities/chapter.dart' as domain;
import 'package:reader/data/models/chapter.dart' as data;
import 'package:reader/domain/repositories/book_repository.dart' as domain;
import 'package:reader/domain/repositories/chapter_repository.dart';

class ChapterRepositoryImpl implements ChapterRepository {
  final ChapterDao chapterDao;
  final BookRemoteDataSource remoteDataSource;
  final domain.BookRepository bookRepository;

  ChapterRepositoryImpl({
    required this.chapterDao,
    required this.remoteDataSource,
    required this.bookRepository,
  });

  @override
  Future<int> addChapter(domain.Chapter chapter) {
    final dataChapter = data.Chapter(
      id: chapter.id,
      bookId: chapter.bookId,
      title: chapter.title,
      url: '', // This should be derived from the book source
      isRead: false,
      chapterIndex: chapter.chapterIndex,
    );
    return chapterDao.insertChapter(dataChapter);
  }

  @override
  Future<void> addChapters(List<domain.Chapter> chapters) {
    final dataChapters = chapters
        .map(
          (c) => data.Chapter(
            id: c.id,
            bookId: c.bookId,
            title: c.title,
            url: '', // This should be derived from the book source
            isRead: false,
            chapterIndex: c.chapterIndex,
          ),
        )
        .toList();
    return chapterDao.insertChapters(dataChapters);
  }

  @override
  Future<int> deleteChapter(int id) {
    return chapterDao.deleteChapter(id);
  }

  @override
  Future<domain.Chapter?> getChapterById(int chapterId, int bookId) async {
    final dataChapter = await chapterDao.findChapterById(chapterId);
    final book = await bookRepository.getBookById(bookId);

    if (dataChapter != null && book != null) {
      final remoteChapter = await remoteDataSource.getChapterContent(
        dataChapter.url,
        dataChapter.chapterIndex,
        book,
      );
      return domain.Chapter(
        id: dataChapter.id!,
        bookId: dataChapter.bookId,
        title: dataChapter.title,
        content: remoteChapter.content,
        chapterIndex: dataChapter.chapterIndex,
      );
    }
    return null;
  }

  @override
  Future<List<domain.Chapter>> getChaptersByBookId(int bookId) async {
    final dataChapters = await chapterDao.findChaptersByBookId(bookId);
    return dataChapters
        .map(
          (c) => domain.Chapter(
            id: c.id!,
            bookId: c.bookId,
            title: c.title,
            content: '', // Content is loaded on demand
            chapterIndex: c.chapterIndex,
          ),
        )
        .toList();
  }

  @override
  Future<int> updateChapter(domain.Chapter chapter) {
    final dataChapter = data.Chapter(
      id: chapter.id,
      bookId: chapter.bookId,
      title: chapter.title,
      url: '', // This should be derived from the book source
      isRead: false, // This should be updated based on user progress
      chapterIndex: chapter.chapterIndex,
    );
    return chapterDao.updateChapter(dataChapter);
  }
}
