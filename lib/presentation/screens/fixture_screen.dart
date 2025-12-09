import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/team_helper.dart';
import 'match_detail_screen.dart';
import '../../core/services/data_cache_service.dart';

class FixtureScreen extends StatefulWidget {
  const FixtureScreen({super.key});

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _parsedMatches = [];

  // Variables para paginación de Resultados
  List<Map<String, dynamic>> _allPastMatches = [];
  bool _isLoadingMatches = true;
  bool _isLoadingPastMatches = true;

  // Variables para tabla de posiciones
  List<Map<String, dynamic>> _standings = [];
  bool _isLoadingStandings = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadMatchesFromCsv();
    _loadPastMatchesFromCsv();
    _loadStandingsFromCsv();
  }

  Future<void> _loadPastMatchesFromCsv() async {
    try {
      final cacheService = DataCacheService();
      final jsonData =
          await cacheService.loadJsonData('assets/data/partidos_pasados.json');
      final List<dynamic> partidos = jsonData['partidos'];

      final List<Map<String, dynamic>> loadedMatches = partidos.map((partido) {
        return {
          'date': partido['fecha'],
          'time': partido['hora'],
          'home': partido['equipoLocal'],
          'away': partido['equipoVisitante'],
          'homeScore': partido['golesLocal'],
          'awayScore': partido['golesVisitante'],
          'stadium': partido['estadio'],
          'competition': partido['competicion'],
          'city': partido['ciudad'],
        };
      }).toList();

      setState(() {
        _allPastMatches = loadedMatches;
        _isLoadingPastMatches = false;
      });
    } catch (e) {
      debugPrint('Error cargando partidos pasados: $e');
      setState(() {
        _isLoadingPastMatches = false;
      });
    }
  }

  Future<void> _loadStandingsFromCsv() async {
    try {
      final cacheService = DataCacheService();
      final jsonData =
          await cacheService.loadJsonData('assets/data/tabla_posiciones.json');
      final List<dynamic> equipos = jsonData['equipos'];

      final List<Map<String, dynamic>> loadedStandings = equipos.map((equipo) {
        return {
          'position': equipo['posicion'],
          'name': equipo['equipo'],
          'pj': equipo['pj'],
          'pg': equipo['pg'],
          'pe': equipo['pe'],
          'pp': equipo['pp'],
          'gf': equipo['gf'],
          'gc': equipo['gc'],
          'dg': equipo['dg'],
          'points': equipo['pts'],
        };
      }).toList();

      setState(() {
        _standings = loadedStandings;
        _isLoadingStandings = false;
      });
    } catch (e) {
      debugPrint('Error cargando tabla de posiciones: $e');
      setState(() {
        _isLoadingStandings = false;
      });
    }
  }

  Future<void> _loadMatchesFromCsv() async {
    try {
      final cacheService = DataCacheService();
      final jsonData =
          await cacheService.loadJsonData('assets/data/partidos_futuros.json');
      final List<dynamic> partidos = jsonData['partidos'];

      final List<Map<String, dynamic>> loadedMatches = partidos.map((partido) {
        return {
          'date': partido['fecha'],
          'time': partido['hora'],
          'home': partido['equipoLocal'],
          'away': partido['equipoVisitante'],
          'stadium': partido['estadio'],
          'competition': partido['competicion'],
          'city': partido['ciudad'],
        };
      }).toList();

      setState(() {
        _parsedMatches = loadedMatches;
        _isLoadingMatches = false;
      });
    } catch (e) {
      debugPrint('Error cargando partidos: $e');
      setState(() {
        _isLoadingMatches = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixture'),
        backgroundColor: AppColors.primary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Próximos'),
            Tab(text: 'Resultados'),
            Tab(text: 'Tabla'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingMatches(),
          _buildResults(),
          _buildStandings(),
        ],
      ),
    );
  }

  Widget _buildUpcomingMatches() {
    if (_isLoadingMatches) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_parsedMatches.isEmpty) {
      return const Center(child: Text('No hay partidos programados'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _parsedMatches.length,
      itemBuilder: (context, index) {
        final match = _parsedMatches[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
        );
      },
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

  Widget _buildResults() {
    if (_isLoadingPastMatches) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_allPastMatches.isEmpty) {
      return const Center(child: Text('No hay resultados disponibles'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _allPastMatches.length,
      itemBuilder: (context, index) {
        final match = _allPastMatches[index];

        // Determinar resultado para Wilstermann
        final isHome = match['home'] == 'Wilstermann';
        final isAway = match['away'] ==
            'Wilstermann'; // Debería ser true si no es home, pero por seguridad
        final homeScore = int.tryParse(match['homeScore'].toString()) ?? 0;
        final awayScore = int.tryParse(match['awayScore'].toString()) ?? 0;

        String resultText = 'Empate';
        Color resultColor = Colors.grey;
        Color resultBgColor = Colors.grey.shade100;

        if (isHome) {
          if (homeScore > awayScore) {
            resultText = 'Victoria';
            resultColor = Colors.green;
            resultBgColor = Colors.green.shade50;
          } else if (homeScore < awayScore) {
            resultText = 'Derrota';
            resultColor = Colors.red;
            resultBgColor = Colors.red.shade50;
          }
        } else if (isAway) {
          if (awayScore > homeScore) {
            resultText = 'Victoria';
            resultColor = Colors.green;
            resultBgColor = Colors.green.shade50;
          } else if (awayScore < homeScore) {
            resultText = 'Derrota';
            resultColor = Colors.red;
            resultBgColor = Colors.red.shade50;
          }
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                    // Competición y estado
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          match['competition'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: resultBgColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            resultText.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: resultColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Equipos y Marcador
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Equipo Local
                        Expanded(
                          child: Column(
                            children: [
                              _buildTeamLogo(match['home'] as String, 50),
                              const SizedBox(height: 8),
                              Text(
                                match['home'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
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

                        // Marcador Central
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${match['homeScore']}',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: isHome && resultText == 'Victoria' ||
                                          !isHome && resultText == 'Derrota'
                                      ? AppColors.primary
                                      : Colors.black87,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Text(
                                '${match['awayScore']}',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: isAway && resultText == 'Victoria' ||
                                          !isAway && resultText == 'Derrota'
                                      ? AppColors.primary
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Equipo Visitante
                        Expanded(
                          child: Column(
                            children: [
                              _buildTeamLogo(match['away'] as String, 50),
                              const SizedBox(height: 8),
                              Text(
                                match['away'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
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

                    const SizedBox(height: 20),
                    Divider(height: 1, color: Colors.grey.shade100),
                    const SizedBox(height: 12),

                    // Fecha
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
                        if (match['stadium'] != null) ...[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              match['stadium'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStandings() {
    if (_isLoadingStandings) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_standings.isEmpty) {
      return const Center(child: Text('No hay datos de tabla disponibles'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de la competición
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Liga Profesional 2026',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          // Tabla
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // Encabezado
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildHeaderCell('#', 40),
                      _buildHeaderCell('Equipo', 150),
                      _buildHeaderCell('PJ', 40),
                      _buildHeaderCell('PG', 40),
                      _buildHeaderCell('PE', 40),
                      _buildHeaderCell('PP', 40),
                      _buildHeaderCell('GF', 40),
                      _buildHeaderCell('GC', 40),
                      _buildHeaderCell('DG', 45),
                      _buildHeaderCell('PTS', 45),
                    ],
                  ),
                ),

                // Filas de equipos
                ..._standings.asMap().entries.map((entry) {
                  final index = entry.key;
                  final team = entry.value;
                  final isWilstermann = team['name'] == 'Wilstermann';
                  final isLast = index == _standings.length - 1;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: isWilstermann
                          ? AppColors.primaryVeryLight
                          : Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: isWilstermann
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          width: isWilstermann ? 2 : 1,
                        ),
                        right: BorderSide(
                          color: isWilstermann
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          width: isWilstermann ? 2 : 1,
                        ),
                        bottom: BorderSide(
                          color: isWilstermann
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      borderRadius: isLast
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        _buildDataCell(
                          '${team['position']}',
                          40,
                          isWilstermann,
                          isBold: true,
                        ),
                        _buildTeamCell(
                          team['name'] as String,
                          150,
                          isWilstermann,
                        ),
                        _buildDataCell('${team['pj']}', 40, isWilstermann),
                        _buildDataCell('${team['pg']}', 40, isWilstermann),
                        _buildDataCell('${team['pe']}', 40, isWilstermann),
                        _buildDataCell('${team['pp']}', 40, isWilstermann),
                        _buildDataCell('${team['gf']}', 40, isWilstermann),
                        _buildDataCell('${team['gc']}', 40, isWilstermann),
                        _buildDataCell(
                          '${team['dg']}',
                          45,
                          isWilstermann,
                          color: (team['dg'] as int) > 0
                              ? Colors.green.shade700
                              : (team['dg'] as int) < 0
                                  ? Colors.red.shade700
                                  : null,
                        ),
                        _buildDataCell(
                          '${team['points']}',
                          45,
                          isWilstermann,
                          isBold: true,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(
    String text,
    double width,
    bool isWilstermann, {
    bool isBold = false,
    Color? color,
  }) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isBold
              ? FontWeight.bold
              : isWilstermann
                  ? FontWeight.w600
                  : FontWeight.normal,
          color: color ?? (isWilstermann ? AppColors.primary : Colors.black87),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTeamCell(String name, double width, bool isWilstermann) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isWilstermann ? AppColors.primary : Colors.grey.shade300,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: Image.asset(
                TeamHelper.getTeamIcon(name),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.sports_soccer,
                    size: 14,
                    color: isWilstermann ? AppColors.primary : Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontWeight: isWilstermann ? FontWeight.bold : FontWeight.w500,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
