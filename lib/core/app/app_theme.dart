import 'package:flutter/material.dart';

/// 应用的主题类，用于定义亮色和暗色主题。
class AppTheme {
  // 私有构造函数，防止外部实例化。
  AppTheme._();

  /// 亮色主题
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    ).copyWith(secondary: Colors.amber),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16.0),
    ),
  );

  /// 暗色主题
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    ).copyWith(secondary: Colors.amber),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16.0),
    ),
  );
}
