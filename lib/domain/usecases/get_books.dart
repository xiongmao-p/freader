import 'package:reader/data/models/book.dart';
import 'package:reader/domain/repositories/book_repository.dart';

class GetBooks {
  final BookRepository repository;

  GetBooks(this.repository);

  Future<List<Book>> call() {
    return repository.getBooks();
  }
}
