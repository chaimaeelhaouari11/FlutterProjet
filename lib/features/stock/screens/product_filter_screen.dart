
import 'package:flutter/material.dart';

class ProductFilterScreen extends StatelessWidget {
  const ProductFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filtrer les Produits')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Catégorie', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(label: const Text('Électronique'), onSelected: (b) {}),
                FilterChip(label: const Text('Mobilier'), onSelected: (b) {}),
                FilterChip(label: const Text('Fournitures'), onSelected: (b) {}),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Prix (DH)', style: TextStyle(fontWeight: FontWeight.bold)),
            RangeSlider(
              values: const RangeValues(0, 50000),
              min: 0,
              max: 100000,
              onChanged: (v) {},
            ),
            const SizedBox(height: 24),
            const Text('Disponibilité', style: TextStyle(fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: const Text('En stock uniquement'),
              value: true,
              onChanged: (v) {},
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Appliquer les filtres')),
            ),
          ],
        ),
      ),
    );
  }
}
