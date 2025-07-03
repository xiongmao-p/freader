import 'package:reader/domain/repositories/tag_repository.dart';

class AddTagToBook {
  final TagRepository repository;

  AddTagToBook(this.repository);

  Future<int> call(int bookId, int tagId) {
    return repository.addBookTag(bookId, tagId);
  }
}
