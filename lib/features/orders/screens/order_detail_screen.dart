
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails de Commande')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderInfo(),
            const SizedBox(height: 24),
            const Text('Articles Commandés', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            _buildOrderItem('Laptop Dell XPS 15', '2 unités', '24,000 DH'),
            _buildOrderItem('Souris Bluetooth', '5 unités', '1,250 DH'),
            const Divider(height: 32),
            _buildTotalSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow('N° Commande', '#ORD-2026-001'),
            _buildInfoRow('Date', '02 Jan 2026'),
            _buildInfoRow('Fournisseur', 'TechLog Solutions'),
            _buildInfoRow('Status', 'En attente', isStatus: true),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.secondary)),
          Text(value, style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isStatus ? Colors.orange : AppTheme.primary,
          )),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String name, String qty, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(name),
        subtitle: Text(qty),
        trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTotalSection() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total HT', style: TextStyle(fontSize: 16)),
            Text('25,250 DH', style: TextStyle(fontSize: 16)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total TTC', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('30,300 DH', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.accent)),
          ],
        ),
      ],
    );
  }
}
