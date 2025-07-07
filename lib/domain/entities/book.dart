import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final int? id;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final String url;
  final int lastChapterId;
  final int lastReadAt;
  final int sourceId;
  final double readingProgress;
  final double lastReadPosition;

  const Book({
    this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    required this.url,
    required this.lastChapterId,
    required this.lastReadAt,
    required this.sourceId,
    this.readingProgress = 0.0,
    this.lastReadPosition = 0.0,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    author,
    coverUrl,
    description,
    url,
    lastChapterId,
    lastReadAt,
    sourceId,
    readingProgress,
    lastReadPosition,
  ];
  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? coverUrl,
    String? description,
    String? url,
    int? lastChapterId,
    int? lastReadAt,
    int? sourceId,
    double? readingProgress,
    double? lastReadPosition,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      description: description ?? this.description,
      url: url ?? this.url,
      lastChapterId: lastChapterId ?? this.lastChapterId,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      sourceId: sourceId ?? this.sourceId,
      readingProgress: readingProgress ?? this.readingProgress,
      lastReadPosition: lastReadPosition ?? this.lastReadPosition,
    );
  }
}
