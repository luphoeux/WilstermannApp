import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static const String _profileNameKey = 'profile_name';
  static const String _profileInitialsKey = 'profile_initials';

  // Singleton pattern
  static final ProfileService _instance = ProfileService._internal();
  factory ProfileService() => _instance;
  ProfileService._internal();

  /// Guarda el nombre completo del perfil actual
  Future<void> setProfileName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileNameKey, name);

    // Calcular y guardar iniciales automáticamente
    final initials = _getInitials(name);
    await prefs.setString(_profileInitialsKey, initials);
  }

  /// Obtiene el nombre completo del perfil actual
  Future<String?> getProfileName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileNameKey);
  }

  /// Obtiene las iniciales del perfil actual
  Future<String> getProfileInitials() async {
    final prefs = await SharedPreferences.getInstance();
    final initials = prefs.getString(_profileInitialsKey);
    if (initials != null && initials.isNotEmpty) {
      return initials;
    }

    // Si no hay iniciales guardadas, calcularlas del nombre
    final name = await getProfileName();
    if (name != null && name.isNotEmpty) {
      return _getInitials(name);
    }

    return 'U'; // Default
  }

  /// Obtiene el primer nombre para saludos (ej: "Buenas, Luis")
  Future<String> getFirstName() async {
    final fullName = await getProfileName();
    if (fullName == null || fullName.isEmpty) {
      return 'Usuario';
    }

    // Retornar la primera palabra del nombre
    final parts = fullName.trim().split(' ');
    return parts.first;
  }

  /// Limpia los datos del perfil (útil al cerrar sesión)
  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profileNameKey);
    await prefs.remove(_profileInitialsKey);
  }

  /// Calcula las iniciales de un nombre completo
  String _getInitials(String name) {
    if (name.isEmpty) return 'U';

    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      // Solo un nombre: tomar las primeras 2 letras
      return parts[0].length >= 2
          ? parts[0].substring(0, 2).toUpperCase()
          : parts[0][0].toUpperCase();
    }

    // Múltiples palabras: primera letra de cada una (máximo 2)
    final initials = parts.take(2).map((word) => word[0]).join();
    return initials.toUpperCase();
  }

  /// Verifica si hay un perfil configurado
  Future<bool> hasProfile() async {
    final name = await getProfileName();
    return name != null && name.isNotEmpty;
  }
}
