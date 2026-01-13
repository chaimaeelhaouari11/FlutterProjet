
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _FaqItem(
            question: 'Comment ajouter un nouveau produit ?',
            answer: 'Allez dans l\'onglet "Inventaire" et cliquez sur le bouton "+" en bas à droite. Remplissez ensuite le formulaire avec les détails du produit.',
          ),
          _FaqItem(
            question: 'Comment modifier les stocks ?',
            answer: 'Vous pouvez modifier le stock soit par un mouvement manuel dans les détails du produit, soit en validant une réception de commande.',
          ),
          _FaqItem(
            question: 'Mes données sont-elles sécurisées ?',
            answer: 'Oui, toutes vos données SmartStock sont stockées localement et sécurisées par votre authentification utilisateur.',
          ),
          _FaqItem(
            question: 'Puis-je utiliser l\'application sans internet ?',
            answer: 'Absolument ! SmartStock fonctionne hors-ligne pour la gestion de base. Seul le chat support nécessite une connexion.',
          ),
        ],
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer, style: const TextStyle(color: AppTheme.secondary)),
        ),
      ],
    );
  }
}
