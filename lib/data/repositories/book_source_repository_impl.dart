import 'package:reader/data/datasources/local/book_source_dao.dart';
import 'package:reader/data/models/book_source.dart';
import 'package:reader/domain/repositories/book_source_repository.dart';

class BookSourceRepositoryImpl implements BookSourceRepository {
  final BookSourceDao bookSourceDao;

  BookSourceRepositoryImpl({required this.bookSourceDao});

  @override
  Future<int> addBookSource(BookSource bookSource) {
    return bookSourceDao.insertBookSource(bookSource);
  }

  @override
  Future<int> deleteBookSource(int id) {
    return bookSourceDao.deleteBookSource(id);
  }

  @override
  Future<BookSource?> getBookSourceById(int id) {
    return bookSourceDao.findBookSourceById(id);
  }

  @override
  Future<List<BookSource>> getBookSources() {
    return bookSourceDao.findAllBookSources();
  }

  @override
  Future<int> updateBookSource(BookSource bookSource) {
    return bookSourceDao.updateBookSource(bookSource);
  }
}
