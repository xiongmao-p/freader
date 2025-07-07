import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @bookshelf.
  ///
  /// In en, this message translates to:
  /// **'Bookshelf'**
  String get bookshelf;

  /// No description provided for @addBook.
  ///
  /// In en, this message translates to:
  /// **'Add Book'**
  String get addBook;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchBooks.
  ///
  /// In en, this message translates to:
  /// **'Search books...'**
  String get searchBooks;

  /// No description provided for @noBooksFound.
  ///
  /// In en, this message translates to:
  /// **'No books found.'**
  String get noBooksFound;

  /// No description provided for @noBooksYet.
  ///
  /// In en, this message translates to:
  /// **'No books on the shelf yet.'**
  String get noBooksYet;

  /// No description provided for @welcomeToFReader.
  ///
  /// In en, this message translates to:
  /// **'Welcome to FReader!'**
  String get welcomeToFReader;

  /// No description provided for @deleteBook.
  ///
  /// In en, this message translates to:
  /// **'Delete Book'**
  String get deleteBook;

  /// No description provided for @areYouSureYouWantToDeleteThisBook.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this book?'**
  String get areYouSureYouWantToDeleteThisBook;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @bookAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Book added successfully!'**
  String get bookAddedSuccessfully;

  /// No description provided for @bookDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Book deleted successfully!'**
  String get bookDeletedSuccessfully;

  /// No description provided for @failedToAddBook.
  ///
  /// In en, this message translates to:
  /// **'Failed to add book: {error}'**
  String failedToAddBook(Object error);

  /// No description provided for @reader.
  ///
  /// In en, this message translates to:
  /// **'Reader'**
  String get reader;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// No description provided for @bookSources.
  ///
  /// In en, this message translates to:
  /// **'Book Sources'**
  String get bookSources;

  /// No description provided for @addBookSource.
  ///
  /// In en, this message translates to:
  /// **'Add Book Source'**
  String get addBookSource;

  /// No description provided for @editBookSource.
  ///
  /// In en, this message translates to:
  /// **'Edit Book Source'**
  String get editBookSource;

  /// No description provided for @bookSourceName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get bookSourceName;

  /// No description provided for @bookSourceUrl.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get bookSourceUrl;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found.'**
  String get noResultsFound;

  /// No description provided for @startSearchingToAddBooks.
  ///
  /// In en, this message translates to:
  /// **'Start searching to add books.'**
  String get startSearchingToAddBooks;

  /// No description provided for @noBookSourcesYet.
  ///
  /// In en, this message translates to:
  /// **'No book sources yet.'**
  String get noBookSourcesYet;

  /// No description provided for @welcomeToBookSources.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Book Sources!'**
  String get welcomeToBookSources;

  /// No description provided for @pleaseEnterAName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterAName;

  /// No description provided for @pleaseEnterAUrl.
  ///
  /// In en, this message translates to:
  /// **'Please enter a URL'**
  String get pleaseEnterAUrl;

  /// No description provided for @rulesJson.
  ///
  /// In en, this message translates to:
  /// **'Rules (JSON)'**
  String get rulesJson;

  /// No description provided for @deleteBookSource.
  ///
  /// In en, this message translates to:
  /// **'Delete Book Source'**
  String get deleteBookSource;

  /// Confirmation message for deleting a book source
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{sourceName}\"?'**
  String areYouSureYouWantToDeleteSource(String sourceName);

  /// No description provided for @bookSourceType.
  ///
  /// In en, this message translates to:
  /// **'Source Type'**
  String get bookSourceType;

  /// No description provided for @html.
  ///
  /// In en, this message translates to:
  /// **'HTML'**
  String get html;

  /// No description provided for @api.
  ///
  /// In en, this message translates to:
  /// **'API'**
  String get api;

  /// No description provided for @loadingChapter.
  ///
  /// In en, this message translates to:
  /// **'Loading chapter...'**
  String get loadingChapter;

  /// Label for font size slider
  ///
  /// In en, this message translates to:
  /// **'Font Size: {fontSizeValue}'**
  String fontSizeLabel(String fontSizeValue);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
