import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../widgets/custom_card.dart';

class PaymentSelectionScreen extends StatelessWidget {
  final Map<String, dynamic> abono;

  const PaymentSelectionScreen({super.key, required this.abono});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finalizar Compra',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pasos
            _buildStepsIndicator(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FINALIZAR COMPRA',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sección Pago con Libélula
                  CustomCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PAGO CON LIBÉLULA',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Red enlace / cybersource - tarjetas de crédito y débito',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        _buildPaymentOption('QR Simple'),
                        _buildPaymentOption(
                            'Red Enlace / Cybersource - Tarjetas de crédito y débito'),
                        _buildPaymentOption('BCP Pagos'),
                        _buildPaymentOption('Tigo Money'),
                        _buildPaymentOption('BNB (Banca por internet)'),
                        _buildPaymentOption('RED SUPA (Pagos en efectivo)'),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _showSuccessDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.primary, // Dark blue like image
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('+ Realizar Pago',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Resumen Final
                  const Text('SU ORDEN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 12)),
                  const SizedBox(height: 12),
                  CustomCard(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        _buildSummaryRow('Productos', 'Subtotal',
                            isHeader: true),
                        _buildSummaryRow('Pago 2026 - 1 - ${abono['title']}',
                            abono['price']),
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.grey.shade200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Precio Total',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(abono['price'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) async {
    // Si necesitas realizar alguna limpieza, hazlo aquí.

    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 16),
            Text(
              '¡Orden Generada!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Serás redirigido a la pasarela de pagos para completar tu transacción.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close Payment Screen
                Navigator.pop(context); // Close Detail Screen (Return to Store)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Entendido',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.circle, size: 6, color: Colors.black87),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Text(text,
                  style: const TextStyle(fontSize: 13, color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String col1, String col2, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isHeader ? Colors.grey.shade50 : Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(col1,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal))),
          Text(col2,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildStepsIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StepItem(
              icon: Icons.check_circle, label: 'SELECCIONAR', active: true),
          _StepItem(icon: Icons.check_circle, label: 'COMPLETA', active: true),
          _StepItem(
              icon: Icons.radio_button_checked,
              label: 'FINALIZA',
              active: true),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _StepItem(
      {required this.icon, required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: active ? AppColors.primary : Colors.grey),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 8,
                color: active ? AppColors.primary : Colors.grey,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
