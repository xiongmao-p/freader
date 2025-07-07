import 'package:equatable/equatable.dart';
import 'package:reader/domain/entities/book.dart';
import 'package:reader/domain/entities/chapter.dart';

abstract class BookDetailState extends Equatable {
  const BookDetailState();

  @override
  List<Object> get props => [];
}

class BookDetailInitial extends BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  final Book book;
  final List<Chapter> chapters;

  const BookDetailLoaded({required this.book, required this.chapters});

  @override
  List<Object> get props => [book, chapters];
}

class BookDetailError extends BookDetailState {
  final String message;

  const BookDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
