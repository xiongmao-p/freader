import 'package:go_router/go_router.dart';
import 'package:reader/presentation/features/bookshelf/bookshelf_page.dart';
import 'package:reader/presentation/features/book_source/book_source_page.dart';
import 'package:reader/presentation/features/add_book/add_book_page.dart';
import 'package:reader/presentation/features/book_detail/book_detail_page.dart';
import 'package:reader/presentation/features/reader/reader_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const BookshelfPage()),
    GoRoute(
      path: '/book-sources',
      builder: (context, state) => const BookSourcePage(),
    ),
    GoRoute(
      path: '/add-book',
      builder: (context, state) => const AddBookPage(),
    ),
    GoRoute(
      path: '/book/:bookId',
      builder: (context, state) {
        final bookId = int.parse(state.pathParameters['bookId']!);
        return BookDetailPage(bookId: bookId);
      },
    ),
    GoRoute(
      path: '/reader/:bookId',
      builder: (context, state) {
        final bookId = int.parse(state.pathParameters['bookId']!);
        final chapterId = state.uri.queryParameters['chapterId'];
        return ReaderPage(
          bookId: bookId,
          chapterId: chapterId != null ? int.parse(chapterId) : null,
        );
      },
    ),
  ],
);
