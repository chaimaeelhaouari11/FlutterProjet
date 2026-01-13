import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/providers/product_provider.dart';
import '../../../../core/providers/activity_provider.dart';
import '../../../../core/models/activity_model.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;
  const AddEditProductScreen({super.key, this.product});

  bool get isEdit => product != null;

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _skuController;
  late TextEditingController _descriptionController;
  late TextEditingController _purchasePriceController;
  late TextEditingController _sellingPriceController;
  late TextEditingController _stockController;
  late TextEditingController _minStockController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name);
    _skuController = TextEditingController(text: widget.product?.sku);
    _descriptionController = TextEditingController(text: widget.product?.description);
    _purchasePriceController = TextEditingController(text: widget.product?.purchasePrice?.toString());
    _sellingPriceController = TextEditingController(text: widget.product?.sellingPrice?.toString());
    _stockController = TextEditingController(text: widget.product?.currentStock?.toString());
    _minStockController = TextEditingController(text: widget.product?.minStockLevel?.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _stockController.dispose();
    _minStockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final activityProvider = Provider.of<ActivityProvider>(context, listen: false);

    final product = Product(
      id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      sku: _skuController.text,
      categoryId: widget.product?.categoryId ?? 'default',
      supplierId: widget.product?.supplierId ?? 'default',
      description: _descriptionController.text,
      purchasePrice: double.tryParse(_purchasePriceController.text) ?? 0.0,
      sellingPrice: double.tryParse(_sellingPriceController.text) ?? 0.0,
      currentStock: int.tryParse(_stockController.text) ?? 0,
      minStockLevel: int.tryParse(_minStockController.text) ?? 0,
      unit: widget.product?.unit ?? 'Unité',
      createdAt: widget.product?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // 1. On ferme la page IMMÉDIATEMENT
    Navigator.pop(context);

    // 2. On attend que l'animation de fermeture soit terminée (très important pour le Web)
    Future.delayed(const Duration(milliseconds: 300), () {
      // 3. On met à jour les données quand la page n'existe plus
      if (widget.isEdit) {
        productProvider.updateProduct(product);
        activityProvider.addActivity(
          title: 'Produit mis à jour: ${product.name}',
          type: ActivityType.warning,
          icon: Icons.edit_note,
        );
      } else {
        productProvider.addProduct(product);
        activityProvider.addActivity(
          title: 'Nouveau produit: ${product.name}',
          type: ActivityType.success,
          icon: Icons.add_box_outlined,
        );
      }

      // 4. On affiche le message de succès sur la page d'accueil (via la clé globale)
      AppTheme.messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("${product.name} enregistré avec succès"),
          backgroundColor: AppTheme.success,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Modifier le Produit' : 'Ajouter un Produit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildImagePicker(),
              const SizedBox(height: 24),
              _buildTextField('Nom du Produit', Icons.inventory, _nameController),
              const SizedBox(height: 16),
              _buildTextField('SKU / Code-barres', Icons.qr_code_scanner, _skuController),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Prix achat', Icons.download, _purchasePriceController, isNumber: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Prix vente', Icons.upload, _sellingPriceController, isNumber: true)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Quantité', Icons.numbers, _stockController, isNumber: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Seuil alerte', Icons.warning_amber, _minStockController, isNumber: true)),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField('Description', Icons.description, _descriptionController, maxLines: 3),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProduct,
                  child: Text(widget.isEdit ? 'Enregistrer les modifications' : 'Créer le produit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withOpacity(0.1)),
      ),
      child: const Icon(Icons.add_a_photo, size: 40, color: AppTheme.secondary),
    );
  }

  Widget _buildTextField(
      String label,
      IconData icon,
      TextEditingController controller,
      {bool isNumber = false, int maxLines = 1}
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez remplir ce champ';
        }
        if (isNumber && double.tryParse(value) == null) {
          return 'Veuillez entrer un nombre valide';
        }
        return null;
      },
    );
  }
}
