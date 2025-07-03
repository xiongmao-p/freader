import 'package:reader/data/models/book_source.dart';

abstract class BookSourceRepository {
  Future<List<BookSource>> getBookSources();

  Future<BookSource?> getBookSourceById(int id);

  Future<int> addBookSource(BookSource bookSource);

  Future<int> updateBookSource(BookSource bookSource);

  Future<int> deleteBookSource(int id);
}
