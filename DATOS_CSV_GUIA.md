# 📊 Sistema de Datos CSV para Wilstermann App

## ✅ Archivos creados:

### 📁 Ubicación: `assets/data/`

1. **partidos_futuros.csv** - Partidos próximos a jugar
2. **partidos_pasados.csv** - Resultados de partidos jugados  
3. **tabla_posiciones.csv** - Tabla de posiciones de la liga

## 📝 Cómo editar los datos:

### Opción 1: Editar directamente los CSV
1. Abre los archivos con Excel, Google Sheets o cualquier editor de texto
2. Edita los datos manteniendo el formato
3. Guarda como CSV (separado por comas)

### Opción 2: Usar Excel con múltiples hojas
1. Abre Excel
2. Crea un nuevo libro
3. Importa cada CSV como una hoja separada:
   - Hoja 1: partidos_futuros
   - Hoja 2: partidos_pasados
   - Hoja 3: tabla_posiciones
4. Edita los datos
5. Cuando termines, exporta cada hoja como CSV

## 🔧 Servicio creado:

**Archivo**: `lib/core/services/match_data_service.dart`

### Métodos disponibles:

```dart
final matchService = MatchDataService();

// Cargar partidos futuros
List<Map<String, dynamic>> upcomingMatches = await matchService.loadUpcomingMatches();

// Cargar partidos pasados
List<Map<String, dynamic>> pastMatches = await matchService.loadPastMatches();

// Cargar tabla de posiciones
List<Map<String, dynamic>> standings = await matchService.loadStandings();
```

## 📋 Estructura de datos:

### Partidos Futuros
```dart
{
  'fecha': '2025-12-15',
  'hora': '16:00',
  'equipo_local': 'Wilstermann',
  'equipo_visitante': 'The Strongest',
  'estadio': 'Estadio Félix Capriles',
  'competicion': 'Liga Profesional',
  'ciudad': 'Cochabamba'
}
```

### Partidos Pasados
```dart
{
  'fecha': '2025-12-08',
  'hora': '16:00',
  'equipo_local': 'Wilstermann',
  'equipo_visitante': 'San José',
  'goles_local': '3',
  'goles_visitante': '1',
  'estadio': 'Estadio Félix Capriles',
  'competicion': 'Liga Profesional',
  'ciudad': 'Cochabamba'
}
```

### Tabla de Posiciones
```dart
{
  'posicion': '3',
  'equipo': 'Wilstermann',
  'pj': '30',
  'pg': '17',
  'pe': '7',
  'pp': '6',
  'gf': '49',
  'gc': '30',
  'dg': '19',
  'pts': '58'
}
```

## 🚀 Próximos pasos:

1. **Edita los archivos CSV** con tus datos reales
2. **Integra el servicio** en las pantallas de fixture y tabla de posiciones
3. **Reinicia la app** después de editar los CSV para ver los cambios

## ⚠️ Importante:

- NO cambies los nombres de las columnas (primera fila)
- Si una fila está vacía, no se mostrará
- Puedes tener desde 1 hasta 10+ filas (la app se ajusta automáticamente)
- Los archivos deben estar en formato CSV (separado por comas)
- Después de editar, necesitas hacer hot restart (no hot reload)

## 💡 Ejemplo de uso en una pantalla:

```dart
import 'package:wilstermann_app/core/services/match_data_service.dart';

class FixtureScreen extends StatefulWidget {
  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  final _matchService = MatchDataService();
  List<Map<String, dynamic>> _upcomingMatches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    final matches = await _matchService.loadUpcomingMatches();
    setState(() {
      _upcomingMatches = matches;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _upcomingMatches.length,
      itemBuilder: (context, index) {
        final match = _upcomingMatches[index];
        return ListTile(
          title: Text('${match['equipo_local']} vs ${match['equipo_visitante']}'),
          subtitle: Text('${match['fecha']} - ${match['hora']}'),
        );
      },
    );
  }
}
```

## 📦 Dependencias instaladas:

- ✅ `csv: ^6.0.0` - Para leer archivos CSV
- ✅ Assets configurados en `pubspec.yaml`

¡Todo listo para que empieces a llenar los datos! 🎉
