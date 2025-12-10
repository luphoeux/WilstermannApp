import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../widgets/custom_card.dart';
import 'register_profile_modal.dart';
import 'payment_selection_screen.dart';
import 'seat_selector_screen.dart';

class PurchaseDetailScreen extends StatefulWidget {
  final Map<String, dynamic> abono;

  const PurchaseDetailScreen({super.key, required this.abono});

  @override
  State<PurchaseDetailScreen> createState() => _PurchaseDetailScreenState();
}

class _PurchaseDetailScreenState extends State<PurchaseDetailScreen> {
  // Estado
  String? _selectedProfile;
  final List<String> _profiles = ['Luis Perez']; // Ejemplo
  bool _acceptTerms = false;

  // Asiento seleccionado (solo para Preferencia Numerada)
  String? _selectedRow;
  int? _selectedSeat;

  // Controladores
  final _discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Completar Compra',
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
          children: [
            // Pasos (Stepper visual simplificado)
            _buildStepsIndicator(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'COMPLETA LOS DETALLES NECESARIOS',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sección Perfil
                  CustomCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PERFIL ACTUAL',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Column(
                            children: [
                              const Icon(Icons.shield_outlined,
                                  size: 40, color: AppColors.primary),
                              const SizedBox(height: 8),
                              const Text(
                                'LUIS PEREZ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text('8337710 LP',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Cambiar perfil',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedProfile ?? _profiles.first,
                              items: _profiles
                                  .map((p) => DropdownMenuItem(
                                      value: p, child: Text(p)))
                                  .toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedProfile = val),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _showRegisterModal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Registrar perfil',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Formulario de Detalles
                  const Text('FORMATO DE PAGO Y CREDENCIAL',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 12)),
                  const SizedBox(height: 16),

                  _buildReadOnlyField('Sector*', widget.abono['title']),
                  const SizedBox(height: 12),
                  _buildReadOnlyField('Tipo de pago*', 'Contado'),
                  const SizedBox(height: 12),
                  _buildReadOnlyField('Tipo de credencial*', 'Tarjeta física'),
                  const SizedBox(height: 12),
                  _buildReadOnlyField('Sucursal de recepción*',
                      'Sede Wilstermann - Calle Ecuador'),

                  // Selector de asiento (solo para Preferencia Numerada)
                  if (widget.abono['title'] == 'Preferencia Numerada') ...[
                    const SizedBox(height: 12),
                    _buildSeatSelectorField(),
                  ],

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.red.shade700),
                      const SizedBox(width: 4),
                      Text('Sede Wilstermann',
                          style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Términos y condiciones
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (val) =>
                            setState(() => _acceptTerms = val ?? false),
                        activeColor: Colors.red,
                      ),
                      const Expanded(
                        child: Text(
                          'Acepto los términos y condiciones de compra',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Botón Continuar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _acceptTerms ? _goToPayment : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary, // Dark blue
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Continuar',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Descuentos
                  const Text('DESCUENTOS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 12)),
                  const SizedBox(height: 8),
                  const Text('Código de descuento:',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _discountController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300)),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        child: const Text('Aplicar'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Resumen de Orden
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
                        _buildSummaryRow(
                            'Pago 2026 - 1 - ${widget.abono['title']}',
                            widget.abono['price']),
                        _buildSummaryRow('Extras', 'Subtotal', isHeader: true),
                        _buildSummaryRow('Tarjeta física', 'Bs 0'),
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.grey.shade200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Precio Total',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(widget.abono['price'],
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

  void _showRegisterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: RegisterProfileModal(
          onProfileRegistered: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Perfil registrado correctamente')),
            );
            // Aquí podríamos actualizar la lista de perfiles
          },
        ),
      ),
    );
  }

  void _goToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => PaymentSelectionScreen(abono: widget.abono)),
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
          _StepItem(
              icon: Icons.radio_button_checked,
              label: 'COMPLETA',
              active: true),
          _StepItem(
              icon: Icons.radio_button_unchecked,
              label: 'FINALIZA',
              active: false),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value,
                  style: const TextStyle(fontSize: 13, color: Colors.black87)),
              const Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSeatSelectorField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seleccionar asiento*',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SeatSelectorScreen(),
              ),
            );

            if (result != null && result is Map<String, dynamic>) {
              setState(() {
                _selectedRow = result['row'];
                _selectedSeat = result['seat'];
              });
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _selectedRow != null && _selectedSeat != null
                    ? AppColors.primary
                    : Colors.grey.shade300,
                width: _selectedRow != null && _selectedSeat != null ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectedRow != null && _selectedSeat != null
                    ? Row(
                        children: [
                          const Icon(
                            Icons.event_seat,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Fila $_selectedRow - Asiento $_selectedSeat',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Toca para seleccionar tu asiento',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
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
