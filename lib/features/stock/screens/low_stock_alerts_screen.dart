
import 'package:flutter/material.dart';


class LowStockAlertsScreen extends StatelessWidget {
  const LowStockAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertes Stock Faible')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.orange.shade50,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.warning, color: Colors.orange),
              title: const Text('Ecran Samsung 27"', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Restant: 2 unités | Seuil: 5 unités'),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Commander'),
              ),
            ),
          );
        },
      ),
    );
  }
}
