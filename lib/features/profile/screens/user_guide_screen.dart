
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guide d\'utilisation')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStep(1, 'Gérer votre Inventaire', 'Ajoutez vos produits, définissez des prix et suivez les quantités en temps réel dans l\'onglet "Inventaire".'),
          _buildStep(2, 'Traiter les Commandes', 'Créez des bons de commande pour vos fournisseurs et gérez les réceptions de marchandises.'),
          _buildStep(3, 'Alertes Stock Faible', 'Surveillez le tableau de bord pour les produits en rupture de stock et recevez des notifications.'),
          _buildStep(4, 'Statistiques & Rapports', 'Analysez la performance de vos ventes et la valorisation de votre stock via les graphiques du Dashboard.'),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.accent,
            child: Text('$number', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: AppTheme.secondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
