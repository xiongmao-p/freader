import 'package:reader/data/models/tag.dart';

abstract class TagRepository {
  Future<List<Tag>> getTags();

  Future<Tag?> getTagById(int id);

  Future<int> addTag(Tag tag);

  Future<int> deleteTag(int id);

  Future<int> addBookTag(int bookId, int tagId);

  Future<int> deleteBookTag(int bookId, int tagId);

  Future<List<Tag>> getTagsByBookId(int bookId);
}
