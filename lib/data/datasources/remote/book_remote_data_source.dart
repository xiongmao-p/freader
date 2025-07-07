import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:reader/data/datasources/local/book_source_dao.dart';
import 'package:reader/data/models/chapter.dart' as data_chapter;
import 'package:reader/domain/entities/book.dart' as domain_book;
import 'package:reader/domain/entities/chapter.dart' as domain_chapter;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:reader/data/models/parsing_rules.dart';
import 'package:json_path/json_path.dart';

abstract class BookRemoteDataSource {
  Future<List<domain_book.Book>> searchBooks(String query);
  Future<List<data_chapter.Chapter>> getChapters(
    String url,
    domain_book.Book book,
  );
  Future<domain_chapter.Chapter> getChapterContent(
    String url,
    int chapterIndex,
    domain_book.Book book,
  );
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final Dio dio;
  final BookSourceDao bookSourceDao;

  BookRemoteDataSourceImpl({required this.dio, required this.bookSourceDao});

  String _getHtmlValue(html_dom.Element? element, String rule) {
    if (element == null) return '';
    final parts = rule.split('@');
    final selector = parts[0];
    final attribute = parts.length > 1 ? parts[1] : 'text';

    final targetElement = selector.isEmpty
        ? element
        : element.querySelector(selector);
    if (targetElement == null) return '';

    if (attribute == 'text') {
      return targetElement.text;
    } else {
      return targetElement.attributes[attribute] ?? '';
    }
  }

  String _getJsonValue(dynamic jsonData, String rule) {
    try {
      final jsonPath = JsonPath(rule);
      final match = jsonPath.read(jsonData).first;
      return match.value.toString();
    } catch (e) {
      return '';
    }
  }

  @override
  Future<List<domain_book.Book>> searchBooks(String query) async {
    final enabledSources = await bookSourceDao.findEnabledBookSources();
    final List<domain_book.Book> allBooks = [];

    for (final source in enabledSources) {
      if (source.rules.isEmpty) continue;

      final rules = ParsingRules.fromJson(source.rules).search;
      final searchUrl = source.url.replaceAll('{key}', query);

      try {
        final response = await dio.get(searchUrl);
        if (response.statusCode == 200) {
          if (source.sourceType == 0) {
            // HTML
            final document = html_parser.parse(response.data);
            final bookElements = document.querySelectorAll(rules.bookList);
            for (final element in bookElements) {
              allBooks.add(_parseBookFromHtml(element, rules, source.id!));
            }
          } else {
            // API
            final jsonData = json.decode(response.data);
            final jsonPath = JsonPath(rules.bookList);
            final bookNodes = jsonPath.read(jsonData);
            for (final node in bookNodes) {
              allBooks.add(_parseBookFromJson(node.value, rules, source.id!));
            }
          }
        }
      } catch (e) {
        print('Failed to search on source ${source.name}: $e');
      }
    }
    return allBooks;
  }

  domain_book.Book _parseBookFromHtml(
    html_dom.Element element,
    SearchRules rules,
    int sourceId,
  ) {
    final title = _getHtmlValue(element, rules.title);
    final author = _getHtmlValue(element, rules.author);
    final coverUrl = _getHtmlValue(element, rules.coverUrl);
    final description = _getHtmlValue(element, rules.description);
    final bookUrl = _getHtmlValue(element, rules.bookUrl);
    return domain_book.Book(
      title: title,
      author: author,
      coverUrl: coverUrl,
      description: description,
      url: bookUrl,
      sourceId: sourceId,
      lastChapterId: 0,
      lastReadAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  domain_book.Book _parseBookFromJson(
    dynamic jsonData,
    SearchRules rules,
    int sourceId,
  ) {
    final title = _getJsonValue(jsonData, rules.title);
    final author = _getJsonValue(jsonData, rules.author);
    final coverUrl = _getJsonValue(jsonData, rules.coverUrl);
    final description = _getJsonValue(jsonData, rules.description);
    final bookUrl = _getJsonValue(jsonData, rules.bookUrl);
    return domain_book.Book(
      title: title,
      author: author,
      coverUrl: coverUrl,
      description: description,
      url: bookUrl,
      sourceId: sourceId,
      lastChapterId: 0,
      lastReadAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<List<data_chapter.Chapter>> getChapters(
    String url,
    domain_book.Book book,
  ) async {
    final source = await bookSourceDao.findBookSourceById(book.sourceId);
    if (source == null || source.rules.isEmpty) {
      throw Exception('Book source or rules not found for book ${book.title}');
    }

    final rules = ParsingRules.fromJson(source.rules).chapters;

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final chapters = <data_chapter.Chapter>[];
        if (source.sourceType == 0) {
          // HTML
          final document = html_parser.parse(response.data);
          final chapterElements = document.querySelectorAll(rules.chapterList);
          for (var i = 0; i < chapterElements.length; i++) {
            final element = chapterElements[i];
            chapters.add(
              data_chapter.Chapter(
                bookId: book.id!,
                title: _getHtmlValue(element, rules.title),
                url: _getHtmlValue(element, rules.url),
                isRead: false,
                chapterIndex: i,
              ),
            );
          }
        } else {
          // API
          final jsonData = json.decode(response.data);
          final jsonPath = JsonPath(rules.chapterList);
          final chapterNodes = jsonPath.read(jsonData).toList();
          for (var i = 0; i < chapterNodes.length; i++) {
            final element = chapterNodes[i].value;
            chapters.add(
              data_chapter.Chapter(
                bookId: book.id!,
                title: _getJsonValue(element, rules.title),
                url: _getJsonValue(element, rules.url),
                isRead: false,
                chapterIndex: i,
              ),
            );
          }
        }
        return chapters;
      } else {
        throw Exception('Failed to load chapters');
      }
    } catch (e) {
      throw Exception('Failed to load chapters: $e');
    }
  }

  @override
  Future<domain_chapter.Chapter> getChapterContent(
    String url,
    int chapterIndex,
    domain_book.Book book,
  ) async {
    final source = await bookSourceDao.findBookSourceById(book.sourceId);
    if (source == null || source.rules.isEmpty) {
      throw Exception('Book source or rules not found for book ${book.title}');
    }

    final rules = ParsingRules.fromJson(source.rules).content;

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        String title;
        String content;
        if (source.sourceType == 0) {
          // HTML
          final document = html_parser.parse(response.data);
          title = _getHtmlValue(document.body!, rules.title);
          content = _getHtmlValue(document.body!, rules.content);
        } else {
          // API
          final jsonData = json.decode(response.data);
          title = _getJsonValue(jsonData, rules.title);
          content = _getJsonValue(jsonData, rules.content);
        }

        return domain_chapter.Chapter(
          id: 0,
          bookId: book.id!,
          title: title,
          content: content,
          chapterIndex: chapterIndex,
        );
      } else {
        throw Exception('Failed to load chapter');
      }
    } catch (e) {
      throw Exception('Failed to load chapter: $e');
    }
  }
}
