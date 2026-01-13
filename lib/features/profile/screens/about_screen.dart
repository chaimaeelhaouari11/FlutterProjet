
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À Propos')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inventory_2, size: 80, color: AppTheme.accent),
              const SizedBox(height: 16),
              const Text('SmartStock', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text('Version 1.0.0', style: TextStyle(color: AppTheme.secondary)),
              const SizedBox(height: 32),
              const Text(
                'SmartStock est la solution complète pour la gestion d\'inventaire moderne. '
                'Conçu pour optimiser vos opérations commerciales.',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
              const Spacer(),
              const Text('© 2026 SmartStock Tech.', style: TextStyle(fontSize: 12, color: AppTheme.secondary)),
            ],
          ),
        ),
      ),
    );
  }
}
