class Chapter {
  final int? id;
  final int bookId;
  final int chapterIndex;
  final String title;
  final String url;
  final String? contentCachedPath;
  final bool isRead;

  Chapter({
    this.id,
    required this.bookId,
    required this.chapterIndex,
    required this.title,
    required this.url,
    this.contentCachedPath,
    required this.isRead,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'chapterIndex': chapterIndex,
      'title': title,
      'url': url,
      'contentCachedPath': contentCachedPath,
      'isRead': isRead ? 1 : 0,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'],
      bookId: map['bookId'],
      chapterIndex: map['chapterIndex'],
      title: map['title'],
      url: map['url'],
      contentCachedPath: map['contentCachedPath'],
      isRead: map['isRead'] == 1,
    );
  }
}
