
import 'package:flutter/material.dart';

class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({super.key});

  @override
  State<PurchaseOrderListScreen> createState() => _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
  final List<Map<String, String>> _orders = [
    {'id': 'ORD-2026-001', 'supplier': 'TechLog Solutions', 'date': '02/01/2026', 'status': 'Livré'},
    {'id': 'ORD-2026-002', 'supplier': 'Global Fresh Co.', 'date': '02/01/2026', 'status': 'En attente'},
  ];

  void _addOrder() {
    setState(() {
      _orders.add({
        'id': 'ORD-2026-00${_orders.length + 1}',
        'supplier': 'Nouveau Fournisseur',
        'date': '02/01/2026',
        'status': 'En attente',
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nouvelle commande créée !')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bons de Commande')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text('Commande #${order['id']}'),
              subtitle: Text('Fournisseur: ${order['supplier']} | ${order['date']}'),
              trailing: _buildStatusChip(order['status']!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOrder,
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final bool isDone = status == 'Livré';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isDone ? Colors.green : Colors.orange).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(color: isDone ? Colors.green : Colors.orange, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
