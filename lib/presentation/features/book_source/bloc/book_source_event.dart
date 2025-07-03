import 'package:equatable/equatable.dart';
import 'package:reader/data/models/book_source.dart';

abstract class BookSourceEvent extends Equatable {
  const BookSourceEvent();

  @override
  List<Object> get props => [];
}

class LoadBookSources extends BookSourceEvent {}

class AddBookSourceEvent extends BookSourceEvent {
  final BookSource bookSource;

  const AddBookSourceEvent(this.bookSource);

  @override
  List<Object> get props => [bookSource];
}

class UpdateBookSourceEvent extends BookSourceEvent {
  final BookSource bookSource;

  const UpdateBookSourceEvent(this.bookSource);

  @override
  List<Object> get props => [bookSource];
}

class DeleteBookSourceEvent extends BookSourceEvent {
  final int id;

  const DeleteBookSourceEvent(this.id);

  @override
  List<Object> get props => [id];
}
