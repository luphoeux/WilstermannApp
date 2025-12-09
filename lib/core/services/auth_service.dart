import 'package:shared_preferences/shared_preferences.dart';

/// Servicio de autenticación simple
class AuthService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserEmail = 'user_email';
  
  // Credenciales hardcodeadas
  static const String adminEmail = 'admin@gmail.com';
  static const String adminPassword = '12345678';

  /// Verificar si el usuario está autenticado
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Obtener email del usuario actual
  Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  /// Iniciar sesión
  Future<bool> login(String email, String password) async {
    // Validar credenciales
    if (email == adminEmail && password == adminPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setString(_keyUserEmail, email);
      return true;
    }
    return false;
  }

  /// Cerrar sesión
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserEmail);
  }
}
