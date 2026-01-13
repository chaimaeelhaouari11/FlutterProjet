
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(user),
              const SizedBox(height: 24),
              _buildStatsRow(),
              const SizedBox(height: 24),
              _buildMenuCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(dynamic user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: AppTheme.primary),
          ),
          const SizedBox(height: 16),
          Text(
            user?.name ?? 'Administrateur',
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            user?.email ?? 'admin@smartstock.ma',
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return const Row(
      children: [
        _StatItem(label: 'Ventes', value: '12', color: Colors.blue),
        SizedBox(width: 12),
        _StatItem(label: 'Commandes', value: '5', color: Colors.orange),
        SizedBox(width: 12),
        _StatItem(label: 'Alertes', value: '3', color: Colors.red),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildMenuItem(Icons.edit_note, 'Modifier Profil', () => context.push('/edit-profile')),
          _buildMenuItem(Icons.people_outline, 'Gestion Utilisateurs', () => context.push('/user-management')),
          _buildMenuItem(Icons.history, 'Historique des Actions', () => context.push('/system-logs')),
          _buildMenuItem(Icons.settings_outlined, 'Paramètres', () => context.push('/settings')),
          _buildMenuItem(Icons.help_outline, 'Aide & Support', () => context.push('/help-support')),
          const Divider(),
          _buildMenuItem(Icons.logout, 'Déconnexion', () => context.go('/login'), isDestractive: true),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isDestractive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestractive ? Colors.red : AppTheme.primary),
      title: Text(title, style: TextStyle(color: isDestractive ? Colors.red : null)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.secondary)),
          ],
        ),
      ),
    );
  }
}
