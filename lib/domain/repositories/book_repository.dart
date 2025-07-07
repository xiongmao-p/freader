import 'package:reader/domain/entities/book.dart';
import 'package:reader/domain/entities/chapter.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();

  Future<Book?> getBookById(int id);

  Future<List<Book>> searchBooks(String query);

  Future<int> addBook(Book book);

  Future<int> updateBook(Book book);

  Future<int> deleteBook(int id);

  Future<List<Chapter>> fetchChapters(Book book);
}
