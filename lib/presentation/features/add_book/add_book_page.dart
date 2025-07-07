import 'package:flutter/material.dart';
import 'package:reader/generated/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reader/core/di/injection_container.dart';
import 'package:reader/presentation/features/add_book/bloc/add_book_bloc.dart';
import 'package:reader/presentation/features/add_book/bloc/add_book_event.dart';
import 'package:reader/presentation/features/add_book/bloc/add_book_state.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_event.dart';

/// 添加书籍页面
class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddBookBloc>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text(AppLocalizations.of(context)!.addBook)),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (query) {
                      // 触发搜索事件
                      context.read<AddBookBloc>().add(SearchBookEvent(query));
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.search,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocConsumer<AddBookBloc, AddBookState>(
                    listener: (context, state) {
                      // 监听成功状态
                      if (state is AddBookSuccess) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                        // 触发书架刷新
                        context.read<BookshelfBloc>().add(LoadBookshelf());
                        // 返回上一页
                        context.pop();
                      }
                      // 监听错误状态
                      else if (state is AddBookError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      // 根据状态显示不同 UI
                      if (state is AddBookLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AddBookInProgress) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AddBookLoaded) {
                        if (state.books.isEmpty) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)!.noResultsFound,
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.books.length,
                          itemBuilder: (context, index) {
                            final book = state.books[index];
                            return ListTile(
                              title: Text(book.title),
                              subtitle: Text(book.author),
                              onTap: () {
                                // 触发添加到书架事件
                                context.read<AddBookBloc>().add(
                                  AddBookToShelfEvent(
                                    book: book,
                                    context: context,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else if (state is AddBookError) {
                        return Center(child: Text(state.message));
                      }
                      return Center(
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.startSearchingToAddBooks,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
