import 'package:reader/domain/entities/book.dart';
import 'package:reader/domain/repositories/book_repository.dart';

class GetBook {
  final BookRepository repository;

  GetBook(this.repository);

  Future<Book?> call(int bookId) {
    return repository.getBookById(bookId);
  }
}
