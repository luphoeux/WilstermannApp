/// Modelo para un item en el carrito de compras
class CartItem {
  final String id;
  final String title;
  final String price;
  final String type; // 'abono', 'producto', etc.
  final Map<String, dynamic> details;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.type,
    required this.details,
    DateTime? addedAt,
  }) : addedAt = addedAt ?? DateTime.now();

  /// Convierte el item a JSON para persistencia
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'type': type,
      'details': details,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  /// Crea un CartItem desde JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      type: json['type'] as String,
      details: json['details'] as Map<String, dynamic>,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  /// Extrae el precio numérico (sin "Bs")
  double get numericPrice {
    final priceStr = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(priceStr) ?? 0.0;
  }
}
