import 'package:reader/data/datasources/local/tag_dao.dart';
import 'package:reader/data/datasources/local/book_tag_dao.dart';
import 'package:reader/data/models/book_tag.dart';
import 'package:reader/data/models/tag.dart';
import 'package:reader/domain/repositories/tag_repository.dart';

class TagRepositoryImpl implements TagRepository {
  final TagDao tagDao;
  final BookTagDao bookTagDao;

  TagRepositoryImpl({required this.tagDao, required this.bookTagDao});

  @override
  Future<int> addTag(Tag tag) {
    return tagDao.insertTag(tag);
  }

  @override
  Future<int> deleteTag(int id) {
    return tagDao.deleteTag(id);
  }

  @override
  Future<Tag?> getTagById(int id) {
    return tagDao.findTagById(id);
  }

  @override
  Future<List<Tag>> getTags() {
    return tagDao.findAllTags();
  }

  @override
  Future<int> addBookTag(int bookId, int tagId) {
    return bookTagDao.insertBookTag(BookTag(bookId: bookId, tagId: tagId));
  }

  @override
  Future<int> deleteBookTag(int bookId, int tagId) {
    return bookTagDao.deleteBookTag(bookId, tagId);
  }

  @override
  Future<List<Tag>> getTagsByBookId(int bookId) async {
    final bookTags = await bookTagDao.findTagsByBookId(bookId);
    final tagIds = bookTags.map((bt) => bt.tagId).toList();
    if (tagIds.isEmpty) {
      return [];
    }
    final tags = <Tag>[];
    for (var tagId in tagIds) {
      final tag = await tagDao.findTagById(tagId);
      if (tag != null) {
        tags.add(tag);
      }
    }
    return tags;
  }
}
