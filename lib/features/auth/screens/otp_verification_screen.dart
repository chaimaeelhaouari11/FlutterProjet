import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/l10n/app_localizations.dart';

// =====================================================================
//                    ÉCRAN : VÉRIFICATION OTP
// =====================================================================
// Cet écran s'affiche après "Mot de passe oublié".
// L'utilisateur reçoit un code à 6 chiffres par email.
// Il doit le saisir ici pour prouver son identité.
// Ensuite, s'il est valide → accès ou redirection.
//
class OTPVerificationScreen extends StatefulWidget {
  // Email reçu depuis l'écran précédent (ForgotPasswordScreen)
  final String email;

  const OTPVerificationScreen({
    super.key,
    required this.email, // Email obligatoire
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

// =====================================================================
//                   STATE (Logique + UI dynamique)
// =====================================================================
class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  // Liste de 6 controllers → chaque case du code OTP
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  // Liste des FocusNodes → pour gérer focus automatique entre cases
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  // Indique si vérification OTP est en cours
  bool _isLoading = false;

  // ================================================================
  //   DESTRUCTION → Nettoyage mémoire
  // ================================================================
  @override
  void dispose() {
    // Libérer chaque TextEditingController
    for (var controller in _controllers) {
      controller.dispose();
    }

    // Libérer chaque FocusNode
    for (var node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  // ================================================================
  //   Getter → récupère le code complet entré par utilisateur
  // ================================================================
  String get _otp => _controllers.map((c) => c.text).join();

  // ================================================================
  //    MÉTHODE PRINCIPALE : VÉRIFIER LE CODE OTP
  // ================================================================
  Future<void> _verifyOTP() async {
    // Vérifier si 6 chiffres sont saisis
    if (_otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez entrer le code complet'),
          backgroundColor: AppTheme.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    //  Activer mode chargement
    setState(() => _isLoading = true);

    //  Vérifier OTP via AuthProvider (logique backend / interne)
    final success = await context.read<AuthProvider>().verifyOTP(
          widget.email, // email envoyé à l'écran
          _otp, // code utilisateur
        );

    //  Arrêter chargement
    setState(() => _isLoading = false);

    // Si succès → feedback utilisateur + navigation
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Code vérifié avec succès!'),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      // Retour page login
      context.go('/login');
    }

    //  Sinon → afficher erreur
    else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Code invalide'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  // ================================================================
  //   GESTION AUTOMATIQUE DES CASES OTP
  // ================================================================
  void _onOTPChanged(String value, int index) {
    // Si on tape un chiffre → passer automatiquement à la case suivante
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    // Si on efface → revenir à la case précédente
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    // Si les 6 cases sont remplies → lancer auto vérification
    if (_otp.length == 6) {
      _verifyOTP();
    }
  }

  // ================================================================
  //   INTERFACE UTILISATEUR
  // ================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fond dégradé moderne
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.primaryVeryLight, Colors.white],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // ================================
                // BOUTON RETOUR
                // ================================
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppTheme.primaryDark,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // ================================
                // ICÔNE EMAIL
                // ================================
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.mark_email_read_outlined,
                      size: 60,
                      color: AppTheme.primary,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .scale(begin: const Offset(0.5, 0.5)),

                const SizedBox(height: 40),

                // ================================
                // TITRE
                // ================================
                Text(
                  context.tr('verify_email'),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppTheme.primaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),

                const SizedBox(height: 12),

                // Message explicatif
                Text(
                  'Nous avons envoyé un code de vérification à',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.grey,
                      ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 8),

                // Affichage email concerné
                Text(
                  widget.email,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 40),

                // ================================
                // CHAMPS OTP
                // ================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => _buildOTPField(index),
                  ),
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

                const SizedBox(height: 40),

                // ================================
                // BOUTON VÉRIFIER
                // ================================
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      shadowColor: AppTheme.primary.withOpacity(0.4),
                    ),

                    // Loader si vérification en cours
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )

                        // Sinon afficher bouton normal
                        : Text(
                            context.tr('verify'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 600.ms)
                    .scale(begin: const Offset(0.95, 0.95)),

                const SizedBox(height: 24),

                // ================================
                // LIEN RENVOYER CODE
                // ================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous n'avez pas reçu le code?",
                      style: TextStyle(color: AppTheme.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        // Ici on peut appeler API resend OTP si implémentée
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Code renvoyé!'),
                            backgroundColor: AppTheme.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        context.tr('resend_code'),
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 700.ms),

                const SizedBox(height: 20),

                // ================================
                // MESSAGE AIDE (code test)
                // ================================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: AppTheme.info),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Code de test: 123456',
                          style: TextStyle(color: AppTheme.info),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 800.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================================================================
  //     CHAMP INDIVIDUEL D’UNE CASE OTP
  // ==================================================================
  Widget _buildOTPField(int index) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextFormField(
        controller: _controllers[index], // chaque case reliée à son controller
        focusNode: _focusNodes[index], // chaque case gère son focus

        keyboardType: TextInputType.number, // Clavier numérique
        textAlign: TextAlign.center, // centrer chiffre
        maxLength: 1, // un seul chiffre par case

        // Bloque tout sauf chiffres
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

        // Style du chiffre
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryDark,
        ),

        decoration: InputDecoration(
          counterText: '', // enlève compteur "0/1"
          filled: true,
          fillColor: Colors.white,

          // Styles bordures
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.primaryLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppTheme.primaryLight,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppTheme.primary,
              width: 2,
            ),
          ),
        ),

        // Gestion automatique du focus
        onChanged: (value) => _onOTPChanged(value, index),
      ),
    );
  }
}
