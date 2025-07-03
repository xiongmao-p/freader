import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reader/domain/usecases/get_book_sources.dart';
import 'package:reader/domain/usecases/add_book_source.dart';
import 'package:reader/domain/usecases/update_book_source.dart';
import 'package:reader/domain/usecases/delete_book_source.dart';
import 'book_source_event.dart';
import 'book_source_state.dart';

class BookSourceBloc extends Bloc<BookSourceEvent, BookSourceState> {
  final GetBookSources getBookSources;
  final AddBookSource addBookSource;
  final UpdateBookSource updateBookSource;
  final DeleteBookSource deleteBookSource;

  BookSourceBloc({
    required this.getBookSources,
    required this.addBookSource,
    required this.updateBookSource,
    required this.deleteBookSource,
  }) : super(BookSourceInitial()) {
    on<LoadBookSources>(_onLoadBookSources);
    on<AddBookSourceEvent>(_onAddBookSource);
    on<UpdateBookSourceEvent>(_onUpdateBookSource);
    on<DeleteBookSourceEvent>(_onDeleteBookSource);
  }

  void _onLoadBookSources(
    LoadBookSources event,
    Emitter<BookSourceState> emit,
  ) async {
    emit(BookSourceLoading());
    try {
      final bookSources = await getBookSources();
      emit(BookSourceLoaded(bookSources: bookSources));
    } catch (e) {
      emit(BookSourceError(message: e.toString()));
    }
  }

  void _onAddBookSource(
    AddBookSourceEvent event,
    Emitter<BookSourceState> emit,
  ) async {
    try {
      await addBookSource(event.bookSource);
      add(LoadBookSources());
    } catch (e) {
      emit(BookSourceError(message: e.toString()));
    }
  }

  void _onUpdateBookSource(
    UpdateBookSourceEvent event,
    Emitter<BookSourceState> emit,
  ) async {
    try {
      await updateBookSource(event.bookSource);
      add(LoadBookSources());
    } catch (e) {
      emit(BookSourceError(message: e.toString()));
    }
  }

  void _onDeleteBookSource(
    DeleteBookSourceEvent event,
    Emitter<BookSourceState> emit,
  ) async {
    try {
      await deleteBookSource(event.id);
      add(LoadBookSources());
    } catch (e) {
      emit(BookSourceError(message: e.toString()));
    }
  }
}
