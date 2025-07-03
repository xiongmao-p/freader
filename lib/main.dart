import 'package:flutter/material.dart';
import 'package:reader/core/di/injection_container.dart' as di;
import 'package:reader/core/app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'FReader',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF6495ED),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6495ED),
          background: const Color(0xFFF5F5DC),
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6495ED),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6495ED),
          brightness: Brightness.dark,
          background: const Color(0xFF121212),
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      themeMode:
          ThemeMode.system, // Automatically switch between light and dark theme
    );
  }
}
