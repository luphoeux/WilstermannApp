import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../widgets/custom_card.dart';

class FixtureScreen extends StatefulWidget {
  const FixtureScreen({super.key});

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    final matches = List.generate(
      5,
      (index) => {
        'date': 'Dom ${15 + index} Dic',
        'time': '16:00',
        'competition': 'Liga Profesional - Fecha ${15 + index}',
        'home': 'Wilstermann',
        'away': 'Rival ${index + 1}',
        'stadium': 'Estadio Félix Capriles',
      },
    );

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return CustomCard(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          onTap: () {
            // TODO: Navegar a detalle del partido
          },
          child: Column(
            children: [
              // Competición
              Text(
                match['competition'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              // Equipos
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
                        Text(
                          match['home'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // VS y hora
                  Column(
                    children: [
                      const Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match['date'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        match['time'] as String,
                        style: const TextStyle(
                          fontSize: 14,
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
                        Text(
                          match['away'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Estadio
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.stadium, size: 16, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      match['stadium'] as String,
                      style: const TextStyle(
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
        );
      },
    );
  }

  Widget _buildResults() {
    final results = List.generate(
      8,
      (index) => {
        'date': 'Dom ${1 + index} Dic',
        'competition': 'Liga Profesional - Fecha ${7 + index}',
        'home': index % 2 == 0 ? 'Wilstermann' : 'Rival ${index + 1}',
        'away': index % 2 == 0 ? 'Rival ${index + 1}' : 'Wilstermann',
        'homeScore': index % 2 == 0 ? '3' : '1',
        'awayScore': index % 2 == 0 ? '1' : '2',
        'stadium': 'Estadio Félix Capriles',
      },
    );

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final match = results[index];
        final isWin = (match['home'] == 'Wilstermann' && 
                      int.parse(match['homeScore'] as String) > int.parse(match['awayScore'] as String)) ||
                     (match['away'] == 'Wilstermann' && 
                      int.parse(match['awayScore'] as String) > int.parse(match['homeScore'] as String));

        return CustomCard(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          onTap: () {
            // TODO: Navegar a detalle del partido
          },
          child: Column(
            children: [
              // Competición y resultado
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isWin ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isWin ? 'Victoria' : 'Derrota',
                      style: TextStyle(
                        fontSize: 10,
                        color: isWin ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Equipos y resultado
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Equipo Local
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: match['home'] == 'Wilstermann' 
                                ? AppColors.primary 
                                : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.sports_soccer,
                            color: match['home'] == 'Wilstermann' 
                                ? Colors.white 
                                : Colors.grey,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          match['home'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Marcador
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          match['homeScore'] as String,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          '-',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          match['awayScore'] as String,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Equipo Visitante
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: match['away'] == 'Wilstermann' 
                                ? AppColors.primary 
                                : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.sports_soccer,
                            color: match['away'] == 'Wilstermann' 
                                ? Colors.white 
                                : Colors.grey,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          match['away'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Fecha
              Text(
                match['date'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStandings() {
    final teams = [
      {'position': 1, 'name': 'Bolívar', 'points': 45, 'played': 20, 'won': 14, 'drawn': 3, 'lost': 3},
      {'position': 2, 'name': 'Wilstermann', 'points': 42, 'played': 20, 'won': 13, 'drawn': 3, 'lost': 4},
      {'position': 3, 'name': 'The Strongest', 'points': 40, 'played': 20, 'won': 12, 'drawn': 4, 'lost': 4},
      {'position': 4, 'name': 'Blooming', 'points': 38, 'played': 20, 'won': 11, 'drawn': 5, 'lost': 4},
      {'position': 5, 'name': 'Oriente Petrolero', 'points': 35, 'played': 20, 'won': 10, 'drawn': 5, 'lost': 5},
      {'position': 6, 'name': 'Aurora', 'points': 32, 'played': 20, 'won': 9, 'drawn': 5, 'lost': 6},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Encabezado
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                SizedBox(width: 40, child: Text('#', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(child: Text('Equipo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 40, child: Text('PJ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                SizedBox(width: 40, child: Text('PTS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Tabla
          ...teams.map((team) {
            final isWilstermann = team['name'] == 'Wilstermann';
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isWilstermann ? AppColors.primary.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isWilstermann ? AppColors.primary : Colors.grey.shade200,
                  width: isWilstermann ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${team['position']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isWilstermann ? AppColors.primary : Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: isWilstermann ? AppColors.primary : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.sports_soccer,
                            size: 16,
                            color: isWilstermann ? Colors.white : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            team['name'] as String,
                            style: TextStyle(
                              fontWeight: isWilstermann ? FontWeight.bold : FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${team['played']}',
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${team['points']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
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
}
