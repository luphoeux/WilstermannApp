import 'package:flutter/material.dart';

class SeatSelectorScreen extends StatefulWidget {
  const SeatSelectorScreen({super.key});

  @override
  State<SeatSelectorScreen> createState() => _SeatSelectorScreenState();
}

class _SeatSelectorScreenState extends State<SeatSelectorScreen> {
  String? _selectedRow;
  int? _selectedSeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Seleccionar asientos',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF0A0E27),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Espacio para iframe - Vista del estadio
          Expanded(
            child: Container(
              color: const Color(0xFF0A0E27),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.stadium,
                      size: 80,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Vista de Estadio',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'El iframe se cargará aquí',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Panel inferior con botones
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0E27),
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade800,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.white30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _selectedRow != null && _selectedSeat != null
                        ? () {
                            Navigator.pop(context, {
                              'row': _selectedRow,
                              'seat': _selectedSeat,
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      disabledBackgroundColor: Colors.grey.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
