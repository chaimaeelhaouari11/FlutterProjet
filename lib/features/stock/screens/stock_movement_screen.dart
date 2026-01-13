
import 'package:flutter/material.dart';


class StockMovementScreen extends StatelessWidget {
  const StockMovementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mouvements de Stock')),
      body: Column(
        children: [
          _buildSummaryCards(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                final isEntry = index % 2 == 0;
                return _buildMovementTile(isEntry);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Nouveau Mouvement'),
        icon: const Icon(Icons.swap_vert),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _SummaryBox(label: 'Entrées', value: '+450', color: Colors.green),
          const SizedBox(width: 16),
          _SummaryBox(label: 'Sorties', value: '-120', color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildMovementTile(bool isEntry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          isEntry ? Icons.arrow_downward : Icons.arrow_upward,
          color: isEntry ? Colors.green : Colors.red,
        ),
        title: Text(isEntry ? 'Entrée - Stock Achat' : 'Sortie - Vente Directe'),
        subtitle: const Text('Produit: MacBook Air M2 - 02 Jan 2026'),
        trailing: Text(
          '${isEntry ? '+' : '-'} 10',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isEntry ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
