import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reader/domain/usecases/get_books.dart';
import 'bookshelf_event.dart';
import 'bookshelf_state.dart';

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  final GetBooks getBooks;

  BookshelfBloc({required this.getBooks}) : super(BookshelfInitial()) {
    on<LoadBookshelf>((event, emit) async {
      emit(BookshelfLoading());
      try {
        final books = await getBooks();
        emit(BookshelfLoaded(books: books));
      } catch (e) {
        emit(BookshelfError(message: e.toString()));
      }
    });
  }
}
