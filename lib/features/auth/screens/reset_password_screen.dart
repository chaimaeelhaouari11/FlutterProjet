
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Réinitialiser le mot de passe')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Veuillez saisir votre nouveau mot de passe.', textAlign: TextAlign.center),
            const SizedBox(height: 32),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Nouveau mot de passe', prefixIcon: Icon(Icons.lock_outline)),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirmer le mot de passe', prefixIcon: Icon(Icons.lock_outline)),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text('Mettre à jour')),
            ),
          ],
        ),
      ),
    );
  }
}
