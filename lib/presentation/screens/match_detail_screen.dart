import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
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
        title: Text(competition),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
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
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child:
                                  const Icon(Icons.shield, color: Colors.grey),
                              // TODO: Use team logos
                            ),
                            const SizedBox(height: 8),
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
                              ),
                            if (!isPlayed)
                              const Text(
                                'VS',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Away
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child:
                                  const Icon(Icons.shield, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
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
}
