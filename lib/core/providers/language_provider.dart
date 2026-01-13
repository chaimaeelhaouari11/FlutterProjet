import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('fr', 'FR');
  static const String _prefKey = 'selected_language';

  Locale get locale => _locale;
  String get languageCode => _locale.languageCode;

  final List<Map<String, String>> availableLanguages = [
    {'name': 'Français', 'code': 'fr', 'flag': '🇫🇷'},
    {'name': 'English', 'code': 'en', 'flag': '🇺🇸'},
    {'name': 'العربية', 'code': 'ar', 'flag': '🇲🇦'},
  ];

  LanguageProvider() {
    _loadFromPrefs();
  }

  void setLanguage(String code) async {
    if (code == 'ar') {
      _locale = const Locale('ar', 'MA');
    } else if (code == 'en') {
      _locale = const Locale('en', 'US');
    } else {
      _locale = const Locale('fr', 'FR');
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, code);
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_prefKey) ?? 'fr';
    
    if (langCode == 'ar') {
      _locale = const Locale('ar', 'MA');
    } else if (langCode == 'en') {
      _locale = const Locale('en', 'US');
    } else {
      _locale = const Locale('fr', 'FR');
    }
    notifyListeners();
  }
}
