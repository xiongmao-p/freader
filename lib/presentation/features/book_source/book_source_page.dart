import 'package:flutter/material.dart';
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
          title: const Text('Book Sources'),
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
                return const Center(child: Text('No book sources yet.'));
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
            return const Center(child: Text('Welcome to Book Sources!'));
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

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            bookSource == null ? 'Add Book Source' : 'Edit Book Source',
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                ),
                TextFormField(
                  controller: _urlController,
                  decoration: const InputDecoration(labelText: 'URL'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a URL' : null,
                ),
                TextFormField(
                  controller: _rulesController,
                  decoration: const InputDecoration(labelText: 'Rules (JSON)'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newBookSource = BookSource(
                    id: bookSource?.id,
                    name: _nameController.text,
                    url: _urlController.text,
                    rules: _rulesController.text,
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
                    context
                        .read<BookSourceBloc>()
                        .add(UpdateBookSourceEvent(newBookSource));
                  }
                  
                    void _showDeleteConfirmationDialog(
                        BuildContext context, BookSource bookSource) {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text('Delete Book Source'),
                            content:
                                Text('Are you sure you want to delete "${bookSource.name}"?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(dialogContext).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<BookSourceBloc>()
                                      .add(DeleteBookSourceEvent(bookSource.id!));
                                  Navigator.of(dialogContext).pop();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
