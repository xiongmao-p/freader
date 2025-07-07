import 'package:equatable/equatable.dart';
import 'package:reader/domain/entities/book.dart';

abstract class BookshelfState extends Equatable {
  const BookshelfState();

  @override
  List<Object> get props => [];
}

class BookshelfInitial extends BookshelfState {}

class BookshelfLoading extends BookshelfState {}

class BookshelfLoaded extends BookshelfState {
  final List<Book> masterList;
  final List<Book> filteredBooks;

  const BookshelfLoaded({
    required this.masterList,
    required this.filteredBooks,
  });

  BookshelfLoaded copyWith({
    List<Book>? masterList,
    List<Book>? filteredBooks,
  }) {
    return BookshelfLoaded(
      masterList: masterList ?? this.masterList,
      filteredBooks: filteredBooks ?? this.filteredBooks,
    );
  }

  @override
  List<Object> get props => [masterList, filteredBooks];
}

class BookshelfError extends BookshelfState {
  final String message;

  const BookshelfError({required this.message});

  @override
  List<Object> get props => [message];
}

class BookshelfSuccess extends BookshelfState {
  final String message;

  const BookshelfSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
