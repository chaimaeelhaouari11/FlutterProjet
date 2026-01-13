
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('SmartStock Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(context),
            const SizedBox(height: 24),
            _buildStatGrid(context),
            const SizedBox(height: 24),
            _buildStockChart(context),
            const SizedBox(height: 24),
            _buildRecentActivity(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final userName = authProvider.user?.name ?? 'Utilisateur';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bonjour, $userName 👋',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
        ),
        Text(
          'Voici l\'état de votre inventaire aujourd\'hui.',
          style: TextStyle(color: AppTheme.secondary),
        ),
      ],
    );
  }

  Widget _buildStatGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _StatCard(
          title: 'Produits', 
          value: '1,240', 
          icon: Icons.inventory_2, 
          color: Colors.blue,
          onTap: () => context.push('/products'),
        ),
        _StatCard(
          title: 'Valeur Stock', 
          value: '450k DH', 
          icon: Icons.account_balance_wallet, 
          color: Colors.green,
          onTap: () {}, // Maybe a reports screen
        ),
        _StatCard(
          title: 'Alertes', 
          value: '12', 
          icon: Icons.warning_amber_rounded, 
          color: Colors.orange,
          onTap: () => context.push('/low-stock'),
        ),
        _StatCard(
          title: 'Commandes', 
          value: '8', 
          icon: Icons.shopping_cart, 
          color: Colors.purple,
          onTap: () {
            // Ideally we'd switch tab, but pushing is easier for demo
            context.push('/main'); // Just refresh or navigate
          },
        ),
      ],
    );
  }

  Widget _buildStockChart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Flux de Stock (7 jours)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3), FlSpot(1, 1), FlSpot(2, 4), 
                        FlSpot(3, 2), FlSpot(4, 5), FlSpot(5, 3), FlSpot(6, 4),
                      ],
                      isCurved: true,
                      color: AppTheme.accent,
                      barWidth: 4,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: true, color: AppTheme.accent.withOpacity(0.1)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Activités Récentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.background,
                  child: Icon(index == 0 ? Icons.add : Icons.remove, 
                    color: index == 0 ? Colors.green : Colors.red),
                ),
                title: Text(index == 0 ? 'Entrée de stock #984' : 'Sortie de stock #982'),
                subtitle: Text('Il y a ${index + 1} heures'),
                trailing: const Icon(Icons.chevron_right),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({
    required this.title, 
    required this.value, 
    required this.icon, 
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), 
              blurRadius: 10, 
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                Text(title, style: TextStyle(color: AppTheme.secondary, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const Color white = Color(0xFFFFFFFF);
