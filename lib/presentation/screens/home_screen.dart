import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/colors.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/profile_service.dart';
import '../widgets/custom_card.dart';
import 'main_screen.dart';
import 'all_news_screen.dart';
import 'news_detail_screen.dart';
import 'match_detail_screen.dart';
import 'store_screen.dart';
import 'fixture_screen.dart';
import '../../core/utils/team_helper.dart';
import '../../core/services/data_cache_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _bannerController = PageController();
  final _authService = AuthService();
  final _profileService = ProfileService();
  int _currentBannerIndex = 0;
  bool _isLoggedIn = false;
  String _userName = '';
  String _userInitials = 'U';
  Timer? _autoScrollTimer;
  bool _userInteracted = false;
  Map<String, dynamic>? _nextMatch;
  bool _isLoadingNextMatch = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _startAutoScroll();
    _loadNextMatchFromCsv();
  }

  Future<void> _loadNextMatchFromCsv() async {
    try {
      final cacheService = DataCacheService();
      final jsonData =
          await cacheService.loadJsonData('assets/data/partidos_futuros.json');
      final List<dynamic> partidos = jsonData['partidos'];

      if (partidos.isNotEmpty) {
        final partido = partidos.first;
        setState(() {
          _nextMatch = {
            'date': partido['fecha'],
            'time': partido['hora'],
            'home': partido['equipoLocal'],
            'away': partido['equipoVisitante'],
            'stadium': partido['estadio'],
            'competition': partido['competicion'],
            'city': partido['ciudad'],
          };
          _isLoadingNextMatch = false;
        });
      } else {
        setState(() => _isLoadingNextMatch = false);
      }
    } catch (e) {
      debugPrint('Error cargando próximo partido: $e');
      setState(() => _isLoadingNextMatch = false);
    }
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();

    String displayName = '';
    String initials = 'U';

    if (loggedIn) {
      // Intentar obtener el nombre del perfil
      final hasProfile = await _profileService.hasProfile();
      if (hasProfile) {
        displayName = await _profileService.getFirstName();
        initials = await _profileService.getProfileInitials();
      } else {
        // Si no hay perfil, usar email como fallback
        final email = await _authService.getCurrentUserEmail();
        if (email != null) {
          displayName = email.split('@').first;
          // Capitalizar primera letra
          if (displayName.isNotEmpty) {
            displayName =
                displayName[0].toUpperCase() + displayName.substring(1);
          }
          initials =
              displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
        }
      }
    }

    setState(() {
      _isLoggedIn = loggedIn;
      _userName = displayName;
      _userInitials = initials;
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
            automaticallyImplyLeading: false,
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
                                GestureDetector(
                                  onTap: _isLoggedIn
                                      ? () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const MainScreen(
                                                  initialIndex: 3),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: _isLoggedIn
                                          ? Border.all(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              width: 2)
                                          : null,
                                    ),
                                    padding: _isLoggedIn
                                        ? EdgeInsets.zero
                                        : const EdgeInsets.all(6),
                                    child: _isLoggedIn
                                        ? Center(
                                            child: Text(
                                              _userInitials,
                                              style: const TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            'assets/logos/logo svg.svg',
                                            fit: BoxFit.contain,
                                          ),
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
                                      _showNotificationsSidebar(context);
                                    },
                                  )
                                : TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const MainScreen(initialIndex: 3),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Inicia sesión',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const StoreScreen()));
        },
      },
      {
        'image': 'assets/images/banner2.jpg',
        'action': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AllNewsScreen()));
        },
      },
      {
        'image': 'assets/images/banner3.jpg',
        'action': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const FixtureScreen()));
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
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primaryLight,
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
    if (_isLoadingNextMatch) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_nextMatch == null) {
      return const SizedBox.shrink();
    }

    final match = _nextMatch!;

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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MatchDetailScreen(match: match)));
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Competición (Badge)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          match['competition'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Equipos y Marcador/VS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Equipo Local
                          Expanded(
                            child: Column(
                              children: [
                                _buildTeamLogo(match['home'] as String, 64),
                                const SizedBox(height: 12),
                                Text(
                                  match['home'] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // VS / Info Central
                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'VS',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    match['time'] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Equipo Visitante
                          Expanded(
                            child: Column(
                              children: [
                                _buildTeamLogo(match['away'] as String, 64),
                                const SizedBox(height: 12),
                                Text(
                                  match['away'] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Divider
                      Divider(color: Colors.grey.shade100, height: 1),

                      const SizedBox(height: 12),

                      // Footer: Fecha y Estadio
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 6),
                          Text(
                            match['date'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(Icons.stadium_outlined,
                              size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              '${match['stadium']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamLogo(String teamName, double size) {
    final isWilstermann = teamName == 'Wilstermann';

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isWilstermann ? AppColors.primary : Colors.grey.shade200,
          width: isWilstermann ? 3 : 1, // Wilstermann con borde más grueso
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(size * 0.15), // Padding proporcional
      child: ClipOval(
        child: Image.asset(
          TeamHelper.getTeamIcon(teamName),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                teamName.isNotEmpty ? teamName[0] : '?',
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeaturedNews() {
    final news = [
      {
        'id': '1',
        'title': 'Wilstermann se prepara para el clásico',
        'date': 'Hace 2 horas',
        'image': 'assets/images/news1.jpg',
        'content':
            'El equipo aviador intensifica sus entrenamientos de cara al clásico cochabambino del próximo domingo...',
      },
      {
        'id': '2',
        'title': 'Nuevos refuerzos para la temporada 2026',
        'date': 'Hace 5 horas',
        'image': 'assets/images/news2.jpg',
        'content':
            'La directiva del club confirma la llegada de tres nuevos jugadores para reforzar el plantel...',
      },
      {
        'id': '3',
        'title': 'Entrevista exclusiva con el DT',
        'date': 'Hace 1 día',
        'image': 'assets/images/news3.jpg',
        'content':
            'El director técnico habla sobre los objetivos del equipo para esta temporada...',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AllNewsScreen(),
                    ),
                  );
                },
                child: const Text('Ver todas'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...news.map((item) {
            return CustomCard(
              margin: const EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.zero,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsDetailScreen(news: item),
                  ),
                );
              },
              child: Row(
                children: [
                  // Imagen sin padding, más grande
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    child: const Icon(
                      Icons.article,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  // Contenido con padding
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
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
                  ),
                  // Icono chevron con padding
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showNotificationsSidebar(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Notificaciones',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: Material(
              color: Colors.white,
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Notificaciones',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      // Lista de notificaciones
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            _buildNotificationItem(
                              icon: Icons.card_membership,
                              iconColor: AppColors.primary,
                              title: 'Membresía Activada',
                              message:
                                  'Tu membresía Aviador 2026 ha sido activada exitosamente.',
                              time: 'Hace 5 min',
                              isNew: true,
                            ),
                            _buildNotificationItem(
                              icon: Icons.sports_soccer,
                              iconColor: Colors.green,
                              title: '⚽ Gol de Wilstermann!',
                              message:
                                  'Minuto 23\' - Wilstermann 1-0 Rival. ¡Vamos Aviador!',
                              time: 'Hace 15 min',
                              isNew: true,
                            ),
                            _buildNotificationItem(
                              icon: Icons.warning_amber_rounded,
                              iconColor: Colors.orange,
                              title: 'Membresía por vencer',
                              message:
                                  'Tu membresía vencerá en 7 días. Renueva ahora y no te pierdas ningún partido.',
                              time: 'Hace 2 horas',
                              isNew: false,
                            ),
                            _buildNotificationItem(
                              icon: Icons.article,
                              iconColor: AppColors.secondary,
                              title: 'Nueva publicación',
                              message:
                                  'Wilstermann se prepara para el clásico cochabambino del domingo.',
                              time: 'Hace 3 horas',
                              isNew: false,
                            ),
                            _buildNotificationItem(
                              icon: Icons.local_offer,
                              iconColor: Colors.red,
                              title: '🎉 Promoción especial',
                              message:
                                  '50% de descuento en productos oficiales. Solo por hoy!',
                              time: 'Hace 5 horas',
                              isNew: false,
                            ),
                            _buildNotificationItem(
                              icon: Icons.stadium,
                              iconColor: AppColors.primary,
                              title: 'Próximo partido',
                              message:
                                  'Wilstermann vs Rival - Dom 15 Dic, 16:00 en el Félix Capriles',
                              time: 'Hace 1 día',
                              isNew: false,
                            ),
                            _buildNotificationItem(
                              icon: Icons.shopping_bag,
                              iconColor: Colors.blue,
                              title: 'Pedido confirmado',
                              message:
                                  'Tu pedido #12345 ha sido confirmado y está en camino.',
                              time: 'Hace 2 días',
                              isNew: false,
                            ),
                            _buildNotificationItem(
                              icon: Icons.celebration,
                              iconColor: Colors.purple,
                              title: '🎂 Día del Aviador',
                              message:
                                  'Celebra con nosotros el aniversario del club. Eventos especiales este fin de semana.',
                              time: 'Hace 3 días',
                              isNew: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    required bool isNew,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNew ? AppColors.primaryVeryLight : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isNew ? AppColors.primary.withOpacity(0.3) : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isNew ? FontWeight.bold : FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (isNew)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
