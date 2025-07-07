import 'package:flutter/material.dart';
import 'package:reader/generated/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reader/core/di/injection_container.dart';
import 'package:reader/domain/entities/chapter.dart';
import 'package:reader/presentation/features/reader/bloc/reader_bloc.dart';
import 'package:reader/presentation/features/reader/bloc/reader_event.dart';
import 'package:reader/presentation/features/reader/bloc/reader_state.dart';

class ReaderPage extends StatefulWidget {
  final int bookId;
  final int? chapterId;

  const ReaderPage({super.key, required this.bookId, this.chapterId});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isUIVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      // To prevent dispatching event when at the top
      if (_scrollController.position.pixels == 0) return;
    }

    final readerBloc = context.read<ReaderBloc>();
    if (readerBloc.state is ReaderLoaded) {
      final loadedState = readerBloc.state as ReaderLoaded;
      readerBloc.add(
        UpdateReadingProgressEvent(
          bookId: widget.bookId,
          chapterId: loadedState.chapter.id,
          position: _scrollController.position.pixels,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReaderBloc>()
        ..add(
          LoadChapterEvent(
            bookId: widget.bookId,
            chapterId: widget.chapterId ?? 1,
          ),
        ),
      child: BlocConsumer<ReaderBloc, ReaderState>(
        listener: (context, state) {
          if (state is ReaderLoaded) {
            final book = context.read<ReaderBloc>().getBook(widget.bookId);
            book.then((b) {
              if (b != null && b.lastChapterId == state.chapter.id) {
                _scrollController.animateTo(
                  b.lastReadPosition,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: _isUIVisible
                ? AppBar(
                    title: Text(AppLocalizations.of(context)!.reader), // 标题
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.list),
                        onPressed: () {
                          if (context.read<ReaderBloc>().state
                              is ReaderLoaded) {
                            _showChapterList(context, widget.bookId);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          if (context.read<ReaderBloc>().state
                              is ReaderLoaded) {
                            _showSettingsMenu(context);
                          }
                        },
                      ),
                    ],
                  )
                : null,
            body: GestureDetector(
              onTapUp: (details) => _onTap(context, details),
              child: BlocBuilder<ReaderBloc, ReaderState>(
                builder: (context, state) {
                  if (state is ReaderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ReaderLoaded) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.chapter.title,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontSize: state.fontSize + 4),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            state.chapter.content,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontSize: state.fontSize),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ReaderError) {
                    return Center(child: Text(state.message));
                  }
                  return Center(
                    child: Text(AppLocalizations.of(context)!.loadingChapter),
                  );
                },
              ),
            ),
            bottomNavigationBar: _isUIVisible
                ? BottomAppBar(
                    child: Container(height: 48.0), // Placeholder for height
                  )
                : null,
          );
        },
      ),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    final readerBloc = context.read<ReaderBloc>();

    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return BlocProvider.value(
          value: readerBloc,
          child: BlocBuilder<ReaderBloc, ReaderState>(
            builder: (context, state) {
              if (state is! ReaderLoaded) return const SizedBox.shrink();
              return Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.brightness_6),
                    title: Text(AppLocalizations.of(ctx)!.theme),
                    trailing: DropdownButton<ThemeMode>(
                      value: state.themeMode,
                      items: [
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text(AppLocalizations.of(ctx)!.light),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text(AppLocalizations.of(ctx)!.dark),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          readerBloc.add(ChangeThemeEvent(value));
                        }
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.font_download),
                    title: Text(
                      AppLocalizations.of(
                        ctx,
                      )!.fontSizeLabel(state.fontSize.toStringAsFixed(1)),
                    ),
                  ),
                  Slider(
                    value: state.fontSize,
                    min: 10.0,
                    max: 30.0,
                    divisions: 20,
                    label: state.fontSize.toStringAsFixed(1),
                    onChanged: (value) {
                      readerBloc.add(ChangeFontSizeEvent(value));
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context, TapUpDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tapPosition = details.globalPosition.dx;
    final readerBloc = context.read<ReaderBloc>();
    final state = readerBloc.state;

    if (state is ReaderLoaded) {
      if (tapPosition < screenWidth / 3) {
        // Tap on the left side
        if (state.chapter.chapterIndex > 1) {
          readerBloc.add(
            LoadChapterEvent(
              bookId: widget.bookId,
              chapterId: state.chapter.chapterIndex - 1,
            ),
          );
        }
      } else if (tapPosition > screenWidth * 2 / 3) {
        // Tap on the right side
        readerBloc.add(
          LoadChapterEvent(
            bookId: widget.bookId,
            chapterId: state.chapter.chapterIndex + 1,
          ),
        );
      } else {
        // Tap in the middle
        setState(() {
          _isUIVisible = !_isUIVisible;
        });
      }
    }
  }
}

void _showChapterList(BuildContext context, int bookId) {
  final readerBloc = context.read<ReaderBloc>();
  final state = readerBloc.state;

  if (state is! ReaderLoaded) return;

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return BlocProvider.value(
        value: readerBloc,
        child: DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: state.chapters.length,
              itemBuilder: (context, index) {
                final chapter = state.chapters[index];
                return ListTile(
                  title: Text(chapter.title),
                  onTap: () {
                    readerBloc.add(
                      LoadChapterEvent(bookId: bookId, chapterId: chapter.id),
                    );
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        ),
      );
    },
  );
}
