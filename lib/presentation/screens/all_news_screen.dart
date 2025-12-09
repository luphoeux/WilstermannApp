import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../widgets/custom_card.dart';
import 'news_detail_screen.dart';

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({super.key});

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _allNews = [
    {
      'id': '1',
      'title': 'Wilstermann se prepara para el clásico',
      'date': 'Hace 2 horas',
      'image': 'assets/images/news1.jpg',
      'content':
          'El equipo aviador intensifica sus entrenamientos de cara al clásico cochabambino del próximo domingo. Los jugadores muestran un gran nivel de compromiso y determinación para conseguir la victoria en este importante encuentro.',
    },
    {
      'id': '2',
      'title': 'Nuevos refuerzos para la temporada 2026',
      'date': 'Hace 5 horas',
      'image': 'assets/images/news2.jpg',
      'content':
          'La directiva del club confirma la llegada de tres nuevos jugadores para reforzar el plantel. Los fichajes buscan fortalecer las posiciones clave del equipo para competir por el título.',
    },
    {
      'id': '3',
      'title': 'Entrevista exclusiva con el DT',
      'date': 'Hace 1 día',
      'image': 'assets/images/news3.jpg',
      'content':
          'El director técnico habla sobre los objetivos del equipo para esta temporada y destaca el trabajo realizado en la pretemporada. Confía en que el plantel está listo para los desafíos que vienen.',
    },
    {
      'id': '4',
      'title': 'Wilstermann gana en el Félix Capriles',
      'date': 'Hace 2 días',
      'image': 'assets/images/news4.jpg',
      'content':
          'Gran victoria del aviador en casa con un marcador de 3-1. Los goles fueron anotados por los delanteros del equipo en una noche memorable para la hinchada.',
    },
    {
      'id': '5',
      'title': 'Presentación de la nueva camiseta 2026',
      'date': 'Hace 3 días',
      'image': 'assets/images/news5.jpg',
      'content':
          'El club presenta oficialmente la nueva indumentaria para la temporada 2026. El diseño mantiene los colores tradicionales con detalles modernos que honran la historia del club.',
    },
    {
      'id': '6',
      'title': 'Juveniles de Wilstermann campeones',
      'date': 'Hace 4 días',
      'image': 'assets/images/news6.jpg',
      'content':
          'Las divisiones menores del club consiguen el campeonato departamental. Un logro que demuestra el excelente trabajo en las categorías formativas.',
    },
    {
      'id': '7',
      'title': 'Wilstermann en la Copa Sudamericana',
      'date': 'Hace 5 días',
      'image': 'assets/images/news7.jpg',
      'content':
          'El equipo se prepara para su participación en la Copa Sudamericana. Los entrenamientos se intensifican pensando en el debut internacional.',
    },
    {
      'id': '8',
      'title': 'Homenaje a leyendas del club',
      'date': 'Hace 6 días',
      'image': 'assets/images/news8.jpg',
      'content':
          'El club rinde homenaje a sus leyendas en una emotiva ceremonia. Jugadores históricos recibieron reconocimientos por su aporte al aviador.',
    },
    {
      'id': '9',
      'title': 'Wilstermann lidera la tabla',
      'date': 'Hace 1 semana',
      'image': 'assets/images/news9.jpg',
      'content':
          'El equipo se posiciona en el primer lugar de la tabla de posiciones. La consistencia en los resultados mantiene al aviador en la cima.',
    },
    {
      'id': '10',
      'title': 'Inauguración de nueva sede social',
      'date': 'Hace 1 semana',
      'image': 'assets/images/news10.jpg',
      'content':
          'El club inaugura su nueva sede social con instalaciones de primer nivel. Un espacio moderno para los socios y simpatizantes del aviador.',
    },
  ];

  final List<Map<String, String>> _displayedNews = [];
  int _currentPage = 0;
  final int _itemsPerPage = 3;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMoreNews();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      _loadMoreNews();
    }
  }

  void _loadMoreNews() {
    if (_isLoading || _displayedNews.length >= _allNews.length) return;

    setState(() {
      _isLoading = true;
    });

    // Simular carga (como Facebook)
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      final int startIndex = _currentPage * _itemsPerPage;
      final int endIndex =
          (startIndex + _itemsPerPage).clamp(0, _allNews.length);

      setState(() {
        _displayedNews.addAll(_allNews.sublist(startIndex, endIndex));
        _currentPage++;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas las Noticias'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _displayedNews.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _displayedNews.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            );
          }

          final news = _displayedNews[index];
          return CustomCard(
            margin: const EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.zero,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewsDetailScreen(news: news),
                ),
              );
            },
            child: Row(
              children: [
                // Imagen
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
                // Contenido
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news['title']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          news['date']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Icono chevron
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
        },
      ),
    );
  }
}
