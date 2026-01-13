
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/supplier_model.dart';
import '../../../../core/providers/supplier_provider.dart';
import '../../../../core/providers/activity_provider.dart';
import '../../../../core/models/activity_model.dart';

class SupplierFormScreen extends StatefulWidget {
  final Supplier? supplier;
  const SupplierFormScreen({super.key, this.supplier});

  @override
  State<SupplierFormScreen> createState() => _SupplierFormScreenState();
}

class _SupplierFormScreenState extends State<SupplierFormScreen> {
  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.supplier?.name);
    _contactController = TextEditingController(text: widget.supplier?.contactName);
    _emailController = TextEditingController(text: widget.supplier?.email);
    _phoneController = TextEditingController(text: widget.supplier?.phone);
    _addressController = TextEditingController(text: widget.supplier?.address);
  }

  void _save() {
    if (_nameController.text.isEmpty) return;
    
    // Étape 1 : Fermer le clavier
    FocusScope.of(context).unfocus();

    // Étape 2 : CAPTURER les services AVANT de fermer la page
    final provider = Provider.of<SupplierProvider>(context, listen: false);
    final activityProvider = Provider.of<ActivityProvider>(context, listen: false);

    final supplier = Supplier(
      id: widget.supplier?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      contactName: _contactController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      category: 'General',
      createdAt: widget.supplier?.createdAt ?? DateTime.now(),
    );

    // 1. On quitte la page d'abord
    Navigator.pop(context);

    // 2. On attend la fin de la transition
    Future.delayed(const Duration(milliseconds: 300), () {
      // 3. On met à jour les données
      if (widget.supplier != null) {
        provider.updateSupplier(supplier);
        activityProvider.addActivity(
          title: 'Fournisseur modifié: ${supplier.name}',
          type: ActivityType.warning,
          icon: Icons.edit,
        );
      } else {
        provider.addSupplier(supplier);
        activityProvider.addActivity(
          title: 'Nouveau fournisseur: ${supplier.name}',
          type: ActivityType.success,
          icon: Icons.business,
        );
      }

      // 4. Message de succès global
      AppTheme.messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Fournisseur ${supplier.name} enregistré"),
          backgroundColor: AppTheme.success,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.supplier != null ? 'Modifier Fournisseur' : 'Nouveau Fournisseur')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nom de l\'entreprise', prefixIcon: Icon(Icons.business))),
            const SizedBox(height: 16),
            TextField(controller: _contactController, decoration: const InputDecoration(labelText: 'Nom du contact', prefixIcon: Icon(Icons.person))),
            const SizedBox(height: 16),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email))),
            const SizedBox(height: 16),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Téléphone', prefixIcon: Icon(Icons.phone))),
            const SizedBox(height: 16),
            TextField(controller: _addressController, maxLines: 2, decoration: const InputDecoration(labelText: 'Adresse', prefixIcon: Icon(Icons.map))),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _save, child: const Text('Enregistrer Fournisseur')),
            ),
          ],
        ),
      ),
    );
  }
}
