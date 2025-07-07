import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reader/generated/l10n/app_localizations.dart';
import 'package:reader/domain/usecases/get_books.dart';
import 'package:reader/domain/usecases/add_book.dart';
import 'package:reader/domain/usecases/delete_book.dart';
import 'bookshelf_event.dart';
import 'bookshelf_state.dart';

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  final GetBooks getBooks;
  final AddBook addBook;
  final DeleteBook deleteBook;

  BookshelfBloc({
    required this.getBooks,
    required this.addBook,
    required this.deleteBook,
  }) : super(BookshelfInitial()) {
    on<LoadBookshelf>(_onLoadBookshelf);
    on<AddBookToBookshelf>(_onAddBookToBookshelf);
    on<DeleteBookEvent>(_onDeleteBook);
    on<SearchBooksEvent>(_onSearchBooks);
  }

  void _onLoadBookshelf(
    LoadBookshelf event,
    Emitter<BookshelfState> emit,
  ) async {
    emit(BookshelfLoading());
    try {
      final books = await getBooks();
      emit(BookshelfLoaded(masterList: books, filteredBooks: books));
    } catch (e) {
      emit(BookshelfError(message: e.toString()));
    }
  }

  void _onAddBookToBookshelf(
    AddBookToBookshelf event,
    Emitter<BookshelfState> emit,
  ) async {
    try {
      await addBook(event.book);
      emit(const BookshelfSuccess(message: 'Book added successfully!'));
      add(LoadBookshelf());
    } catch (e) {
      emit(BookshelfError(message: e.toString()));
    }
  }

  void _onDeleteBook(
    DeleteBookEvent event,
    Emitter<BookshelfState> emit,
  ) async {
    try {
      await deleteBook(event.bookId);
      final l10n = AppLocalizations.of(event.context)!;
      emit(BookshelfSuccess(message: l10n.bookDeletedSuccessfully));
      add(LoadBookshelf());
    } catch (e) {
      emit(BookshelfError(message: e.toString()));
    }
  }

  void _onSearchBooks(SearchBooksEvent event, Emitter<BookshelfState> emit) {
    if (state is BookshelfLoaded) {
      final currentState = state as BookshelfLoaded;
      if (event.query.isEmpty) {
        emit(currentState.copyWith(filteredBooks: currentState.masterList));
      } else {
        final filteredList = currentState.masterList
            .where(
              (book) =>
                  book.title.toLowerCase().contains(event.query.toLowerCase()),
            )
            .toList();
        emit(currentState.copyWith(filteredBooks: filteredList));
      }
    }
  }
}
