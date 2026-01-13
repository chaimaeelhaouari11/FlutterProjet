
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.inventory_2_outlined, color: AppTheme.primary),
        ),
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SKU: ${product.sku}', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildStockStatus(product),
                const Spacer(),
                Text(
                  '${product.sellingPrice} DH',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accent,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          context.push('/product/${product.id}', extra: product);
        },
      ),
    );
  }

  Widget _buildStockStatus(Product product) {
    final bool isLow = product.isLowStock;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isLow ? AppTheme.error : AppTheme.success).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Stock: ${product.currentStock} ${product.unit}',
        style: TextStyle(
          color: isLow ? AppTheme.error : AppTheme.success,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
