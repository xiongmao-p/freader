import 'package:reader/domain/repositories/book_repository.dart';

class DeleteBook {
  final BookRepository repository;

  DeleteBook(this.repository);

  Future<int> call(int id) {
    return repository.deleteBook(id);
  }
}
