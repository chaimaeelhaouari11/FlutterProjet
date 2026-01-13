import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===============================
///  PROVIDER : ThemeProvider
/// ===============================
/// Gère le thème global de l'application (mode clair / mode sombre).
/// Rôles principaux :
///   Définir le thème utilisé par l'application
///  Permettre à l'utilisateur de changer le thème
///  Sauvegarder la préférence sur le téléphone
///  Restaurer le thème choisi au prochain lancement
///
/// Il utilise SharedPreferences pour mémoriser le choix.
class ThemeProvider extends ChangeNotifier {
  
  // Clé utilisée pour sauvegarder la préférence dans le stockage local
  static const String _themeKey = 'theme_mode';
  
  // Thème courant de l'application.
  // Par défaut → Mode clair.
  ThemeMode _themeMode = ThemeMode.light;

  // Getters
  ThemeMode get themeMode => _themeMode;          // Retourne le thème actuel
  bool get isDarkMode => _themeMode == ThemeMode.dark; // Indique si on est en mode sombre

  /// Constructeur
  /// Au démarrage, on va récupérer la préférence enregistrée précédemment.
  ThemeProvider() {
    _loadTheme();
  }

  /// ===============================
  ///  CHARGEMENT DU THÈME SAUVEGARDÉ
  /// ===============================
  /// Lit la valeur stockée dans SharedPreferences.
  /// Si aucune valeur n'est trouvée → on reste en mode clair.
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    notifyListeners(); // Met à jour l'UI dans le bon thème.
  }

  /// ===============================
  ///  BASCULE CLAIR / SOMBRE
  /// ===============================
  /// Alterne automatiquement entre mode clair et sombre,
  /// puis sauvegarde immédiatement ce choix.
  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _themeMode == ThemeMode.dark);

    notifyListeners(); // Force la reconstruction de l'interface
  }

  /// ===============================
  ///  FORCER UN THÈME SPÉCIFIQUE
  /// ===============================
  /// Permet de choisir explicitement un thème :
  ///  - ThemeMode.light
  ///  - ThemeMode.dark
  /// Utilisé surtout depuis les réglages.
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, mode == ThemeMode.dark);

    notifyListeners();
  }
}
