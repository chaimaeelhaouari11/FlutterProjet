import 'package:flutter/material.dart';                
import 'package:go_router/go_router.dart';       
import 'package:provider/provider.dart';                
import 'package:flutter_animate/flutter_animate.dart';  
import '../../../core/theme/app_theme.dart';            
import '../../../core/providers/auth_provider.dart';   
import '../../../core/l10n/app_localizations.dart';     

// =====================================================================
//                ÉCRAN : MOT DE PASSE OUBLIÉ
// =====================================================================
// Cet écran permet à un utilisateur qui a oublié son mot de passe
// d'entrer son email. 
// Le système va ensuite lui envoyer un code de vérification (OTP)
// pour confirmer son identité avant réinitialisation.
// UX pensée pour être simple, rassurante et claire.
//
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}



// =====================================================================
//                  ÉTAT DE L'ÉCRAN ForgotPassword
// =====================================================================
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  // Clé globale pour contrôler le formulaire Flutter
  // Elle permet :
  //  De valider les champs
  //  De gérer les erreurs utilisateur
  final _formKey = GlobalKey<FormState>();

  // Controller qui permet :
  // - de lire l'email tapé par l'utilisateur
  // - de le passer à AuthProvider
  final _emailController = TextEditingController();

  // Variable pour indiquer si une requête est en cours
  // Utile pour :
  // - désactiver le bouton
  // - afficher un CircularProgressIndicator
  bool _isLoading = false;


  // ================================================================
  //  Méthode lifecycle : appelée lorsque l'écran est détruit
  // ================================================================
  @override
  void dispose() {
    // On libère le controller de l'email pour éviter les fuites mémoire.
    _emailController.dispose();
    super.dispose();
  }



  // ================================================================
  //     MÉTHODE PRINCIPALE : ENVOYER LE CODE OTP AU MAIL
  // ================================================================
  Future<void> _sendResetCode() async {

    //  Vérifier la validation du formulaire (email bien rempli)
    if (!_formKey.currentState!.validate()) return;


    //  Active l'état de chargement (UI feedback)
    setState(() => _isLoading = true);


    //  Appel au provider d'authentification
    // forgotPassword() simule ou déclenche l'envoi du code :
    // - côté backend (API)
    // - ou email service
    final success = await context.read<AuthProvider>().forgotPassword(
          _emailController.text.trim(), // trim() enlève espaces inutiles
        );


    //  Fin du chargement (retour UI normal)
    setState(() => _isLoading = false);


    //  Si succès → naviguer vers l'écran OTP
    // mounted vérifie que l'écran existe encore
    if (success && mounted) {

      // Navigation + passage d'email à l'écran suivant
      // utile car l’écran OTP a besoin de savoir pour quel email vérifier
      context.push(
        '/otp-verification',
        extra: _emailController.text.trim(),
      );
    }

    //  Si erreur → afficher message clair à l’utilisateur
    else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Erreur lors de l'envoi du code"),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }



  // ================================================================
  //                    INTERFACE UTILISATEUR
  // ================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        // ------------------------------------------------------------
        // Dégradé moderne en fond → améliore l’expérience visuelle
        // ------------------------------------------------------------
        decoration: const BoxDecoration(
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
          child: SingleChildScrollView(
            // Permet de scroller si écran petit (ex: téléphone petit)
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: Form(
              key: _formKey,   // Liaison formulaire ↔ validation

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  const SizedBox(height: 20),

                  // ==================================================
                  // BOUTON RETOUR (UX important)
                  // ==================================================
                  Align(
                    alignment: Alignment.centerLeft,

                    child: IconButton(
                      onPressed: () => context.pop(), // Retour

                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,

                          // Design bouton propre et moderne
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



                  // ==================================================
                  // ICÔNE VISUELLE (renforce compréhension UX)
                  // ==================================================
                  Container(
                    width: 120,
                    height: 120,

                    // Cercle coloré avec icône de réinitialisation
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      shape: BoxShape.circle,
                    ),

                    child: const Center(
                      child: Icon(
                        Icons.lock_reset,
                        size: 60,
                        color: AppTheme.primary,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .scale(begin: const Offset(0.5, 0.5)),



                  const SizedBox(height: 40),



                  // ==================================================
                  // TITRE PRINCIPAL
                  // ==================================================
                  Text(
                    context.tr('reset_password'),  // Titre traduit
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppTheme.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(delay: 200.ms)
                      .slideY(begin: 0.2),



                  const SizedBox(height: 12),



                  // ==================================================
                  // TEXTE EXPLICATIF POUR UTILISATEUR
                  // ==================================================
                  Text(
                    "Entrez votre email et nous vous enverrons un code "
                    "de vérification pour réinitialiser votre mot de passe.",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.grey,
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(delay: 300.ms)
                      .slideY(begin: 0.2),



                  const SizedBox(height: 40),



                  // ==================================================
                  // CHAMP EMAIL
                  // ==================================================
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('email'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.primaryDark,
                              fontWeight: FontWeight.w500,
                            ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,

                        // Validation sécurisée
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer votre email";
                          }
                          if (!value.contains('@')) {
                            return "Email invalide";
                          }
                          return null;
                        },

                        style: const TextStyle(fontSize: 16),

                        decoration: InputDecoration(
                          hintText: "exemple@email.com",

                          // Icône email
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppTheme.primary,
                          ),

                          filled: true,
                          fillColor: Colors.white,

                          // Styles des bordures
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppTheme.primaryLight,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppTheme.primaryLight,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppTheme.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slideX(begin: -0.1),



                  const SizedBox(height: 32),



                  // ==================================================
                  // BOUTON ENVOYER LE CODE
                  // ==================================================
                  SizedBox(
                    height: 56,

                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null        // désactive pendant chargement
                          : _sendResetCode,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 5,
                        shadowColor: AppTheme.primary.withOpacity(0.4),
                      ),

                      // Si en chargement → afficher animation
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

                          // Sinon afficher texte + icône avion
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context.tr('send_code'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.send),
                              ],
                            ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms)
                      .scale(begin: const Offset(0.95, 0.95)),



                  const SizedBox(height: 24),



                  // ==================================================
                  // LIEN RETOUR À LA CONNEXION
                  // ==================================================
                  TextButton(
                    onPressed: () => context.pop(),   // Retour écran login
                    child: Text(
                      "Retour à la connexion",
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 600.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
