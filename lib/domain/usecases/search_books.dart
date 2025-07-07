import 'package:reader/domain/entities/book.dart';
import 'package:reader/domain/repositories/book_repository.dart';

class SearchBooks {
  final BookRepository repository;

  SearchBooks(this.repository);

  Future<List<Book>> call(String query) async {
    return await repository.searchBooks(query);
  }
}
