import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/l10n/app_localizations.dart';

/// ===================================================================
/// ÉCRAN : Paramètres (Settings)
///
/// Objectif de cet écran :
/// ✔ Permettre à l’utilisateur de modifier l’apparence (mode sombre)
/// ✔ Changer la langue de l’application
/// ✔ Gérer les préférences de notifications
/// ✔ Afficher les informations concernant l’application
///
/// Cet écran améliore l’expérience utilisateur en offrant
/// personnalisation + accessibilité + contrôle.
/// ===================================================================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// Récupération des providers
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();

    /// Vérifier si l’application est en mode sombre
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(

      /// ---------------- APPBAR ----------------
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),   // Retour en arrière
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF252540) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
        title: Text(context.tr('settings')),
      ),

      /// ---------------- CONTENU PRINCIPAL ----------------
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ============================================================
              /// SECTION : Apparence (Mode sombre / clair)
              /// ============================================================
              Text(context.tr('appearance'),
                style: Theme.of(context).textTheme.titleLarge,
              ).animate().fadeIn(duration: 300.ms),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF252540) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    /// Switch pour activer / désactiver dark mode
                    SwitchListTile(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) => themeProvider.toggleTheme(),
                      title: Text(context.tr('dark_mode')),
                      subtitle: Text(
                        themeProvider.isDarkMode ? 'Activé' : 'Désactivé',
                        style: TextStyle(color: AppTheme.grey),
                      ),
                      secondary: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          themeProvider.isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: AppTheme.primary,
                        ),
                      ),
                      activeColor: AppTheme.primary,
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),

              const SizedBox(height: 24),

              /// ============================================================
              /// SECTION : Langue
              /// ============================================================
              Text(context.tr('language'),
                style: Theme.of(context).textTheme.titleLarge,
              ).animate().fadeIn(delay: 150.ms),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF252540) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                    ),
                  ],
                ),

                /// Liste dynamique des langues disponibles
                child: Column(
                  children: languageProvider.availableLanguages.map((lang) {
                    final isSelected =
                        languageProvider.languageCode == lang['code'];

                    return ListTile(
                      onTap: () =>
                          languageProvider.setLanguage(lang['code']!),
                      leading: Text(
                        lang['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(lang['name']!),

                      /// Icône verte si la langue est sélectionnée
                      trailing: isSelected
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppTheme.success,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check,
                                  color: Colors.white, size: 16),
                            )
                          : null,
                    );
                  }).toList(),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

              const SizedBox(height: 24),

              /// ============================================================
              /// SECTION : Notifications
              /// ============================================================
              Text(context.tr('notifications'),
                style: Theme.of(context).textTheme.titleLarge,
              ).animate().fadeIn(delay: 250.ms),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF252540) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                    ),
                  ],
                ),

                /// Deux paramètres disponibles (démo)
                child: Column(
                  children: [
                    SwitchListTile(
                      value: true,
                      onChanged: (value) {},
                      title: Text(context.tr('push_notifications')),
                      secondary: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.notifications_outlined,
                            color: AppTheme.primary),
                      ),
                      activeColor: AppTheme.primary,
                    ),
                    const Divider(height: 1, indent: 60),
                    SwitchListTile(
                      value: true,
                      onChanged: (value) {},
                      title: Text(context.tr('email_notifications')),
                      secondary: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.email_outlined,
                            color: AppTheme.primary),
                      ),
                      activeColor: AppTheme.primary,
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),

              const SizedBox(height: 24),

              /// ============================================================
              /// SECTION : À propos de l'application
              /// ============================================================
              Text(context.tr('about_app'),
                style: Theme.of(context).textTheme.titleLarge,
              ).animate().fadeIn(delay: 350.ms),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF252540) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    /// Version application
                    ListTile(
                      leading: _iconBox(Icons.info_outline),
                      title: Text(context.tr('version')),
                      trailing: Text('1.0.0',
                          style: TextStyle(color: AppTheme.grey)),
                    ),

                    const Divider(height: 1, indent: 60),

                    /// Politique de confidentialité
                    ListTile(
                      onTap: () {},
                      leading: _iconBox(Icons.privacy_tip_outlined),
                      title: Text(context.tr('privacy_policy')),
                      trailing: const Icon(Icons.chevron_right),
                    ),

                    const Divider(height: 1, indent: 60),

                    /// Conditions d'utilisation
                    ListTile(
                      onTap: () {},
                      leading: _iconBox(Icons.description_outlined),
                      title: Text(context.tr('terms_of_service')),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// Petite fonction utilitaire pour styliser les icônes
  Widget _iconBox(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppTheme.primary),
    );
  }
}
