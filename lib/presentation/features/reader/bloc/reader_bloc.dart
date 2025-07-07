import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reader/core/app/settings_service.dart';
import 'package:reader/domain/usecases/get_book.dart';
import 'package:reader/domain/usecases/get_chapter.dart';
import 'package:reader/domain/usecases/get_chapters.dart';
import 'package:reader/domain/usecases/update_book.dart';
import 'package:reader/domain/entities/chapter.dart';
import 'reader_event.dart';
import 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  final GetChapter getChapter;
  final GetBook getBook;
  final UpdateBook updateBook;
  final GetChapters getChapters;
  final SettingsService settingsService;

  ReaderBloc({
    required this.getChapter,
    required this.getBook,
    required this.updateBook,
    required this.getChapters,
    required this.settingsService,
  }) : super(ReaderInitial()) {
    on<LoadChapterEvent>(_onLoadChapter);
    on<ChangeThemeEvent>(_onChangeTheme);
    on<ChangeFontSizeEvent>(_onChangeFontSize);
    on<UpdateReadingProgressEvent>(_onUpdateReadingProgress);
  }

  void _onLoadChapter(LoadChapterEvent event, Emitter<ReaderState> emit) async {
    final currentState = state;
    emit(ReaderLoading());
    try {
      final chapterFuture = getChapter(
        bookId: event.bookId,
        chapterId: event.chapterId,
      );

      // Fetch all chapters only if not already loaded
      final chaptersFuture = currentState is ReaderLoaded
          ? Future.value(currentState.chapters)
          : getChapters(event.bookId);

      final results = await Future.wait([chapterFuture, chaptersFuture]);
      final chapter = results[0] as Chapter?;
      final chapters = results[1] as List<Chapter>;

      if (chapter != null) {
        if (currentState is ReaderLoaded) {
          emit(currentState.copyWith(chapter: chapter, chapters: chapters));
        } else {
          // First time loading, get settings from service
          final themeMode = settingsService.loadThemeMode();
          final fontSize = settingsService.loadFontSize();
          emit(
            ReaderLoaded(
              chapter: chapter,
              chapters: chapters,
              themeMode: themeMode,
              fontSize: fontSize,
            ),
          );
        }
      } else {
        emit(const ReaderError(message: 'Chapter not found'));
      }
    } catch (e) {
      emit(ReaderError(message: e.toString()));
    }
  }

  void _onChangeTheme(ChangeThemeEvent event, Emitter<ReaderState> emit) async {
    if (state is ReaderLoaded) {
      final currentState = state as ReaderLoaded;
      await settingsService.saveThemeMode(event.themeMode);
      emit(currentState.copyWith(themeMode: event.themeMode));
    }
  }

  void _onChangeFontSize(
    ChangeFontSizeEvent event,
    Emitter<ReaderState> emit,
  ) async {
    if (state is ReaderLoaded) {
      final currentState = state as ReaderLoaded;
      await settingsService.saveFontSize(event.fontSize);
      emit(currentState.copyWith(fontSize: event.fontSize));
    }
  }
  void _onUpdateReadingProgress(
    UpdateReadingProgressEvent event,
    Emitter<ReaderState> emit,
  ) async {
    final book = await getBook(event.bookId);
    if (book != null) {
      final chapters = await getChapters(event.bookId);
      final totalChapters = chapters.length;
      final currentChapter = await getChapter(
        bookId: event.bookId,
        chapterId: event.chapterId,
      );

      if (currentChapter != null && totalChapters > 0) {
        final progress = currentChapter.chapterIndex / totalChapters;
        final updatedBook = book.copyWith(
          lastChapterId: event.chapterId,
          lastReadPosition: event.position,
          readingProgress: progress,
          lastReadAt: DateTime.now().millisecondsSinceEpoch,
        );
        await updateBook(updatedBook);
      }
    }
  }
}
