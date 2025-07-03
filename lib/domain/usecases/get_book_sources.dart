import 'package:reader/data/models/book_source.dart';
import 'package:reader/domain/repositories/book_source_repository.dart';

class GetBookSources {
  final BookSourceRepository repository;

  GetBookSources(this.repository);

  Future<List<BookSource>> call() {
    return repository.getBookSources();
  }
}
