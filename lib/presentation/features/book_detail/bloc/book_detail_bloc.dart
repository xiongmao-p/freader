import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reader/domain/usecases/get_book.dart';
import 'package:reader/domain/usecases/get_chapters.dart';
import 'package:reader/presentation/features/book_detail/bloc/book_detail_event.dart';
import 'package:reader/presentation/features/book_detail/bloc/book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBook getBook;
  final GetChapters getChapters;

  BookDetailBloc({required this.getBook, required this.getChapters})
    : super(BookDetailInitial()) {
    on<LoadBookDetailEvent>(_onLoadBookDetail);
  }

  void _onLoadBookDetail(
    LoadBookDetailEvent event,
    Emitter<BookDetailState> emit,
  ) async {
    emit(BookDetailLoading());
    try {
      final book = await getBook(event.bookId);
      if (book == null) {
        emit(const BookDetailError(message: 'Book not found'));
        return;
      }

      final chapters = await getChapters(event.bookId);
      emit(BookDetailLoaded(book: book, chapters: chapters));
    } catch (e) {
      emit(BookDetailError(message: e.toString()));
    }
  }
}
