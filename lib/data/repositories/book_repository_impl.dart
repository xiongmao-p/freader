import 'package:reader/data/datasources/local/book_dao.dart';
import 'package:reader/data/datasources/remote/book_remote_data_source.dart';
import 'package:reader/data/models/book.dart' as data;
import 'package:reader/domain/entities/book.dart' as domain;
import 'package:reader/domain/entities/chapter.dart' as domain_chapter;
import 'package:reader/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookDao bookDao;
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({required this.bookDao, required this.remoteDataSource});

  @override
  Future<int> addBook(domain.Book book) {
    return bookDao.insertBook(_toData(book));
  }

  @override
  Future<int> deleteBook(int id) {
    return bookDao.deleteBook(id);
  }

  @override
  Future<domain.Book?> getBookById(int id) async {
    final dataBook = await bookDao.findBookById(id);
    return dataBook != null ? _toDomain(dataBook) : null;
  }

  @override
  Future<List<domain.Book>> getBooks() async {
    final dataBooks = await bookDao.findAllBooks();
    return dataBooks.map((e) => _toDomain(e)).toList();
  }

  @override
  Future<int> updateBook(domain.Book book) {
    return bookDao.updateBook(_toData(book));
  }

  @override
  Future<List<domain_chapter.Chapter>> fetchChapters(domain.Book book) async {
    final dataChapters = await remoteDataSource.getChapters(book.url, book);
    return dataChapters
        .map(
          (c) => domain_chapter.Chapter(
            id: c.id ?? 0,
            bookId: c.bookId,
            title: c.title,
            content: '', // Content is loaded on demand
            chapterIndex: c.chapterIndex,
          ),
        )
        .toList();
  }

  @override
  Future<List<domain.Book>> searchBooks(String query) {
    return remoteDataSource.searchBooks(query);
  }

  data.Book _toData(domain.Book domainBook) {
    return data.Book(
      id: domainBook.id,
      bookName: domainBook.title,
      author: domainBook.author,
      coverUrl: domainBook.coverUrl,
      intro: domainBook.description,
      bookUrl: domainBook.url,
      sourceId: domainBook.sourceId,
      lastChapterTitle: '', // This needs to be handled
      currentChapterId: domainBook.lastChapterId,
      readingProgress: domainBook.readingProgress,
      lastReadPosition: domainBook.lastReadPosition,
      addedAt: domainBook.lastReadAt,
    );
  }

  domain.Book _toDomain(data.Book dataBook) {
    return domain.Book(
      id: dataBook.id,
      title: dataBook.bookName,
      author: dataBook.author ?? '',
      coverUrl: dataBook.coverUrl ?? '',
      description: dataBook.intro ?? '',
      url: dataBook.bookUrl ?? '',
      lastChapterId: dataBook.currentChapterId ?? 0,
      lastReadAt: dataBook.addedAt,
      sourceId: dataBook.sourceId,
      readingProgress: dataBook.readingProgress,
      lastReadPosition: dataBook.lastReadPosition,
    );
  }
}
