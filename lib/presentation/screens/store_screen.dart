import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/services/cart_service.dart';
import '../../core/models/cart_item.dart';
import '../widgets/custom_card.dart';
import 'purchase/purchase_detail_screen.dart';
import 'main_screen.dart';
import 'cart_screen.dart';
import '../../core/services/auth_service.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final CartService _cartService = CartService();
  int _cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCartCount();
  }

  Future<void> _loadCartCount() async {
    final count = await _cartService.getItemCount();
    setState(() {
      _cartItemCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda Oficial'),
        backgroundColor: AppColors.primary,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                  // Recargar el contador al volver
                  _loadCartCount();
                },
              ),
              if (_cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      _cartItemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  children: [
                    Text(
                      'Nuestros Abonos',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Temporada 2026',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Grid de Abonos
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    _buildAbonoCard(
                      'Curva',
                      'Bs 300',
                      Colors.red.shade700,
                      'assets/images/abono_curva.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildAbonoCard(
                      'General',
                      'Bs 500',
                      Colors.red.shade800,
                      'assets/images/abono_general.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildAbonoCard(
                      'Preferencia',
                      'Bs 800',
                      AppColors.primary,
                      'assets/images/abono_preferencia.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildAbonoCard(
                      'Preferencia Numerada',
                      'Bs 900',
                      Colors.black87,
                      'assets/images/abono_preferencia_numerada.jpg',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbonoCard(
      String title, String price, Color color, String imagePath) {
    final abonoData = {'title': title, 'price': price};

    return CustomCard(
      padding: EdgeInsets.zero,
      onTap: () {
        _startPurchaseFlow(abonoData);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del Abono
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Contenido de la tarjeta
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Abonos',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Conviértete en socio y vive el fútbol como un Aviador.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _startPurchaseFlow(abonoData);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.grey),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('¡Comprar ahora!'),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _saveForLater(abonoData),
                      icon: const Icon(Icons.bookmark_border),
                      tooltip: 'Guardar para después',
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveForLater(Map<String, dynamic> abono) async {
    final cartItem = CartItem(
      id: 'abono_${abono['title'].toString().toLowerCase().replaceAll(' ', '_')}',
      title: abono['title'] as String,
      price: abono['price'] as String,
      type: 'abono',
      details: abono,
    );

    await _cartService.addItem(cartItem);
    await _loadCartCount();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${abono['title']} guardado en el carrito'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Ver carrito',
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
        ),
      );
    }
  }

  Future<void> _startPurchaseFlow(Map<String, dynamic> abono) async {
    final authService = AuthService();
    final isLoggedIn = await authService.isLoggedIn();

    if (!isLoggedIn) {
      if (mounted) {
        // Redirigir a pestaña de perfil para login
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainScreen(initialIndex: 3),
          ),
        );
        return; // Salir del flujo ya que cambiamos de pantalla
      }
    } else {
      // Si ya está logueado, continuar directo
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PurchaseDetailScreen(abono: abono),
          ),
        );
      }
    }
  }
}
