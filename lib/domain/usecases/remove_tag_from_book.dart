import 'package:reader/domain/repositories/tag_repository.dart';

class RemoveTagFromBook {
  final TagRepository repository;

  RemoveTagFromBook(this.repository);

  Future<int> call(int bookId, int tagId) {
    return repository.deleteBookTag(bookId, tagId);
  }
}
