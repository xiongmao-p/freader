import 'package:equatable/equatable.dart';
import 'package:reader/data/models/book.dart';

abstract class BookshelfState extends Equatable {
  const BookshelfState();

  @override
  List<Object> get props => [];
}

class BookshelfInitial extends BookshelfState {}

class BookshelfLoading extends BookshelfState {}

class BookshelfLoaded extends BookshelfState {
  final List<Book> books;

  const BookshelfLoaded({required this.books});

  @override
  List<Object> get props => [books];
}

class BookshelfError extends BookshelfState {
  final String message;

  const BookshelfError({required this.message});

  @override
  List<Object> get props => [message];
}
