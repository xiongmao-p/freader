import 'package:reader/data/models/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();

  Future<Book?> getBookById(int id);

  Future<int> addBook(Book book);

  Future<int> updateBook(Book book);

  Future<int> deleteBook(int id);
}
