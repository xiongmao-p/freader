import 'package:reader/data/models/book_source.dart';
import 'package:reader/domain/repositories/book_source_repository.dart';

class AddBookSource {
  final BookSourceRepository repository;

  AddBookSource(this.repository);

  Future<int> call(BookSource bookSource) {
    return repository.addBookSource(bookSource);
  }
}
