import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ReaderEvent extends Equatable {
  const ReaderEvent();

  @override
  List<Object> get props => [];
}

class LoadChapterEvent extends ReaderEvent {
  final int bookId;
  final int chapterId;

  const LoadChapterEvent({required this.bookId, required this.chapterId});

  @override
  List<Object> get props => [bookId, chapterId];
}

class ChangeThemeEvent extends ReaderEvent {
  final ThemeMode themeMode;

  const ChangeThemeEvent(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ChangeFontSizeEvent extends ReaderEvent {
  final double fontSize;

  const ChangeFontSizeEvent(this.fontSize);

  @override
  List<Object> get props => [fontSize];
}

class UpdateReadingProgressEvent extends ReaderEvent {
  final int bookId;
  final int chapterId;
  final double position;

  const UpdateReadingProgressEvent({
    required this.bookId,
    required this.chapterId,
    required this.position,
  });

  @override
  List<Object> get props => [bookId, chapterId, position];
}
