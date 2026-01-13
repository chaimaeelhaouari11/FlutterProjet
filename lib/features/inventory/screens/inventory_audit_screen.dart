
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class InventoryAuditScreen extends StatelessWidget {
  const InventoryAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audit d\'Inventaire')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Vérifiez le stock physique par rapport au stock système.', 
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.secondary)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Souris Sans Fil Logitech', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Système: 24 unités', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: TextField(
                              decoration: const InputDecoration(hintText: 'Physique'),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Soumettre l\'Audit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
