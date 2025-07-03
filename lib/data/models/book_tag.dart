class BookTag {
  final int bookId;
  final int tagId;

  BookTag({required this.bookId, required this.tagId});

  Map<String, dynamic> toMap() {
    return {'bookId': bookId, 'tagId': tagId};
  }

  factory BookTag.fromMap(Map<String, dynamic> map) {
    return BookTag(bookId: map['bookId'], tagId: map['tagId']);
  }
}
