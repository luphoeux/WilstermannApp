import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/colors.dart';
import '../../core/services/auth_service.dart';
import '../widgets/custom_card.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _bannerController = PageController();
  final _authService = AuthService();
  int _currentBannerIndex = 0;
  bool _isLoggedIn = false;
  String _userName = '';
  Timer? _autoScrollTimer;
  bool _userInteracted = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _startAutoScroll();
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    final email = await _authService.getCurrentUserEmail();

    setState(() {
      _isLoggedIn = loggedIn;
      // Extraer nombre del email (antes del @)
      if (email != null) {
        _userName = email.split('@').first;
        // Capitalizar primera letra
        if (_userName.isNotEmpty) {
          _userName = _userName[0].toUpperCase() + _userName.substring(1);
        }
      }
    });
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_userInteracted && _bannerController.hasClients) {
        final nextPage = (_currentBannerIndex + 1) % 3; // 3 banners en loop
        _bannerController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onUserInteraction() {
    setState(() {
      _userInteracted = true;
    });

    // Reactivar auto-scroll después de 6 segundos de inactividad
    _autoScrollTimer?.cancel();
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          _userInteracted = false;
        });
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            expandedHeight: 80,
            floating: true,
            pinned: false,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Logo
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: SvgPicture.asset(
                                    'assets/logos/logo svg.svg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isLoggedIn
                                          ? 'Buenas, $_userName'
                                          : 'Club Wilstermann',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _isLoggedIn
                                          ? 'Sin membresía'
                                          : '¡Vamos Aviador!',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Botón derecho (Login o Notificaciones)
                            _isLoggedIn
                                ? IconButton(
                                    icon: const HugeIcon(
                                      icon:
                                          HugeIcons.strokeRoundedNotification02,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      // TODO: Navegar a notificaciones
                                    },
                                  )
                                : IconButton(
                                    icon: const HugeIcon(
                                      icon: HugeIcons.strokeRoundedLogin02,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const LoginScreen(),
                                        ),
                                      ).then((_) => _checkLoginStatus());
                                    },
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Contenido
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Banner Slider
                _buildBannerSlider(),

                const SizedBox(height: 20),

                // Próximo Partido
                _buildNextMatch(),

                const SizedBox(height: 20),

                // Noticias Destacadas
                _buildFeaturedNews(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSlider() {
    final banners = [
      {
        'image': 'assets/images/banner1.jpg',
        'action': () {
          // TODO: Acción del banner 1
          print('Banner 1 clicked');
        },
      },
      {
        'image': 'assets/images/banner2.jpg',
        'action': () {
          // TODO: Acción del banner 2
          print('Banner 2 clicked');
        },
      },
      {
        'image': 'assets/images/banner3.jpg',
        'action': () {
          // TODO: Acción del banner 3
          print('Banner 3 clicked');
        },
      },
    ];

    return Column(
      children: [
        // Banner rectangular sin padding ni bordes
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            // Altura rectangular: aproximadamente 16:9 o ajustada
            final bannerHeight = screenWidth * 0.56; // Ratio 16:9 aproximado

            return SizedBox(
              width: screenWidth,
              height: bannerHeight,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    _onUserInteraction();
                  }
                  return false;
                },
                child: PageView.builder(
                  controller: _bannerController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: banners[index]['action'] as VoidCallback,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Imagen de fondo
                          Image.asset(
                            banners[index]['image'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Placeholder si no existe la imagen
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primary.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 80,
                                    color: Colors.white54,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        // Indicadores
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentBannerIndex == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentBannerIndex == index
                    ? AppColors.primary
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextMatch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Próximo Partido',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CustomCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Liga Profesional - Fecha 15',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Equipo Local
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.sports_soccer,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Wilstermann',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // VS
                    const Column(
                      children: [
                        Text(
                          'VS',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Dom 15 Dic',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '16:00',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Equipo Visitante
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.sports_soccer,
                              color: Colors.grey,
                              size: 35,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Rival',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stadium, size: 16, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text(
                        'Estadio Félix Capriles',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedNews() {
    final news = [
      {
        'title': 'Wilstermann se prepara para el clásico',
        'date': 'Hace 2 horas',
        'category': 'Noticias',
      },
      {
        'title': 'Nuevos refuerzos para la temporada 2026',
        'date': 'Hace 5 horas',
        'category': 'Fichajes',
      },
      {
        'title': 'Entrevista exclusiva con el DT',
        'date': 'Hace 1 día',
        'category': 'Entrevistas',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Noticias Destacadas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Ver todas las noticias
                },
                child: const Text('Ver todas'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...news.map((item) {
            return CustomCard(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              onTap: () {
                // TODO: Navegar a detalle de noticia
              },
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.article,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item['category']!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['date']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
