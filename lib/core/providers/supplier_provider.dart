
import 'package:flutter/material.dart';
import '../models/supplier_model.dart';

class SupplierProvider with ChangeNotifier {
  List<Supplier> _suppliers = [
    Supplier(
      id: '1',
      name: 'TechLog Solutions',
      contactName: 'Ahmed Alami',
      email: 'contact@techlog.ma',
      phone: '0655443322',
      address: 'Casablanca, Morocco',
      category: 'Electronics',
      createdAt: DateTime.now(),
    ),
    Supplier(
      id: '2',
      name: 'Global Fresh Co.',
      contactName: 'Sara Bennani',
      email: 'info@globalfresh.com',
      phone: '0611223344',
      address: 'Rabat, Morocco',
      category: 'Food',
      createdAt: DateTime.now(),
    ),
  ];

  List<Supplier> get suppliers => _suppliers;

  void addSupplier(Supplier supplier) {
    _suppliers.add(supplier);
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }

  void updateSupplier(Supplier supplier) {
    final index = _suppliers.indexWhere((s) => s.id == supplier.id);
    if (index != -1) {
      _suppliers[index] = supplier;
      WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    }
  }

  void deleteSupplier(String id) {
    _suppliers.removeWhere((s) => s.id == id);
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }
}
