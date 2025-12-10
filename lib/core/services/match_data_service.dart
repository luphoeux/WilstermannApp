import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:wilstermann_app/core/utils/logger.dart';

class MatchDataService {
  // Cargar partidos futuros
  Future<List<Map<String, dynamic>>> loadUpcomingMatches() async {
    try {
      final csvData =
          await rootBundle.loadString('assets/data/partidos_futuros.csv');
      List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

      if (rows.isEmpty) return [];

      // Primera fila son los headers
      final headers = rows[0].map((e) => e.toString()).toList();

      // Convertir filas a mapas
      return rows.skip(1).where((row) {
        // Filtrar filas vacías
        return row.any((cell) => cell.toString().trim().isNotEmpty);
      }).map((row) {
        Map<String, dynamic> match = {};
        for (int i = 0; i < headers.length && i < row.length; i++) {
          match[headers[i]] = row[i].toString();
        }
        return match;
      }).toList();
    } catch (e, stackTrace) {
      Logger.error('Error loading upcoming matches', e, stackTrace);
      return [];
    }
  }

  // Cargar partidos pasados
  Future<List<Map<String, dynamic>>> loadPastMatches() async {
    try {
      final csvData =
          await rootBundle.loadString('assets/data/partidos_pasados.csv');
      List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

      if (rows.isEmpty) return [];

      final headers = rows[0].map((e) => e.toString()).toList();

      return rows.skip(1).where((row) {
        return row.any((cell) => cell.toString().trim().isNotEmpty);
      }).map((row) {
        Map<String, dynamic> match = {};
        for (int i = 0; i < headers.length && i < row.length; i++) {
          match[headers[i]] = row[i].toString();
        }
        return match;
      }).toList();
    } catch (e, stackTrace) {
      Logger.error('Error loading past matches', e, stackTrace);
      return [];
    }
  }

  // Cargar tabla de posiciones
  Future<List<Map<String, dynamic>>> loadStandings() async {
    try {
      final csvData =
          await rootBundle.loadString('assets/data/tabla_posiciones.csv');
      List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

      if (rows.isEmpty) return [];

      final headers = rows[0].map((e) => e.toString()).toList();

      return rows.skip(1).where((row) {
        return row.any((cell) => cell.toString().trim().isNotEmpty);
      }).map((row) {
        Map<String, dynamic> standing = {};
        for (int i = 0; i < headers.length && i < row.length; i++) {
          standing[headers[i]] = row[i].toString();
        }
        return standing;
      }).toList();
    } catch (e, stackTrace) {
      Logger.error('Error loading standings', e, stackTrace);
      return [];
    }
  }
}
