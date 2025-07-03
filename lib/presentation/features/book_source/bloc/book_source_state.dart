import 'package:equatable/equatable.dart';
import 'package:reader/data/models/book_source.dart';

abstract class BookSourceState extends Equatable {
  const BookSourceState();

  @override
  List<Object> get props => [];
}

class BookSourceInitial extends BookSourceState {}

class BookSourceLoading extends BookSourceState {}

class BookSourceLoaded extends BookSourceState {
  final List<BookSource> bookSources;

  const BookSourceLoaded({required this.bookSources});

  @override
  List<Object> get props => [bookSources];
}

class BookSourceError extends BookSourceState {
  final String message;

  const BookSourceError({required this.message});

  @override
  List<Object> get props => [message];
}
