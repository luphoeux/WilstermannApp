import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Términos y condiciones',
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryVeryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  Expanded(
                    child: Text(
                      'Términos y condiciones de compra de abonos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contenido de términos
            _buildTermItem(
              '1',
              'El abono adquirido es personal e intransferible.',
            ),
            _buildTermItem(
              '2',
              'El comprador debe ser mayor de edad y tener capacidad legal para adquirir la sociedad.',
            ),
            _buildTermItem(
              '3',
              'El comprador debe pagar el precio acordado por el abono, ya sea al contado o en el plan de cuotas permitido.',
            ),
            _buildTermItem(
              '4',
              'En caso de que el abono haya sido adquirido a plan de cuotas, el comprador acepta que en caso de no realizar los pagos, se bloquea el derecho de todos los beneficios del abono hasta que el comprador cumpla con sus cuotas correspondientes.',
            ),
            _buildTermItem(
              '5',
              'El comprador acepta que dicho abono es un aporte voluntario al Club Wilstermann.',
            ),
            _buildTermItem(
              '6',
              'El comprador no puede utilizar el abono adquirido para fines ilegales o inmorales.',
            ),
            _buildTermItem(
              '7',
              'El comprador no puede utilizar el abono adquirido para fines publicitarios sin el consentimiento del Club Wilstermann.',
            ),
            _buildTermItem(
              '8',
              'El Club Wilstermann se reserva el derecho de revocar el abono adquirido si el comprador incumple cualquiera de los términos y condiciones establecidas.',
            ),

            const SizedBox(height: 32),

            // Nota final
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade600,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Al realizar la compra de un abono, aceptas automáticamente estos términos y condiciones.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTermItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
