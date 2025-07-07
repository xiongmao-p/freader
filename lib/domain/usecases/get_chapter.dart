import 'package:reader/domain/entities/chapter.dart';
import 'package:reader/domain/repositories/chapter_repository.dart';

class GetChapter {
  final ChapterRepository repository;

  GetChapter(this.repository);

  Future<Chapter?> call({required int bookId, required int chapterId}) {
    return repository.getChapterById(chapterId, bookId);
  }
}
