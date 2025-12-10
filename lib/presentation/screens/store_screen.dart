import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'purchase/purchase_detail_screen.dart';
import 'main_screen.dart';
import '../../core/services/auth_service.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final List<Map<String, dynamic>> _abonos = [
    {
      'title': 'Curva',
      'price': 'Bs 300',
      'color': AppColors.primary,
      'icon': Icons.sports_soccer,
      'description': 'Vive la pasión desde la curva',
      'image': 'assets/images/abono_curva.jpg',
    },
    {
      'title': 'General',
      'price': 'Bs 500',
      'color': AppColors.primary,
      'icon': Icons.stadium,
      'description': 'Disfruta del partido en general',
      'image': 'assets/images/abono_general.jpg',
    },
    {
      'title': 'Preferencia',
      'price': 'Bs 800',
      'color': AppColors.primary,
      'icon': Icons.event_seat,
      'description': 'Comodidad y mejor vista',
      'image': 'assets/images/abono_preferencia.jpg',
    },
    {
      'title': 'Preferencia Numerada',
      'price': 'Bs 900',
      'color': AppColors.primary,
      'icon': Icons.confirmation_number,
      'description': 'Asiento exclusivo numerado',
      'image': 'assets/images/abono_preferencia_numerada.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda Oficial'),
        backgroundColor: AppColors.primary,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Abonos Temporada 2026',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '¡Vive cada partido como un verdadero Aviador!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Grid de Abonos (2 columnas)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: _abonos.length,
                  itemBuilder: (context, index) {
                    return _buildAbonoCard(_abonos[index]);
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Beneficios
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Beneficios de ser Socio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildBenefitItem(
                        Icons.check_circle,
                        'Acceso a todos los partidos de local',
                      ),
                      _buildBenefitItem(
                        Icons.check_circle,
                        'Descuentos en tienda oficial',
                      ),
                      _buildBenefitItem(
                        Icons.check_circle,
                        'Contenido exclusivo y noticias',
                      ),
                      _buildBenefitItem(
                        Icons.check_circle,
                        'Prioridad en compra de entradas',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbonoCard(Map<String, dynamic> abono) {
    return GestureDetector(
      onTap: () => _startPurchaseFlow(abono),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Image.asset(
                  abono['image'] as String,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Contenido
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Título
                    Text(
                      abono['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),

                    // Descripción
                    Text(
                      abono['description'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Precio y botón
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            abono['price'] as String,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: abono['color'] as Color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        ElevatedButton(
                          onPressed: () => _startPurchaseFlow(abono),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: abono['color'] as Color,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Comprar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green.shade600,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startPurchaseFlow(Map<String, dynamic> abono) async {
    final authService = AuthService();
    final isLoggedIn = await authService.isLoggedIn();

    if (!isLoggedIn) {
      if (mounted) {
        // Mostrar diálogo indicando que debe iniciar sesión
        _showLoginRequiredDialog();
      }
      return;
    }

    // Navegar directamente a la pantalla de detalles de compra
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PurchaseDetailScreen(abono: abono),
        ),
      );
    }
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.lock_outline,
              color: AppColors.primary,
              size: 28,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Inicia sesión',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Para comprar abonos necesitas iniciar sesión.',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),
            Text(
              'Ve al menú de Perfil para iniciar sesión o crear una cuenta.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Entendido',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navegar a la pestaña de perfil
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(initialIndex: 3),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
