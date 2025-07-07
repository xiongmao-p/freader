import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  final SharedPreferences _prefs;

  SettingsService(this._prefs);

  static const String _themeModeKey = 'theme_mode';
  static const String _fontSizeKey = 'font_size';

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _prefs.setInt(_themeModeKey, themeMode.index);
  }

  ThemeMode loadThemeMode() {
    final themeIndex = _prefs.getInt(_themeModeKey);
    if (themeIndex != null &&
        themeIndex >= 0 &&
        themeIndex < ThemeMode.values.length) {
      return ThemeMode.values[themeIndex];
    }
    return ThemeMode.light; // Default value
  }

  Future<void> saveFontSize(double fontSize) async {
    await _prefs.setDouble(_fontSizeKey, fontSize);
  }

  double loadFontSize() {
    return _prefs.getDouble(_fontSizeKey) ?? 16.0; // Default value
  }
}
