// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get bookshelf => 'Bookshelf';

  @override
  String get addBook => 'Add Book';

  @override
  String get search => 'Search';

  @override
  String get searchBooks => 'Search books...';

  @override
  String get noBooksFound => 'No books found.';

  @override
  String get noBooksYet => 'No books on the shelf yet.';

  @override
  String get welcomeToFReader => 'Welcome to FReader!';

  @override
  String get deleteBook => 'Delete Book';

  @override
  String get areYouSureYouWantToDeleteThisBook =>
      'Are you sure you want to delete this book?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get bookAddedSuccessfully => 'Book added successfully!';

  @override
  String get bookDeletedSuccessfully => 'Book deleted successfully!';

  @override
  String failedToAddBook(Object error) {
    return 'Failed to add book: $error';
  }

  @override
  String get reader => 'Reader';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get fontSize => 'Font Size';

  @override
  String get chapters => 'Chapters';

  @override
  String get bookSources => 'Book Sources';

  @override
  String get addBookSource => 'Add Book Source';

  @override
  String get editBookSource => 'Edit Book Source';

  @override
  String get bookSourceName => 'Name';

  @override
  String get bookSourceUrl => 'URL';

  @override
  String get save => 'Save';

  @override
  String get noResultsFound => 'No results found.';

  @override
  String get startSearchingToAddBooks => 'Start searching to add books.';

  @override
  String get noBookSourcesYet => 'No book sources yet.';

  @override
  String get welcomeToBookSources => 'Welcome to Book Sources!';

  @override
  String get pleaseEnterAName => 'Please enter a name';

  @override
  String get pleaseEnterAUrl => 'Please enter a URL';

  @override
  String get rulesJson => 'Rules (JSON)';

  @override
  String get deleteBookSource => 'Delete Book Source';

  @override
  String areYouSureYouWantToDeleteSource(String sourceName) {
    return 'Are you sure you want to delete \"$sourceName\"?';
  }

  @override
  String get bookSourceType => 'Source Type';

  @override
  String get html => 'HTML';

  @override
  String get api => 'API';

  @override
  String get loadingChapter => 'Loading chapter...';

  @override
  String fontSizeLabel(String fontSizeValue) {
    return 'Font Size: $fontSizeValue';
  }
}
