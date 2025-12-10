import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/colors.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, String> news;

  const NewsDetailScreen({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar con imagen
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: const Icon(
                  Icons.article,
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ),
          ),

          // Contenido
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y fecha
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news['title'] ?? 'Sin título',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              news['date'] ?? 'Sin fecha',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade200,
                  ),

                  // Contenido de la noticia
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      news['content'] ?? 'Sin contenido disponible.',
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Contenido adicional (simulado)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Botón de compartir
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final title = news['title'] ?? 'Sin título';
                          final content = news['content'] ?? '';
                          Share.share(
                            '$title\n\n$content\n\n¡Vamos Aviador! 🔴⚪',
                            subject: title,
                          );
                        },
                        icon: const Icon(Icons.share, size: 20),
                        label: const Text(
                          'Compartir noticia',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
