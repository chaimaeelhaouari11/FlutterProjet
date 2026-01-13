
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class WarehouseListScreen extends StatefulWidget {
  const WarehouseListScreen({super.key});

  @override
  State<WarehouseListScreen> createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseListScreen> {
  final List<Map<String, String>> _warehouses = [
    {'name': 'Dépôt Central - Casablanca', 'location': 'Quartier Industriel', 'occupancy': '85%'},
    {'name': 'Entrepôt Nord - Tanger', 'location': 'Route de Tetouan', 'occupancy': '40%'},
    {'name': 'Stock Boutique - Rabat', 'location': 'Agdal Center', 'occupancy': '95%'},
  ];

  void _addWarehouse() {
    String name = '';
    String location = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un entrepôt'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nom'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Localisation'),
              onChanged: (value) => location = value,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty) {
                setState(() {
                  _warehouses.add({'name': name, 'location': location, 'occupancy': '0%'});
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrepôts')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _warehouses.length,
        itemBuilder: (context, index) {
          final w = _warehouses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(w['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
                        child: Text(w['occupancy']!, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppTheme.secondary),
                      const SizedBox(width: 4),
                      Text(w['location']!, style: const TextStyle(color: AppTheme.secondary)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWarehouse,
        child: const Icon(Icons.add_business),
      ),
    );
  }
}
