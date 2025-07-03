import 'package:get_it/get_it.dart';
import 'package:reader/data/datasources/local/book_dao.dart';
import 'package:reader/data/datasources/local/book_source_dao.dart';
import 'package:reader/data/datasources/local/book_tag_dao.dart';
import 'package:reader/data/datasources/local/chapter_dao.dart';
import 'package:reader/data/datasources/local/tag_dao.dart';
import 'package:reader/data/repositories/book_repository_impl.dart';
import 'package:reader/data/repositories/book_source_repository_impl.dart';
import 'package:reader/data/repositories/chapter_repository_impl.dart';
import 'package:reader/data/repositories/tag_repository_impl.dart';
import 'package:reader/domain/repositories/book_repository.dart';
import 'package:reader/domain/repositories/book_source_repository.dart';
import 'package:reader/domain/repositories/chapter_repository.dart';
import 'package:reader/domain/repositories/tag_repository.dart';
import 'package:reader/domain/usecases/add_book.dart';
import 'package:reader/domain/usecases/add_book_source.dart';
import 'package:reader/domain/usecases/add_tag_to_book.dart';
import 'package:reader/domain/usecases/delete_book.dart';
import 'package:reader/domain/usecases/delete_book_source.dart';
import 'package:reader/domain/usecases/get_book_sources.dart';
import 'package:reader/domain/usecases/get_books.dart';
import 'package:reader/domain/usecases/get_chapters.dart';
import 'package:reader/domain/usecases/remove_tag_from_book.dart';
import 'package:reader/domain/usecases/update_book.dart';
import 'package:reader/domain/usecases/update_book_source.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:reader/presentation/features/book_source/bloc/book_source_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs
  sl.registerFactory(() => BookshelfBloc(getBooks: sl()));
  sl.registerFactory(
    () => BookSourceBloc(
      getBookSources: sl(),
      addBookSource: sl(),
      updateBookSource: sl(),
      deleteBookSource: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetBooks(sl()));
  sl.registerLazySingleton(() => AddBook(sl()));
  sl.registerLazySingleton(() => UpdateBook(sl()));
  sl.registerLazySingleton(() => DeleteBook(sl()));
  sl.registerLazySingleton(() => GetBookSources(sl()));
  sl.registerLazySingleton(() => AddBookSource(sl()));
  sl.registerLazySingleton(() => UpdateBookSource(sl()));
  sl.registerLazySingleton(() => DeleteBookSource(sl()));
  sl.registerLazySingleton(() => GetChapters(sl()));
  sl.registerLazySingleton(() => AddTagToBook(sl()));
  sl.registerLazySingleton(() => RemoveTagFromBook(sl()));

  // Repositories
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(bookDao: sl()),
  );
  sl.registerLazySingleton<BookSourceRepository>(
    () => BookSourceRepositoryImpl(bookSourceDao: sl()),
  );
  sl.registerLazySingleton<ChapterRepository>(
    () => ChapterRepositoryImpl(chapterDao: sl()),
  );
  sl.registerLazySingleton<TagRepository>(
    () => TagRepositoryImpl(tagDao: sl(), bookTagDao: sl()),
  );

  // DAOs
  sl.registerLazySingleton(() => BookDao());
  sl.registerLazySingleton(() => BookSourceDao());
  sl.registerLazySingleton(() => ChapterDao());
  sl.registerLazySingleton(() => TagDao());
  sl.registerLazySingleton(() => BookTagDao());
}
