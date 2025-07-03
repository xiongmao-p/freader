import 'package:reader/data/models/book_source.dart';
import 'package:reader/domain/repositories/book_source_repository.dart';

class UpdateBookSource {
  final BookSourceRepository repository;

  UpdateBookSource(this.repository);

  Future<int> call(BookSource bookSource) {
    return repository.updateBookSource(bookSource);
  }
}
