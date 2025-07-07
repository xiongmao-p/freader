import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reader/domain/entities/book.dart';

abstract class BookshelfEvent extends Equatable {
  const BookshelfEvent();

  @override
  List<Object> get props => [];
}

class LoadBookshelf extends BookshelfEvent {}

class AddBookToBookshelf extends BookshelfEvent {
  final Book book;

  const AddBookToBookshelf(this.book);

  @override
  List<Object> get props => [book];
}

class DeleteBookEvent extends BookshelfEvent {
  final int bookId;

  final BuildContext context;

  const DeleteBookEvent({required this.bookId, required this.context});

  @override
  List<Object> get props => [bookId, context];
}

class SearchBooksEvent extends BookshelfEvent {
  final String query;

  const SearchBooksEvent(this.query);

  @override
  List<Object> get props => [query];
}
