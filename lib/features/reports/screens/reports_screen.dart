
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rapports & Analyses')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildReportOption(context, 'Rapport de Stock Mensuel', Icons.insert_chart),
            _buildReportOption(context, 'Valeur d\'Inventaire Totale', Icons.monetization_on),
            _buildReportOption(context, 'Performance des Fournisseurs', Icons.handshake),
            _buildReportOption(context, 'Rotation de Stock', Icons.loop),
            const SizedBox(height: 24),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('Graphique Analytique (Placeholder)', 
                  style: TextStyle(color: AppTheme.secondary)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportOption(BuildContext context, String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.accent),
        title: Text(title),
        trailing: const Icon(Icons.download),
        onTap: () {},
      ),
    );
  }
}
