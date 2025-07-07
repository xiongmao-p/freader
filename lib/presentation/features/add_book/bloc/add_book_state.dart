import 'package:equatable/equatable.dart';
import 'package:reader/domain/entities/book.dart';

abstract class AddBookState extends Equatable {
  const AddBookState();

  @override
  List<Object> get props => [];
}

class AddBookInitial extends AddBookState {}

class AddBookLoading extends AddBookState {}

class AddBookInProgress extends AddBookState {}

class AddBookSuccess extends AddBookState {
  final String message;

  const AddBookSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AddBookLoaded extends AddBookState {
  final List<Book> books;

  const AddBookLoaded({required this.books});

  @override
  List<Object> get props => [books];
}

class AddBookError extends AddBookState {
  final String message;

  const AddBookError({required this.message});

  @override
  List<Object> get props => [message];
}
