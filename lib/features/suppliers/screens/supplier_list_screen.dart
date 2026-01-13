
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/supplier_provider.dart';

class SupplierListScreen extends StatelessWidget {
  const SupplierListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supplierProvider = context.watch<SupplierProvider>();
    final suppliers = supplierProvider.suppliers;

    return Scaffold(
      appBar: AppBar(title: const Text('Fournisseurs')),
      body: suppliers.isEmpty 
        ? const Center(child: Text('Aucun fournisseur trouvé'))
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: suppliers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.accent.withOpacity(0.1),
                    child: Text(supplier.name[0], style: const TextStyle(color: AppTheme.accent)),
                  ),
                  title: Text(supplier.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(supplier.category),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => supplierProvider.deleteSupplier(supplier.id),
                  ),
                  onTap: () {
                    // Navigate to form for editing
                    context.push('/supplier-form', extra: supplier);
                  },
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/supplier-form'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
