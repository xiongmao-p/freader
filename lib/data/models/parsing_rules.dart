import 'dart:convert';

class ParsingRules {
  final SearchRules search;
  final ChapterRules chapters;
  final ContentRules content;

  ParsingRules({
    required this.search,
    required this.chapters,
    required this.content,
  });

  factory ParsingRules.fromJson(String jsonString) {
    final map = json.decode(jsonString);
    return ParsingRules(
      search: SearchRules.fromMap(map['search']),
      chapters: ChapterRules.fromMap(map['chapters']),
      content: ContentRules.fromMap(map['content']),
    );
  }
}

class SearchRules {
  final String bookList;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final String bookUrl;

  SearchRules({
    required this.bookList,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    required this.bookUrl,
  });

  factory SearchRules.fromMap(Map<String, dynamic> map) {
    return SearchRules(
      bookList: map['bookList'],
      title: map['title'],
      author: map['author'],
      coverUrl: map['coverUrl'],
      description: map['description'],
      bookUrl: map['bookUrl'],
    );
  }
}

class ChapterRules {
  final String chapterList;
  final String title;
  final String url;

  ChapterRules({
    required this.chapterList,
    required this.title,
    required this.url,
  });

  factory ChapterRules.fromMap(Map<String, dynamic> map) {
    return ChapterRules(
      chapterList: map['chapterList'],
      title: map['title'],
      url: map['url'],
    );
  }
}

class ContentRules {
  final String title;
  final String content;

  ContentRules({required this.title, required this.content});

  factory ContentRules.fromMap(Map<String, dynamic> map) {
    return ContentRules(title: map['title'], content: map['content']);
  }
}
