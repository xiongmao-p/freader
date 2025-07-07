import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reader/generated/l10n/app_localizations.dart';
import 'package:reader/domain/usecases/add_book.dart';
import 'package:reader/domain/usecases/fetch_chapters.dart';
import 'package:reader/domain/usecases/search_books.dart';
import 'add_book_event.dart';
import 'add_book_state.dart';

class AddBookBloc extends Bloc<AddBookEvent, AddBookState> {
  final SearchBooks searchBooks;
  final FetchChapters fetchChapters;
  final AddBook addBook;

  AddBookBloc({
    required this.searchBooks,
    required this.fetchChapters,
    required this.addBook,
  }) : super(AddBookInitial()) {
    on<SearchBookEvent>(_onSearchBook);
    on<AddBookToShelfEvent>(_onAddBookToShelf);
  }

  void _onSearchBook(SearchBookEvent event, Emitter<AddBookState> emit) async {
    emit(AddBookLoading());
    try {
      final books = await searchBooks(event.query);
      emit(AddBookLoaded(books: books));
    } catch (e) {
      emit(AddBookError(message: e.toString()));
    }
  }

  void _onAddBookToShelf(
    AddBookToShelfEvent event,
    Emitter<AddBookState> emit,
  ) async {
    final currentState = state;
    emit(AddBookInProgress());
    try {
      await addBook(event.book);

      final l10n = AppLocalizations.of(event.context)!;
      emit(AddBookSuccess(message: l10n.bookAddedSuccessfully));

      // Restore the previous search results state after success
      if (currentState is AddBookLoaded) {
        emit(currentState);
      }
    } catch (e) {
      final l10n = AppLocalizations.of(event.context)!;
      emit(AddBookError(message: l10n.failedToAddBook(e.toString())));
      // If there was an error, restore the previous loaded state if it exists
      if (currentState is AddBookLoaded) {
        emit(currentState);
      }
    }
  }
}
