import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reader/data/datasources/local/book_source_dao.dart';
import 'package:reader/data/models/book_source.dart';
import 'package:reader/generated/l10n/app_localizations.dart';
import 'package:reader/core/app/app_theme.dart';
import 'package:reader/core/app/settings_service.dart';
import 'package:reader/core/di/injection_container.dart' as di;
import 'package:reader/core/app/router.dart';
import 'package:reader/core/di/injection_container.dart';

void main() async {
  // 确保 Flutter 绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化依赖注入
  await di.init();

  // Temporary code to add a book source for testing
  await _addTestBookSource();

  // 运行应用
  runApp(const MyApp());
}

Future<void> _addTestBookSource() async {
  final bookSourceDao = sl<BookSourceDao>();

  final existingSource = await bookSourceDao.findBookSourceById(1);
  if (existingSource != null) {
    print('Test book source already exists.');
    return;
  }

  final rules = {
    "search": {
      "bookList": "\$.data[*]",
      "title": "\$.name",
      "author": "\$.author",
      "coverUrl": "http://www.lianjianxsw.com/pic/{{bid}}.jpg",
      "description": "\$.intro",
      "bookUrl": "http://www.lianjianxsw.com/bookInfo?bookid={{bid}}",
    },
    "chapters": {
      "chapterList": "\$.data.list[*]",
      "title": "\$.name",
      "url":
          "http://www.lianjianxsw.com/getContent?bookid={{bid}}&chapterid={{\$._id}}",
    },
    "content": {
      "title": "\$.data.chapterInfo.name",
      "content": "\$.data.chapterInfo.content",
    },
  };

  final bookSource = BookSource(
    id: 1,
    name: '读书阁 (Test)',
    url: 'http://www.lianjianxsw.com/search?keyword={key}',
    rules: json.encode(rules),
    sourceType: 1, // API
    isEnabled: true,
    lastUpdated: DateTime.now().millisecondsSinceEpoch,
    createdAt: DateTime.now().millisecondsSinceEpoch,
  );

  await bookSourceDao.insertBookSource(bookSource);
  print('Test book source added.');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 此小部件是应用的根组件。
  @override
  Widget build(BuildContext context) {
    // 从服务定位器获取 SettingsService 实例
    final settingsService = sl<SettingsService>();

    return MaterialApp.router(
      routerConfig: router,
      title: 'FReader',
      // 本地化代理
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // 设置亮色主题
      theme: AppTheme.lightTheme,
      // 设置暗色主题
      darkTheme: AppTheme.darkTheme,
      // 根据保存的设置加载主题模式
      themeMode: settingsService.loadThemeMode(),
    );
  }
}
