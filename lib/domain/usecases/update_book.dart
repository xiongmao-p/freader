import 'package:reader/data/models/book.dart';
import 'package:reader/domain/repositories/book_repository.dart';

class UpdateBook {
  final BookRepository repository;

  UpdateBook(this.repository);

  Future<int> call(Book book) {
    return repository.updateBook(book);
  }
}
