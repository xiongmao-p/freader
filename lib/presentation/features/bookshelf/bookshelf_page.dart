import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reader/core/di/injection_container.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_bloc.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_event.dart';
import 'package:reader/presentation/features/bookshelf/bloc/bookshelf_state.dart';
import 'package:reader/generated/l10n/app_localizations.dart';

/// 书架页面，展示用户的书籍列表。
class BookshelfPage extends StatefulWidget {
  const BookshelfPage({super.key});

  @override
  State<BookshelfPage> createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  // 标记当前是否处于搜索模式
  bool _isSearching = false;
  // 搜索输入框的控制器
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 构建默认状态下的 AppBar
  AppBar _buildDefaultAppBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppBar(
      title: Text(l10n.bookshelf), // 标题
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.source),
          onPressed: () => context.push('/book-sources'),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.push('/add-book'),
        ),
      ],
    );
  }

  /// 构建搜索状态下的 AppBar
  AppBar _buildSearchAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            _isSearching = false;
            _searchController.clear();
            context.read<BookshelfBloc>().add(const SearchBooksEvent(''));
          });
        },
      ),
      title: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchBooks, // 提示文字
          border: InputBorder.none,
        ),
        onChanged: (query) {
          context.read<BookshelfBloc>().add(SearchBooksEvent(query));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookshelfBloc>()..add(LoadBookshelf()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: _isSearching
                ? _buildSearchAppBar(context)
                : _buildDefaultAppBar(context),
            body: BlocConsumer<BookshelfBloc, BookshelfState>(
              listener: (context, state) {
                // 监听成功状态并显示 SnackBar
                if (state is BookshelfSuccess) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
                // 监听错误状态并显示 SnackBar
                else if (state is BookshelfError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is BookshelfLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookshelfLoaded) {
                  if (state.filteredBooks.isEmpty) {
                    return Center(
                      child: Text(
                        _isSearching
                            ? AppLocalizations.of(context)!.noBooksFound
                            : AppLocalizations.of(context)!.noBooksYet,
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2 / 3.5,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                    itemCount: state.filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = state.filteredBooks[index];
                      return GestureDetector(
                        onTap: () {
                          context.push('/book/${book.id}');
                        },
                        onLongPress: () =>
                            _showDeleteConfirmationDialog(context, book.id!),
                        child: Card(
                          elevation: 4.0,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: book.coverUrl.isNotEmpty
                                    ? Image.network(
                                        book.coverUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return _buildCoverPlaceholder(
                                                book.title,
                                              );
                                            },
                                      )
                                    : _buildCoverPlaceholder(book.title),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                    const SizedBox(height: 4.0),
                                    if (book.readingProgress > 0)
                                      LinearProgressIndicator(
                                        value: book.readingProgress,
                                        backgroundColor: Colors.grey[300],
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is BookshelfError) {
                  // 错误消息现在由 listener 处理，但我们仍然可以在正文中显示一条消息。
                  return Center(child: Text(state.message));
                }
                return Center(
                  child: Text(AppLocalizations.of(context)!.welcomeToFReader),
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// 显示删除确认对话框
  void _showDeleteConfirmationDialog(BuildContext context, int bookId) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(l10n.deleteBook), // 对话框标题
          content: Text(l10n.areYouSureYouWantToDeleteThisBook), // 对话框内容
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel), // 取消按钮
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: Text(l10n.delete), // 删除按钮
              onPressed: () {
                context.read<BookshelfBloc>().add(
                  DeleteBookEvent(bookId: bookId, context: context),
                );
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/// 构建书籍封面的占位符
Widget _buildCoverPlaceholder(String title) {
  return Container(
    color: Colors.grey[800],
    child: Center(
      child: Text(
        title.isNotEmpty ? title[0].toUpperCase() : '?',
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
