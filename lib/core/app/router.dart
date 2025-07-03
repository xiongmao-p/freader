import 'package:go_router/go_router.dart';
import 'package:reader/presentation/features/bookshelf/bookshelf_page.dart';
import 'package:reader/presentation/features/book_source/book_source_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const BookshelfPage()),
    GoRoute(
      path: '/book-sources',
      builder: (context, state) => const BookSourcePage(),
    ),
  ],
);
