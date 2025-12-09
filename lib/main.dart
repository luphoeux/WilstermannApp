import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/strings.dart';
import 'presentation/screens/splash_screen.dart';
import 'core/services/data_cache_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar orientación de pantalla
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configurar barra de estado
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Precargar datos en segundo plano
  _preloadData();

  runApp(const WilstermannApp());
}

/// Precarga datos JSON en segundo plano para mejorar performance
void _preloadData() {
  final cacheService = DataCacheService();
  cacheService.preloadData([
    'assets/data/partidos_futuros.json',
    'assets/data/partidos_pasados.json',
    'assets/data/tabla_posiciones.json',
  ]);
}

class WilstermannApp extends StatelessWidget {
  const WilstermannApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
