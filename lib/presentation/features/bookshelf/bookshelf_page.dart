import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reader/core/di/injection_container.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_event.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_state.dart';

class BookshelfPage extends StatelessWidget {
  const BookshelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookshelfBloc>()..add(LoadBookshelf()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookshelf'),
          actions: [
            IconButton(
              icon: const Icon(Icons.source),
              onPressed: () => context.push('/book-sources'),
            ),
          ],
        ),
        body: BlocBuilder<BookshelfBloc, BookshelfState>(
          builder: (context, state) {
            if (state is BookshelfLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookshelfLoaded) {
              if (state.books.isEmpty) {
                return const Center(child: Text('No books yet.'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: book.coverUrl != null
                              ? Image.network(book.coverUrl!, fit: BoxFit.cover)
                              : Container(color: Colors.grey),
                        ),
                        Text(
                          book.bookName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is BookshelfError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Welcome to FReader!'));
          },
        ),
      ),
    );
  }
}
