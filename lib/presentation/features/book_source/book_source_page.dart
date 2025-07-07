import 'package:flutter/material.dart';
import 'package:reader/generated/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reader/core/di/injection_container.dart';
import 'package:reader/presentation/features/book_source/bloc/book_source_bloc.dart';
import 'package:reader/presentation/features/book_source/bloc/book_source_event.dart';
import 'package:reader/presentation/features/book_source/bloc/book_source_state.dart';
import 'package:reader/data/models/book_source.dart';

class BookSourcePage extends StatelessWidget {
  const BookSourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookSourceBloc>()..add(LoadBookSources()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.bookSources),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddEditBookSourceDialog(context),
            ),
          ],
        ),
        body: BlocBuilder<BookSourceBloc, BookSourceState>(
          builder: (context, state) {
            if (state is BookSourceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookSourceLoaded) {
              if (state.bookSources.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.noBookSourcesYet),
                );
              }
              return ListView.builder(
                itemCount: state.bookSources.length,
                itemBuilder: (context, index) {
                  final source = state.bookSources[index];
                  return ListTile(
                    title: Text(source.name),
                    subtitle: Text(source.url),
                    trailing: Switch(
                      value: source.isEnabled,
                      onChanged: (value) {
                        final updatedSource = source.copyWith(isEnabled: value);
                        context.read<BookSourceBloc>().add(
                          UpdateBookSourceEvent(updatedSource),
                        );
                      },
                    ),
                    onTap: () {
                      _showAddEditBookSourceDialog(context, bookSource: source);
                    },
                    onLongPress: () {
                      _showDeleteConfirmationDialog(context, source);
                    },
                  );
                },
              );
            } else if (state is BookSourceError) {
              return Center(child: Text(state.message));
            }
            return Center(
              child: Text(AppLocalizations.of(context)!.welcomeToBookSources),
            );
          },
        ),
      ),
    );
  }

  void _showAddEditBookSourceDialog(
    BuildContext context, {
    BookSource? bookSource,
  }) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: bookSource?.name);
    final _urlController = TextEditingController(text: bookSource?.url);
    final _rulesController = TextEditingController(text: bookSource?.rules);
    int _sourceType = bookSource?.sourceType ?? 0;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            bookSource == null
                ? AppLocalizations.of(dialogContext)!.addBookSource
                : AppLocalizations.of(dialogContext)!.editBookSource,
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        dialogContext,
                      )!.bookSourceName,
                    ),
                    validator: (value) => value!.isEmpty
                        ? AppLocalizations.of(dialogContext)!.pleaseEnterAName
                        : null,
                  ),
                  TextFormField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        dialogContext,
                      )!.bookSourceUrl,
                    ),
                    validator: (value) => value!.isEmpty
                        ? AppLocalizations.of(dialogContext)!.pleaseEnterAUrl
                        : null,
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return DropdownButtonFormField<int>(
                        value: _sourceType,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(
                            context,
                          )!.bookSourceType,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 0,
                            child: Text(AppLocalizations.of(context)!.html),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text(AppLocalizations.of(context)!.api),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _sourceType = value!;
                          });
                        },
                      );
                    },
                  ),
                  TextFormField(
                    controller: _rulesController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(dialogContext)!.rulesJson,
                    ),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(AppLocalizations.of(dialogContext)!.cancel),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newBookSource = BookSource(
                    id: bookSource?.id,
                    name: _nameController.text,
                    url: _urlController.text,
                    rules: _rulesController.text,
                    sourceType: _sourceType,
                    isEnabled: bookSource?.isEnabled ?? true,
                    lastUpdated: DateTime.now().millisecondsSinceEpoch,
                    createdAt:
                        bookSource?.createdAt ??
                        DateTime.now().millisecondsSinceEpoch,
                  );
                  if (bookSource == null) {
                    context.read<BookSourceBloc>().add(
                      AddBookSourceEvent(newBookSource),
                    );
                  } else {
                    context.read<BookSourceBloc>().add(
                      UpdateBookSourceEvent(newBookSource),
                    );
                  }

                  Navigator.of(dialogContext).pop();
                }
              },
              child: Text(AppLocalizations.of(dialogContext)!.save),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    BookSource bookSource,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(dialogContext)!.deleteBookSource),
          content: Text(
            AppLocalizations.of(
              dialogContext,
            )!.areYouSureYouWantToDeleteSource(bookSource.name),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(AppLocalizations.of(dialogContext)!.cancel),
            ),
            TextButton(
              onPressed: () {
                context.read<BookSourceBloc>().add(
                  DeleteBookSourceEvent(bookSource.id!),
                );
                Navigator.of(dialogContext).pop();
              },
              child: Text(AppLocalizations.of(dialogContext)!.delete),
            ),
          ],
        );
      },
    );
  }
}
