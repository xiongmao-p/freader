import 'package:reader/domain/repositories/book_source_repository.dart';

class DeleteBookSource {
  final BookSourceRepository repository;

  DeleteBookSource(this.repository);

  Future<int> call(int id) {
    return repository.deleteBookSource(id);
  }
}
