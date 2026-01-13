enum MovementType {
  IN,
  OUT,
}

class StockMovement {
  final String id;
  final String productId;
  final int quantity;
  final MovementType type;
  final String reason; // e.g., "Sale", "Restock", "Damage"
  final DateTime date;
  final String userId; // User who recorded the movement

  StockMovement({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.type,
    required this.reason,
    required this.date,
    required this.userId,
  });
}
