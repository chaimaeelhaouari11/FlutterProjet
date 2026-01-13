import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/language_provider.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/product_provider.dart';
import 'core/providers/supplier_provider.dart';
import 'core/providers/activity_provider.dart';
import 'core/providers/notification_provider.dart';
import 'core/router/app_router.dart';
import 'core/services/database_service.dart';
import 'core/l10n/app_localizations.dart';

/// =======================================================================
/// POINT D'ENTRÉE DE L'APPLICATION (MAIN)
/// =======================================================================
///

/// Voici le point de départ de tout le projet. C'est ici que l'application se lance.
///
/// Ce fichier a 3 rôles principaux :
/// 1. Initialiser le moteur Flutter et les services essentiels (Base de données, Orientation écran).
/// 2. Configurer les "Providers" globaux (Gestion d'état).
/// 3. Lancer l'interface principale via `MaterialApp`.
///
/// -----------------------------------------------------------------------
/// ARCHITECTURE GÉNÉRALE (MVVM - Provider)
/// -----------------------------------------------------------------------
/// Nous utilisons le pattern MVVM (Model-View-ViewModel) simplifié avec Provider.
///
/// - **VUE (UI)** : Ce sont les écrans dans le dossier `lib/features/`.
///   - Ils ne font qu'afficher les données.
///   - Ils écoutent les changements via `context.watch<Provider>()`.
///
/// - **VIEW-MODEL (Providers)** : Dossier `lib/core/providers/`.
///   - C'est là que se trouve toute la LOGIQUE MÉTIER.
///   - Exemple : `AuthProvider` gère la connexion, `CourseProvider` gère les cours.
///   - Quand une donnée change, ils font `notifyListeners()` pour mettre à jour l'écran.
///
/// - **MODÈLE (Data)** : Dossier `lib/core/models/`.
///   - Ce sont de simples classes (ex: Course, User) pour structurer nos données.
///
/// -----------------------------------------------------------------------
/// SERVICES (Backend local)
/// -----------------------------------------------------------------------
/// - `DatabaseService` (`lib/core/services/`) : Gère la base de données SQLite locale.
///   - C'est notre "Backend" pour stocker la progression, les quiz et certificats.
///
/// Bon courage pour la lecture du code ! 🚀
/// =======================================================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database (Mobile only)
  if (!kIsWeb) {
    await DatabaseService.instance.database;
  }
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => SupplierProvider()),
        ChangeNotifierProvider(create: (_) => ActivityProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp.router(
            scaffoldMessengerKey: AppTheme.messengerKey,
            title: 'SmartStock',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: languageProvider.locale,
            supportedLocales: const [
              Locale('fr', 'FR'),
              Locale('en', 'US'),
              Locale('ar', 'MA'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
