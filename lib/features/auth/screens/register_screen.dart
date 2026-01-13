import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final success = await context.read<AuthProvider>().register(
          _nameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text,
        );
    setState(() => _isLoading = false);

    if (success && mounted) {
      context.go('/main');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Erreur lors de l'inscription"),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Créer un compte',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ).animate().fadeIn().slideX(begin: -0.1),
                
                Text(
                  'Rejoignez SmartStock pour gérer votre inventaire.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate().fadeIn(delay: 100.ms),

                const SizedBox(height: 40),

                _buildTextField(
                  controller: _nameController,
                  label: 'Nom complet',
                  hint: 'Jean Dupont',
                  icon: Icons.person_outline_rounded,
                  validator: (v) => v!.isEmpty ? 'Entrez votre nom' : null,
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _emailController,
                  label: 'Email professionnel',
                  hint: 'nom@entreprise.com',
                  icon: Icons.alternate_email_rounded,
                  validator: (v) => !v!.contains('@') ? 'Email invalide' : null,
                ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _passwordController,
                  label: 'Mot de passe',
                  hint: '••••••••',
                  icon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) => v!.length < 6 ? '6 caractères minimum' : null,
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirmer le mot de passe',
                  hint: '••••••••',
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  validator: (v) => v != _passwordController.text ? 'Les mots de passe divergent' : null,
                ).animate().fadeIn(delay: 500.ms),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  child: _isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('S\'inscrire'),
                ).animate().fadeIn(delay: 600.ms),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Déjà un compte ?'),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Se connecter', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ).animate().fadeIn(delay: 700.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
