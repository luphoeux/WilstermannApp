import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/team_helper.dart';
import '../widgets/custom_card.dart';

class MatchDetailScreen extends StatelessWidget {
  final Map<String, dynamic> match;

  const MatchDetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    // Extraer datos con seguridad
    final home = match['home'] ?? 'Equipo Local';
    final away = match['away'] ?? 'Equipo Visitante';
    final homeScore = match['homeScore'];
    final awayScore = match['awayScore'];
    final date = match['date'] ?? 'Fecha por definir';
    final time = match['time'] ?? 'Hora por definir';
    final stadium = match['stadium'] ?? 'Estadio por definir';
    final competition = match['competition'] ?? 'Amistoso';

    final isPlayed = homeScore != null && awayScore != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          competition,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black, // Explicitly black
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Scoreboard Card
            CustomCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Home
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              width: home == 'Wilstermann' ? 88.0 : 80.0,
                              height: home == 'Wilstermann' ? 88.0 : 80.0,
                              child: Image.asset(
                                TeamHelper.getTeamIcon(home),
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.shield,
                                    color: Colors.grey,
                                    size: 40,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              home,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      // VS or Score
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            if (isPlayed)
                              Text(
                                '$homeScore - $awayScore',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              )
                            else
                              Text(
                                time,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (!isPlayed)
                              const Text(
                                'VS',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Away
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              width: away == 'Wilstermann' ? 88.0 : 80.0,
                              height: away == 'Wilstermann' ? 88.0 : 80.0,
                              child: Image.asset(
                                TeamHelper.getTeamIcon(away),
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.shield,
                                    color: Colors.grey,
                                    size: 40,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              away,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Info Row
            _buildInfoRow(Icons.calendar_today, 'Fecha', date),
            _buildInfoRow(Icons.stadium, 'Estadio', stadium),
            _buildInfoRow(
                Icons.location_city, 'Ciudad', match['city'] ?? 'Bolivia'),

            const SizedBox(height: 24),

            // Placeholder stats
            if (isPlayed) ...[
              const Text(
                'Estadísticas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildStatBar('Posesión', 0.6, '60%', '40%'),
              _buildStatBar('Remates', 0.7, '12', '5'),
              _buildStatBar('Faltas', 0.4, '8', '12'),
              const SizedBox(height: 24),
              _buildMinuteByMinute(),
            ] else ...[
              const Center(
                child: Text(
                  'Partido pronto a disputarse.\n¡Compra tus entradas en la tienda!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, double value, String v1, String v2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(v1, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(v2, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.red.withOpacity(0.2),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinuteByMinute() {
    final events = [
      {'time': '90+4\'', 'title': 'Final del partido', 'type': 'whistle'},
      {
        'time': '88\'',
        'title': '¡Gol de Wilstermann!',
        'description': 'Rodrigo Amaral marca el 6-3 definitivo.',
        'type': 'goal'
      },
      {
        'time': '75\'',
        'title': 'Tarjeta Amarilla',
        'description': 'Falta táctica en medio campo.',
        'type': 'card'
      },
      {
        'time': '60\'',
        'title': 'Cambio en Wilstermann',
        'description': 'Sale Pochi Chavez, entra Rudy Cardozo.',
        'type': 'sub'
      },
      {'time': '45\'', 'title': 'Inicio del segundo tiempo', 'type': 'whistle'},
      {'time': '12\'', 'title': 'Gol de Guabirá', 'type': 'goal_against'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Minuto a Minuto',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            final isLast = index == events.length - 1;

            IconData icon;
            Color iconColor;
            switch (event['type']) {
              case 'goal':
                icon = Icons.sports_soccer;
                iconColor = AppColors.primary;
                break;
              case 'goal_against':
                icon = Icons.sports_soccer;
                iconColor = Colors.red;
                break;
              case 'card':
                icon = Icons.style;
                iconColor = Colors.amber;
                break;
              case 'sub':
                icon = Icons.compare_arrows;
                iconColor = Colors.blue;
                break;
              case 'whistle':
              default:
                icon = Icons.sports;
                iconColor = Colors.grey;
                break;
            }

            return IntrinsicHeight(
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        Text(
                          event['time'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: Colors.grey.shade200,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(icon, size: 20, color: iconColor),
                            const SizedBox(width: 8),
                            Text(
                              event['title'] as String,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        if (event.containsKey('description')) ...[
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: Text(
                              event['description'] as String,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
