import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/constants/colors.dart';

class RegisterProfileModal extends StatefulWidget {
  final VoidCallback onProfileRegistered;

  const RegisterProfileModal({super.key, required this.onProfileRegistered});

  @override
  State<RegisterProfileModal> createState() => _RegisterProfileModalState();
}

class _RegisterProfileModalState extends State<RegisterProfileModal> {
  final _formKey = GlobalKey<FormState>();
  bool _isAviadorCuna = false; // Toggle state

  // Controllers
  final _namesController = TextEditingController();
  final _lastNamesController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  final _complementController = TextEditingController(); // Opcional
  final _razonSocialController = TextEditingController();
  final _nitController = TextEditingController();
  final _addressController = TextEditingController();

  // Dropdown values
  String? _selectedGender;
  String? _selectedExpedition;
  String? _selectedCountry = 'Bolivia';
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header del Modal
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Registro de nuevo perfil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Completa la información requerida (*) para crear un perfil',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 20),

                    // Toggle Aviador / Aviadores desde la cuna
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _isAviadorCuna = false),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: !_isAviadorCuna
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Aviador',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: !_isAviadorCuna
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _isAviadorCuna = true),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _isAviadorCuna
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Aviadores desde la cuna',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _isAviadorCuna
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Fila 1: Nombres y Apellidos
                    Row(
                      children: [
                        Expanded(
                            child:
                                _buildTextField('Nombres*', _namesController)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildTextField(
                                'Apellidos*', _lastNamesController)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Fila 2: Fecha Nacimiento
                    _buildDatePicker('Fecha de nacimiento*', _dobController),
                    const SizedBox(height: 16),

                    // Fila 3: Email y Celular
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(
                                'Correo electrónico*', _emailController,
                                keyboardType: TextInputType.emailAddress)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildTextField('Celular*', _phoneController,
                                keyboardType: TextInputType.phone)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Fila 4: Sexo
                    _buildDropdown(
                        'Sexo*',
                        _selectedGender,
                        ['Masculino', 'Femenino'],
                        (val) => setState(() => _selectedGender = val)),
                    const SizedBox(height: 16),

                    // Fila 5: CI y Expedición (Row de 3 elementos: CI, Expedición, Complemento)
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: _buildTextField(
                                'Número de C.I.*', _idController)),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: _buildDropdown(
                              'Expedición*',
                              _selectedExpedition,
                              [
                                'CB',
                                'LP',
                                'SC',
                                'OR',
                                'PT',
                                'TJ',
                                'CH',
                                'BE',
                                'PA'
                              ],
                              (val) =>
                                  setState(() => _selectedExpedition = val)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                            flex: 1,
                            child: _buildTextField(
                                'Comp.', _complementController)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Fila 6: Razón Social y NIT (Facturación)
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(
                                'Razón social', _razonSocialController)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTextField('NIT', _nitController)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Fila 7: País y Ciudad
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(
                              'País*',
                              _selectedCountry,
                              ['Bolivia'],
                              (val) => setState(() => _selectedCountry = val)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDropdown(
                              'Ciudad*',
                              _selectedCity,
                              [
                                'Cochabamba',
                                'La Paz',
                                'Santa Cruz',
                                'Oruro',
                                'Potosí',
                                'Tarija',
                                'Sucre',
                                'Trinidad',
                                'Cobija'
                              ],
                              (val) => setState(() => _selectedCity = val)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Fila 8: Dirección
                    _buildTextField('Dirección*', _addressController),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          // Footer buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onProfileRegistered();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .grey.shade300, // Disabled look initially like image
                      foregroundColor:
                          Colors.black, // Cambiar a primary cuando sea válido
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Registrar perfil'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: label.contains('*') ? 'Escriba aquí...' : 'Opcional',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
            isDense: true,
          ),
          validator: (value) {
            if (label.contains('*') && (value == null || value.isEmpty)) {
              return 'Requerido';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              // Formato simple dd/mm/aaaa
              String formattedDate =
                  "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
              controller.text = formattedDate;
            }
          },
          decoration: InputDecoration(
            hintText: 'dd/mm/aaaa',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            suffixIcon:
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
            isDense: true,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Requerido';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items,
      Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Seleccione...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
            isDense: true,
          ),
          validator: (val) {
            if (label.contains('*') && val == null) return 'Requerido';
            return null;
          },
        ),
      ],
    );
  }
}
