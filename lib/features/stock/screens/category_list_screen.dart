
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Électronique', 'icon': Icons.computer, 'count': 45},
    {'name': 'Mobilier', 'icon': Icons.chair, 'count': 12},
    {'name': 'Fournitures', 'icon': Icons.print, 'count': 89},
    {'name': 'Accessoires', 'icon': Icons.mouse, 'count': 156},
  ];

  void _addCategory() {
    String name = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une catégorie'),
        content: TextField(
          decoration: const InputDecoration(labelText: 'Nom de la catégorie'),
          onChanged: (value) => name = value,
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty) {
                setState(() {
                  _categories.add({'name': name, 'icon': Icons.category, 'count': 0});
                });
                context.pop();
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
      appBar: AppBar(title: const Text('Catégories')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return Card(
            child: InkWell(
              onLongPress: () {
                setState(() {
                  _categories.removeAt(index);
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cat['icon'] as IconData, size: 40, color: AppTheme.accent),
                  const SizedBox(height: 12),
                  Text(cat['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${cat['count']} produits', style: const TextStyle(fontSize: 12, color: AppTheme.secondary)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        child: const Icon(Icons.add),
      ),
    );
  }
}
