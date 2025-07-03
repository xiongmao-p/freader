import 'package:reader/data/models/chapter.dart';
import 'package:reader/domain/repositories/chapter_repository.dart';

class GetChapters {
  final ChapterRepository repository;

  GetChapters(this.repository);

  Future<List<Chapter>> call(int bookId) {
    return repository.getChaptersByBookId(bookId);
  }
}
