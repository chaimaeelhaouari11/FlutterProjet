import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/auth_provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final success = await context.read<AuthProvider>().login(
      _emailController.text.trim(),
      _passwordController.text,
    );
    setState(() => _isLoading = false);

    if (success && mounted) {
      context.go('/main');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email ou mot de passe incorrect'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                
                // Professional Logo
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 40),
                  ).animate().fadeIn().scale(begin: const Offset(0.8, 0.8)),
                ),
                
                const SizedBox(height: 32),
                
                Text(
                  'SmartStock',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 100.ms),
                
                Text(
                  'Gestion d\'inventaire professionnelle',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 48),

                Text(
                  'Connexion',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
                ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
                
                const SizedBox(height: 24),

                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'nom@entreprise.com',
                  icon: Icons.alternate_email_rounded,
                  validator: (v) => v!.isEmpty ? 'Entrez votre email' : null,
                ).animate().fadeIn(delay: 400.ms),

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
                ).animate().fadeIn(delay: 500.ms),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/forgot-password'),
                    child: const Text('Mot de passe oublié ?'),
                  ),
                ),

                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Se Connecter'),
                ).animate().fadeIn(delay: 600.ms),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Nouveau ici ?'),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: const Text('Créer un compte', style: TextStyle(fontWeight: FontWeight.bold)),
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
