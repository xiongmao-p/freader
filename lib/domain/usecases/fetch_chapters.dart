import 'package:reader/domain/entities/book.dart';
import 'package:reader/domain/entities/chapter.dart';
import 'package:reader/domain/repositories/book_repository.dart';

class FetchChapters {
  final BookRepository repository;

  FetchChapters(this.repository);

  Future<List<Chapter>> call(Book book) {
    return repository.fetchChapters(book);
  }
}
