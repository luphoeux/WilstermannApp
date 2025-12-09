import 'package:flutter/material.dart';

/// Colores oficiales del Club Wilstermann
class AppColors {
  // Colores principales
  static const Color primary = Color(0xFF020747); // Azul oscuro Wilstermann
  static const Color secondary = Color(0xFFFFFFFF); // Blanco
  static const Color accent = Color(0xFFFF0806); // Rojo Wilstermann

  // Colores de texto
  static const Color textPrimary = Color(0xFF2C3E50); // Gris oscuro
  static const Color textSecondary = Color(0xFF7F8C8D); // Gris medio
  static const Color textLight = Color(0xFFFFFFFF); // Blanco

  // Colores de fondo
  static const Color background = Color(0xFFF6F9F9); // Gris muy claro
  static const Color backgroundLight = Color(0xFFF8F9FA); // Gris muy claro
  static const Color backgroundDark = Color(0xFF2C3E50); // Gris oscuro

  // Colores de estado
  static const Color success = Color(0xFF27AE60); // Verde
  static const Color warning = Color(0xFFF39C12); // Naranja
  static const Color error = Color(0xFFE74C3C); // Rojo error
  static const Color info = Color(0xFF3498DB); // Azul info

  // Colores de membresías
  static const Color membershipBasic = Color(0xFF95A5A6); // Gris
  static const Color membershipPremium = Color(0xFFE67E22); // Naranja
  static const Color membershipVip = Color(0xFFF1C40F); // Dorado
  static const Color membershipFamily = Color(0xFF9B59B6); // Púrpura

  // Colores de gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF020747), Color(0xFF010530)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF0806), Color(0xFFCC0605)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Colores con opacidad predefinida (usando Color.fromRGBO para evitar withOpacity)
  static const Color primaryLight = Color.fromRGBO(2, 7, 71, 0.7);
  static const Color primaryVeryLight = Color.fromRGBO(2, 7, 71, 0.1);

  static const Color accentLight = Color.fromRGBO(255, 8, 6, 0.1);

  static const Color whiteLight = Color.fromRGBO(255, 255, 255, 0.9);
  static const Color whiteMedium = Color.fromRGBO(255, 255, 255, 0.5);
  static const Color whiteVeryLight = Color.fromRGBO(255, 255, 255, 0.3);
  static const Color whiteUltraLight = Color.fromRGBO(255, 255, 255, 0.2);

  static const Color blackLight = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color blackMedium = Color.fromRGBO(0, 0, 0, 0.08);
  static const Color blackVeryLight = Color.fromRGBO(0, 0, 0, 0.05);

  static const Color greenLight = Color.fromRGBO(39, 174, 96, 0.1);
  static const Color orangeLight = Color.fromRGBO(243, 156, 18, 0.1);
  static const Color redLight = Color.fromRGBO(255, 0, 0, 0.1);
}
