import 'package:reader/domain/entities/book.dart';
import 'package:reader/domain/repositories/book_repository.dart';
import 'package:reader/domain/repositories/chapter_repository.dart';

class AddBook {
  final BookRepository bookRepository;
  final ChapterRepository chapterRepository;

  AddBook({required this.bookRepository, required this.chapterRepository});

  Future<void> call(Book book) async {
    // 1. Save the book to get its ID
    final bookId = await bookRepository.addBook(book);

    // 2. Fetch the chapters for the book
    final chapters = await bookRepository.fetchChapters(book);

    // 3. Associate the bookId with each chapter
    final chaptersWithBookId = chapters
        .map((chapter) => chapter.copyWith(bookId: bookId))
        .toList();

    // 4. Batch insert the chapters
    await chapterRepository.addChapters(chaptersWithBookId);
  }
}
