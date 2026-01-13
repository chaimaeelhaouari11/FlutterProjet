import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/providers/auth_provider.dart';

/// ================================================================
/// SPLASH SCREEN
///
/// Rôle de cet écran :
/// ✔ Première page affichée au lancement de l’application
/// ✔ Afficher le logo + animation
/// ✔ Vérifier l’état de connexion utilisateur
/// ✔ Rediriger automatiquement :
////    → Utilisateur connecté / invité  → /main
////    → Nouvel utilisateur             → /onboarding
///
/// Délai d’affichage : 3 secondes
/// =================================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    /// Dès l’ouverture → on lance la navigation différée
    _navigateAfterDelay();
  }

  /// =================================================================
  ///  FONCTION DE NAVIGATION APRÈS DÉLAI
  ///
  /// Logique :
  ///  Pause 3 secondes pour afficher l’écran
  ///  Vérification authentification
  ///  Redirection automatique
  /// =================================================================
  Future<void> _navigateAfterDelay() async {
    /// Pause visuelle (animation splash)
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    final authProvider = context.read<AuthProvider>();

    ///  Si utilisateur connecté OU mode invité
    if (authProvider.isAuthenticated || authProvider.isGuest) {
      context.go('/main');
    }

    ///  Sinon → écran onboarding
    else {
      context.go('/onboarding');
    }
  }

  /// =================================================================
  ///  INTERFACE UTILISATEUR
  ///
  /// Composé de :
  /// ✔ Dégradé de fond
  /// ✔ Logo animé
  /// ✔ Nom de l’application
  /// ✔ Slogan
  /// ✔ Loader
  /// ✔ Version
  /// =================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        ///  Dégradé principal
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryDark,
              AppTheme.primary,
              AppTheme.primaryMedium,
            ],
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// ================= LOGO =================
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '📦', // Icone de carton pour le stock
                    style: TextStyle(fontSize: 70),
                  ),
                ),
              )

                  /// Effet apparition + zoom doux
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  ),

              const SizedBox(height: 30),

              /// ================= NOM APPLICATION =================
              Text(
                'SmartStock',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 500.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 10),

              /// ================= SLOGAN =================
              Text(
                'Optimisez votre inventaire',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
              )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 500.ms)
                  .slideY(begin: 0.3, end: 0),

              const Spacer(),

              /// ================= INDICATEUR DE CHARGEMENT =================
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withOpacity(0.8),
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms, duration: 500.ms),

              const SizedBox(height: 50),

              /// ================= VERSION =================
              Text(
                'Version 1.0.0',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.6),
                    ),
              ).animate().fadeIn(delay: 1000.ms, duration: 500.ms),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
