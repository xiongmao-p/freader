import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reader/core/di/injection_container.dart';
import 'package:reader/domain/entities/book.dart';
import 'package:reader/presentation/features/book_detail/bloc/book_detail_bloc.dart';
import 'package:reader/presentation/features/book_detail/bloc/book_detail_event.dart';
import 'package:reader/presentation/features/book_detail/bloc/book_detail_state.dart';

class BookDetailPage extends StatelessWidget {
  final int bookId;

  const BookDetailPage({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookDetailBloc>()..add(LoadBookDetailEvent(bookId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Book Details')),
        body: BlocBuilder<BookDetailBloc, BookDetailState>(
          builder: (context, state) {
            if (state is BookDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookDetailLoaded) {
              return _buildBookDetail(context, state.book, state.chapters);
            } else if (state is BookDetailError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No book data.'));
          },
        ),
      ),
    );
  }

  Widget _buildBookDetail(
    BuildContext context,
    Book book,
    List<dynamic> chapters,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (book.coverUrl.isNotEmpty)
                  Image.network(
                    book.coverUrl,
                    height: 150,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        book.author,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(book.description),
            const SizedBox(height: 16),
            Text('Chapters', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                return ListTile(
                  title: Text(chapter.title),
                  onTap: () {
                    context.push('/reader/${book.id}?chapterId=${chapter.id}');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
