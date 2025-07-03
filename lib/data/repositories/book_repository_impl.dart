import 'package:reader/data/datasources/local/book_dao.dart';
import 'package:reader/data/models/book.dart';
import 'package:reader/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookDao bookDao;

  BookRepositoryImpl({required this.bookDao});

  @override
  Future<int> addBook(Book book) {
    return bookDao.insertBook(book);
  }

  @override
  Future<int> deleteBook(int id) {
    return bookDao.deleteBook(id);
  }

  @override
  Future<Book?> getBookById(int id) {
    return bookDao.findBookById(id);
  }

  @override
  Future<List<Book>> getBooks() {
    return bookDao.findAllBooks();
  }

  @override
  Future<int> updateBook(Book book) {
    return bookDao.updateBook(book);
  }
}
