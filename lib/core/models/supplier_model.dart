
class Supplier {
  final String id;
  final String name;
  final String contactName;
  final String email;
  final String phone;
  final String address;
  final String category; // e.g., "Electronics", "Groceries"
  final DateTime createdAt;

  Supplier({
    required this.id,
    required this.name,
    required this.contactName,
    required this.email,
    required this.phone,
    required this.address,
    required this.category,
    required this.createdAt,
  });

  Supplier copyWith({
    String? name,
    String? contactName,
    String? email,
    String? phone,
    String? address,
    String? category,
  }) {
    return Supplier(
      id: id,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      category: category ?? this.category,
      createdAt: createdAt,
    );
  }
}
