import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

/// Servicio para gestionar el carrito de compras
class CartService {
  static const String _cartKey = 'shopping_cart';

  // Singleton pattern
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  /// Obtiene todos los items del carrito
  Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);

    if (cartJson == null || cartJson.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decoded = json.decode(cartJson);
      final items = decoded.map((item) => CartItem.fromJson(item)).toList();

      // Verificar si hay items con datos corruptos (objetos Color)
      bool hasCorruptedData = false;
      for (var item in items) {
        for (var value in item.details.values) {
          final typeStr = value.runtimeType.toString();
          if (typeStr.contains('Color') || typeStr.contains('MaterialColor')) {
            hasCorruptedData = true;
            break;
          }
        }
        if (hasCorruptedData) break;
      }

      // Si hay datos corruptos, limpiar completamente el carrito
      if (hasCorruptedData) {
        await clearCart();
        return [];
      }

      return items;
    } catch (e) {
      // Si hay error al decodificar, limpiar el carrito
      await clearCart();
      return [];
    }
  }

  /// Agrega un item al carrito
  Future<void> addItem(CartItem item) async {
    final items = await getCartItems();

    // Verificar si el item ya existe (por ID)
    final existingIndex = items.indexWhere((i) => i.id == item.id);

    if (existingIndex >= 0) {
      // Si existe, reemplazarlo (actualizar)
      items[existingIndex] = item;
    } else {
      // Si no existe, agregarlo
      items.add(item);
    }

    await _saveCart(items);
  }

  /// Elimina un item del carrito por ID
  Future<void> removeItem(String itemId) async {
    final items = await getCartItems();
    items.removeWhere((item) => item.id == itemId);
    await _saveCart(items);
  }

  /// Limpia todo el carrito
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  /// Obtiene el número total de items en el carrito
  Future<int> getItemCount() async {
    final items = await getCartItems();
    return items.length;
  }

  /// Calcula el total del carrito
  Future<double> getTotal() async {
    final items = await getCartItems();
    double total = 0.0;
    for (var item in items) {
      total += item.numericPrice;
    }
    return total;
  }

  /// Verifica si un item específico está en el carrito
  Future<bool> isInCart(String itemId) async {
    final items = await getCartItems();
    return items.any((item) => item.id == itemId);
  }

  /// Guarda el carrito en SharedPreferences
  Future<void> _saveCart(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();

    // Limpiar items antes de guardar (remover objetos no serializables)
    final cleanedItems = items.map((item) {
      final cleanedDetails = <String, dynamic>{};

      // Copiar solo los valores serializables
      item.details.forEach((key, value) {
        final typeStr = value.runtimeType.toString();
        // Excluir objetos Color y otros no serializables
        if (!typeStr.contains('Color') && !typeStr.contains('MaterialColor')) {
          cleanedDetails[key] = value;
        }
      });

      return CartItem(
        id: item.id,
        title: item.title,
        price: item.price,
        type: item.type,
        details: cleanedDetails,
        addedAt: item.addedAt,
      );
    }).toList();

    final cartJson =
        json.encode(cleanedItems.map((item) => item.toJson()).toList());
    await prefs.setString(_cartKey, cartJson);
  }

  /// Obtiene un item específico del carrito por ID
  Future<CartItem?> getItem(String itemId) async {
    final items = await getCartItems();
    try {
      return items.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }
}
