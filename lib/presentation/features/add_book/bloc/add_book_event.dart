import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reader/domain/entities/book.dart';

abstract class AddBookEvent extends Equatable {
  const AddBookEvent();

  @override
  List<Object> get props => [];
}

class SearchBookEvent extends AddBookEvent {
  final String query;

  const SearchBookEvent(this.query);

  @override
  List<Object> get props => [query];
}

class AddBookToShelfEvent extends AddBookEvent {
  final Book book;

  final BuildContext context;

  const AddBookToShelfEvent({required this.book, required this.context});

  @override
  List<Object> get props => [book, context];
}
