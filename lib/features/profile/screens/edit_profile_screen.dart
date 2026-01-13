import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/l10n/app_localizations.dart';

/// ======================================================================
/// ÉCRAN : Modification du profil utilisateur
/// Objectif :
/// - Afficher les informations actuelles de l’utilisateur
/// - Permettre la modification du nom
/// - Permettre le changement d’avatar
/// - Sauvegarder les changements via AuthProvider
/// ======================================================================
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  /// Clé du formulaire pour valider les champs
  final _formKey = GlobalKey<FormState>();

  /// Contrôleur du champ Nom
  late TextEditingController _nameController;

  /// Récupération du nom utilisateur dès l’ouverture de la page
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    _nameController = TextEditingController(text: user?.name ?? '');
  }

  /// Libération mémoire
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Sauvegarde des modifications
  /// 1) Vérifie formulaire
  /// 2) Appelle updateProfile() dans AuthProvider
  /// 3) Affiche message succès
  /// 4) Retour à l’écran précédent
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<AuthProvider>().updateProfile(
          name: _nameController.text.trim(),
        );

    if (mounted) {
      final messenger = ScaffoldMessenger.of(context);
      context.pop();
      messenger.showSnackBar(
        SnackBar(
          content: const Text('Profil mis à jour avec succès!'),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      /// Barre d’application avec bouton retour
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
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
        title: Text(context.tr('edit_profile')),
      ),

      /// Corps de page
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          /// Formulaire utilisateur
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// =========================
                /// AVATAR UTILISATEUR
                /// =========================
                Center(
                  child: Stack(
                    children: [
                      /// Affichage avatar actuel
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            authProvider.user?.avatarEmoji ?? '👤',
                            style: const TextStyle(fontSize: 60),
                          ),
                        ),
                      ),

                      /// Bouton modification avatar
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showAvatarPicker(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppTheme.primary,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8)),
                const SizedBox(height: 40),

                /// =========================
                /// CHAMP NOM
                /// =========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('full_name'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Votre nom',
                        prefixIcon: const Icon(Icons.person_outline,
                            color: AppTheme.primary),
                        filled: true,
                        fillColor: isDark ? const Color(0xFF252540) : Colors.white,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
                const SizedBox(height: 20),

                /// =========================
                /// EMAIL EN LECTURE SEULE
                /// =========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('email'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 8),

                    /// On affiche uniquement, pas modifiable
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF252540)
                            : AppTheme.primaryVeryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined, color: AppTheme.grey),
                          const SizedBox(width: 12),
                          Text(
                            authProvider.user?.email ?? 'Non défini',
                            style: TextStyle(color: AppTheme.grey),
                          ),
                          const Spacer(),
                          Icon(Icons.lock_outline,
                              size: 18, color: AppTheme.grey),
                        ],
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1),
                const SizedBox(height: 40),

                /// =========================
                /// BOUTON SAUVEGARDE
                /// =========================
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text(context.tr('save')),
                  ),
                ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.95, 0.95)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ====================================================================
  /// Sélecteur d’avatar (BottomSheet)
  /// Permet à l’utilisateur de choisir un nouvel avatar
  /// ====================================================================
  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Barre grise esthétique
              Center(
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                context.tr('select_avatar'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),

              /// Grille des avatars
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: 18,
                itemBuilder: (context, index) {
                  final avatars = [
                    '👤', '👨', '👩', '🧑', '👨‍💻', '👩‍💻',
                    '🧑‍🎓', '👨‍🎓', '👩‍🎓', '🧑‍🏫', '👨‍🏫', '👩‍🏫',
                    '🦸', '🦸‍♂️', '🦸‍♀️', '🧙', '🧙‍♂️', '🧙‍♀️',
                  ];

                  /// Lorsque l’utilisateur choisit un avatar
                  return GestureDetector(
                    onTap: () {
                      context.read<AuthProvider>().updateProfile(avatarIndex: index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          avatars[index],
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
