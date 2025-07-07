class Book {
  final int? id;
  final String bookName;
  final String? author;
  final String? coverUrl;
  final String? intro;
  final String bookUrl;
  final int sourceId;
  final String? lastChapterTitle;
  final int? currentChapterId;
  final double readingProgress;
  final int addedAt;
  final double lastReadPosition;

  Book({
    this.id,
    required this.bookName,
    this.author,
    this.coverUrl,
    this.intro,
    required this.bookUrl,
    required this.sourceId,
    this.lastChapterTitle,
    this.currentChapterId,
    required this.readingProgress,
    required this.addedAt,
    this.lastReadPosition = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookName': bookName,
      'author': author,
      'coverUrl': coverUrl,
      'intro': intro,
      'bookUrl': bookUrl,
      'sourceId': sourceId,
      'lastChapterTitle': lastChapterTitle,
      'currentChapterId': currentChapterId,
      'readingProgress': readingProgress,
      'addedAt': addedAt,
      'lastReadPosition': lastReadPosition,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      bookName: map['bookName'],
      author: map['author'],
      coverUrl: map['coverUrl'],
      intro: map['intro'],
      bookUrl: map['bookUrl'],
      sourceId: map['sourceId'],
      lastChapterTitle: map['lastChapterTitle'],
      currentChapterId: map['currentChapterId'],
      readingProgress: map['readingProgress'],
      addedAt: map['addedAt'],
      lastReadPosition: map['lastReadPosition'] ?? 0.0,
    );
  }
}
