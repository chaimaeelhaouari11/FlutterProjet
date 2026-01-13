import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/l10n/app_localizations.dart';

/// ======================================================================
/// Écran d'onboarding (présentation de l'application)
/// Objectif :
/// - Présenter les avantages de l'application
/// - Permettre de passer les écrans (skip)
/// - Naviguer vers Login après le dernier écran
/// ======================================================================
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Contrôle du slider
  final PageController _pageController = PageController();

  // Page actuelle
  int _currentPage = 0;

  /// Liste des pages d’onboarding (texte + couleur)
  final List<OnboardingData> _pages = [
    OnboardingData(
      icon: '📦',
      title: 'Gestion Simplifiée',
      description:
          'Gérez tout votre inventaire en un seul endroit. Suivez les entrées et sorties en temps réel.',
      color: AppTheme.primary,
    ),
    OnboardingData(
      icon: '📊',
      title: 'Alertes Intelligentes',
      description:
          'Ne soyez plus jamais en rupture de stock. Recevez des notifications pour les produits critiques.',
      color: AppTheme.accent,
    ),
    OnboardingData(
      icon: '📈',
      title: 'Rapports & Analyses',
      description:
          'Prenez des décisions éclairées grâce aux rapports de performance et à la valorisation du stock.',
      color: AppTheme.success,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Passer à la page suivante
  /// Si dernière page → aller à login
  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  /// Bouton Skip → aller directement au login
  void _skip() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond avec dégradé
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryVeryLight,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// Bouton Skip en haut
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: _skip,
                    child: Text(
                      context.tr('skip'),
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              /// Slider des pages
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),

              /// Indicateur de pages (points)
              _buildPageIndicator(),
              const SizedBox(height: 30),

              /// Bouton Next / Get Started
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pages[_currentPage].color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      shadowColor:
                          _pages[_currentPage].color.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage == _pages.length - 1
                              ? context.tr('get_started') // Dernière page
                              : context.tr('next'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                  ),
                ),
              )
                  .animate(target: _currentPage.toDouble())
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                    duration: 200.ms,
                  ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// ===================================================================
  /// Construction d’une page d’onboarding
  /// ===================================================================
  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Cercle avec emoji
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: data.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    data.icon,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.easeOut,
              ),

          const SizedBox(height: 50),

          /// Titre
          Text(
            data.title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 20),

          /// Description
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.grey,
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  /// ===================================================================
  /// Indicateur de pages (barres animées)
  /// ===================================================================
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _currentPage == index
                ? _pages[index].color
                : AppTheme.primaryLight,
          ),
        ),
      ),
    );
  }
}

/// Modèle représentant une page onboarding
class OnboardingData {
  final String icon;
  final String title;
  final String description;
  final Color color;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
