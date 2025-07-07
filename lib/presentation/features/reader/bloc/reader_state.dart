import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reader/domain/entities/chapter.dart';

abstract class ReaderState extends Equatable {
  const ReaderState();

  @override
  List<Object> get props => [];
}

class ReaderInitial extends ReaderState {}

class ReaderLoading extends ReaderState {}

class ReaderLoaded extends ReaderState {
  final Chapter chapter;
  final List<Chapter> chapters;
  final ThemeMode themeMode;
  final double fontSize;

  const ReaderLoaded({
    required this.chapter,
    this.chapters = const [],
    this.themeMode = ThemeMode.light,
    this.fontSize = 16.0,
  });

  ReaderLoaded copyWith({
    Chapter? chapter,
    List<Chapter>? chapters,
    ThemeMode? themeMode,
    double? fontSize,
  }) {
    return ReaderLoaded(
      chapter: chapter ?? this.chapter,
      chapters: chapters ?? this.chapters,
      themeMode: themeMode ?? this.themeMode,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object> get props => [chapter, chapters, themeMode, fontSize];
}

class ReaderError extends ReaderState {
  final String message;

  const ReaderError({required this.message});

  @override
  List<Object> get props => [message];
}
