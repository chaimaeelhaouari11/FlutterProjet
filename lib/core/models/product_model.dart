
class Product {
  final String id;
  final String name;
  final String sku;
  final String categoryId;
  final String supplierId;
  final String description;
  final double purchasePrice;
  final double sellingPrice;
  final int currentStock;
  final int minStockLevel;
  final String unit; // e.g., "Kg", "Unit", "Box"
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.categoryId,
    required this.supplierId,
    required this.description,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.currentStock,
    required this.minStockLevel,
    required this.unit,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isLowStock => currentStock <= minStockLevel;

  Product copyWith({
    String? name,
    String? sku,
    String? categoryId,
    String? supplierId,
    String? description,
    double? purchasePrice,
    double? sellingPrice,
    int? currentStock,
    int? minStockLevel,
    String? unit,
    String? imageUrl,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      categoryId: categoryId ?? this.categoryId,
      supplierId: supplierId ?? this.supplierId,
      description: description ?? this.description,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      currentStock: currentStock ?? this.currentStock,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      unit: unit ?? this.unit,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
