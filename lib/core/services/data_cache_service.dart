import 'dart:convert';
import 'package:flutter/services.dart';

/// Servicio de caché para datos JSON
/// Evita cargar los mismos datos múltiples veces
class DataCacheService {
  static final DataCacheService _instance = DataCacheService._internal();
  factory DataCacheService() => _instance;
  DataCacheService._internal();

  // Caché en memoria
  final Map<String, dynamic> _cache = {};

  /// Carga datos JSON con caché
  Future<Map<String, dynamic>> loadJsonData(String assetPath) async {
    // Si ya está en caché, retornar inmediatamente
    if (_cache.containsKey(assetPath)) {
      return _cache[assetPath];
    }

    // Cargar desde assets
    final jsonString = await rootBundle.loadString(assetPath);
    final data = json.decode(jsonString) as Map<String, dynamic>;

    // Guardar en caché
    _cache[assetPath] = data;

    return data;
  }

  /// Limpia el caché (útil para refrescar datos)
  void clearCache([String? assetPath]) {
    if (assetPath != null) {
      _cache.remove(assetPath);
    } else {
      _cache.clear();
    }
  }

  /// Precarga datos en segundo plano
  Future<void> preloadData(List<String> assetPaths) async {
    for (final path in assetPaths) {
      if (!_cache.containsKey(path)) {
        try {
          await loadJsonData(path);
        } catch (e) {
          // Ignorar errores de precarga
        }
      }
    }
  }
}
