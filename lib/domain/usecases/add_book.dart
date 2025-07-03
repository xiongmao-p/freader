import 'package:reader/data/models/book.dart';
import 'package:reader/domain/repositories/book_repository.dart';

class AddBook {
  final BookRepository repository;

  AddBook(this.repository);

  Future<int> call(Book book) {
    return repository.addBook(book);
  }
}
