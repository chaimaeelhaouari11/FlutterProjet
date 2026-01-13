
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  List<Product> get lowStockProducts => 
      _products.where((p) => p.isLowStock).toList();

  void fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    // Simuler un appel API ou DB
    await Future.delayed(const Duration(seconds: 1));
    
    _products = [
      Product(
        id: '1',
        name: 'Ordinateur Portable Dell',
        sku: 'DELL-XPS-13',
        categoryId: 'elect',
        supplierId: 'sup1',
        description: 'Dell XPS 13 avec processeur i7 et 16Go RAM.',
        purchasePrice: 8000.0,
        sellingPrice: 12000.0,
        currentStock: 15,
        minStockLevel: 5,
        unit: 'Unité',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Product(
        id: '2',
        name: 'Clavier Mécanique RGB',
        sku: 'KBD-RGB-01',
        categoryId: 'elect',
        supplierId: 'sup1',
        description: 'Clavier mécanique avec switchs rouges.',
        purchasePrice: 300.0,
        sellingPrice: 550.0,
        currentStock: 3,
        minStockLevel: 10,
        unit: 'Unité',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      // Ajouter plus de produits fictifs
    ];

    _isLoading = false;
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }
}
