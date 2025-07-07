import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:reader/core/app/settings_service.dart';
import 'package:reader/data/datasources/local/book_dao.dart';
import 'package:reader/data/datasources/local/book_source_dao.dart';
import 'package:reader/data/datasources/local/book_tag_dao.dart';
import 'package:reader/data/datasources/local/chapter_dao.dart';
import 'package:reader/data/datasources/local/tag_dao.dart';
import 'package:reader/data/datasources/remote/book_remote_data_source.dart';
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
import 'package:reader/domain/usecases/get_book.dart';
import 'package:reader/domain/usecases/get_books.dart';
import 'package:reader/domain/usecases/get_chapters.dart';
import 'package:reader/domain/usecases/remove_tag_from_book.dart';
import 'package:reader/domain/usecases/update_book.dart';
import 'package:reader/domain/usecases/update_book_source.dart';
import 'package:reader/presentation/features/add_book/bloc/add_book_bloc.dart';
import 'package:reader/presentation/features/book_detail/bloc/book_detail_bloc.dart';
import 'package:reader/presentation/features/book_source/bloc/book_source_bloc.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:reader/presentation/features/reader/bloc/reader_bloc.dart';
import 'package:reader/domain/usecases/fetch_chapters.dart';
import 'package:reader/domain/usecases/get_chapter.dart';
import 'package:reader/domain/usecases/search_books.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.headers['User-Agent'] =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36';
    return dio;
  });
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(dio: sl(), bookSourceDao: sl()),
  );

  // Services
  sl.registerLazySingleton(() => SettingsService(sl()));

  // BLoCs
  sl.registerFactory(
    () => BookshelfBloc(getBooks: sl(), addBook: sl(), deleteBook: sl()),
  );
  sl.registerFactory(
    () => BookSourceBloc(
      getBookSources: sl(),
      addBookSource: sl(),
      updateBookSource: sl(),
      deleteBookSource: sl(),
    ),
  );
  sl.registerFactory(
    () => AddBookBloc(searchBooks: sl(), fetchChapters: sl(), addBook: sl()),
  );
  sl.registerFactory(
    () => ReaderBloc(
      getChapter: sl(),
      settingsService: sl(),
      getBook: sl(),
      updateBook: sl(),
      getChapters: sl(),
    ),
  );
  sl.registerFactory(() => BookDetailBloc(getBook: sl(), getChapters: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetBook(sl()));
  sl.registerLazySingleton(() => GetBooks(sl()));
  sl.registerLazySingleton(
    () => AddBook(bookRepository: sl(), chapterRepository: sl()),
  );
  sl.registerLazySingleton(() => UpdateBook(sl()));
  sl.registerLazySingleton(() => DeleteBook(sl()));
  sl.registerLazySingleton(() => GetBookSources(sl()));
  sl.registerLazySingleton(() => AddBookSource(sl()));
  sl.registerLazySingleton(() => UpdateBookSource(sl()));
  sl.registerLazySingleton(() => DeleteBookSource(sl()));
  sl.registerLazySingleton(() => GetChapters(sl()));
  sl.registerLazySingleton(() => AddTagToBook(sl()));
  sl.registerLazySingleton(() => RemoveTagFromBook(sl()));
  sl.registerLazySingleton(() => SearchBooks(sl()));
  sl.registerLazySingleton(() => GetChapter(sl()));
  sl.registerLazySingleton(() => FetchChapters(sl()));

  // Repositories
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(bookDao: sl(), remoteDataSource: sl()),
  );
  sl.registerLazySingleton<BookSourceRepository>(
    () => BookSourceRepositoryImpl(bookSourceDao: sl()),
  );
  sl.registerLazySingleton<ChapterRepository>(
    () => ChapterRepositoryImpl(
      chapterDao: sl(),
      remoteDataSource: sl(),
      bookRepository: sl(),
    ),
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
