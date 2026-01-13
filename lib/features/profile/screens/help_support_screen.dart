
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aide & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHelpItem(
            context,
            Icons.auto_stories,
            'Guide d\'utilisation',
            'Apprenez à gérer votre stock efficacement.',
            () => context.push('/user-guide'),
          ),
          _buildHelpItem(
            context,
            Icons.chat_bubble,
            'Chatter avec le support',
            'Notre équipe répond en moins de 24h.',
            () => context.push('/chat-support'),
          ),
          _buildHelpItem(
            context,
            Icons.bug_report,
            'Signaler un problème',
            'Aidez-nous à améliorer SmartStock.',
            () => context.push('/report-problem'),
          ),
          _buildHelpItem(
            context,
            Icons.question_answer,
            'Questions Fréquentes (FAQ)',
            'Réponses rapides à vos questions.',
            () => context.push('/faq'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cette fonctionnalité sera bientôt disponible !')),
    );
  }

  Widget _buildHelpItem(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.accent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
