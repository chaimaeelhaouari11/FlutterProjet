
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Produit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/edit-product', extra: product),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildStockSection(context),
            const SizedBox(height: 24),
            _buildPriceSection(context),
            const SizedBox(height: 24),
            _buildDescriptionSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.inventory_2, size: 40, color: AppTheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('SKU: ${product.sku}', style: const TextStyle(color: AppTheme.secondary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStockSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Stock Actuel', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${product.currentStock} ${product.unit}', 
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                    color: product.isLowStock ? AppTheme.error : AppTheme.success,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Niveau d\'alerte'),
                Text('${product.minStockLevel} ${product.unit}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PriceCard(
            label: 'Prix d\'achat',
            price: product.purchasePrice,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _PriceCard(
            label: 'Prix de vente',
            price: product.sellingPrice,
            color: AppTheme.accent,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: const TextStyle(color: AppTheme.secondary, height: 1.5),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le produit ?'),
        content: Text('Voulez-vous vraiment supprimer "${product.name}" ? Cette action est irréversible.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          TextButton(
            onPressed: () {
              final messenger = ScaffoldMessenger.of(context);
              context.read<ProductProvider>().deleteProduct(product.id);
              context.pop(); // Ferme le dialogue
              context.pop(); // Retourne à la liste
              messenger.showSnackBar(
                const SnackBar(content: Text('Produit supprimé')),
              );
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final String label;
  final double price;
  final Color color;

  const _PriceCard({required this.label, required this.price, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('${price.toStringAsFixed(2)} DH', 
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
