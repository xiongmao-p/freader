import 'package:equatable/equatable.dart';

abstract class BookshelfEvent extends Equatable {
  const BookshelfEvent();

  @override
  List<Object> get props => [];
}

class LoadBookshelf extends BookshelfEvent {}
