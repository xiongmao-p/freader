import 'package:equatable/equatable.dart';

abstract class BookDetailEvent extends Equatable {
  const BookDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadBookDetailEvent extends BookDetailEvent {
  final int bookId;

  const LoadBookDetailEvent(this.bookId);

  @override
  List<Object> get props => [bookId];
}
