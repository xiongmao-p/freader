import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  final int id;
  final int bookId;
  final String title;
  final String content;
  final int chapterIndex;

  const Chapter({
    required this.id,
    required this.bookId,
    required this.title,
    required this.content,
    required this.chapterIndex,
  });

  Chapter copyWith({
    int? id,
    int? bookId,
    String? title,
    String? content,
    int? chapterIndex,
  }) {
    return Chapter(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      content: content ?? this.content,
      chapterIndex: chapterIndex ?? this.chapterIndex,
    );
  }

  @override
  List<Object?> get props => [id, bookId, title, content, chapterIndex];
}
