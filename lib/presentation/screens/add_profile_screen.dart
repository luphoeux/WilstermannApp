import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/services/profile_service.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profileService = ProfileService();
  bool _isAviador = true;

  // Controllers
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _fechaNacimientoController =
      TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _ciController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _razonSocialController = TextEditingController();
  final TextEditingController _nitController = TextEditingController();

  String? _sexoSeleccionado;
  String? _expedicionSeleccionada;

  @override
  void dispose() {
    _nombresController.dispose();
    _apellidosController.dispose();
    _fechaNacimientoController.dispose();
    _correoController.dispose();
    _celularController.dispose();
    _ciController.dispose();
    _complementoController.dispose();
    _razonSocialController.dispose();
    _nitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de nuevo perfil'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Completa la información requerida (*) para crear un perfil',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 24),

              // Selector Aviador / Aviadores desde la cuna
              Row(
                children: [
                  Expanded(
                    child: _buildToggleButton(
                      'Aviador',
                      _isAviador,
                      () => setState(() => _isAviador = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildToggleButton(
                      'Aviadores desde la cuna',
                      !_isAviador,
                      () => setState(() => _isAviador = false),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Nombres y Apellidos
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _nombresController,
                      label: 'Nombres*',
                      required: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _apellidosController,
                      label: 'Apellidos*',
                      required: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Fecha de nacimiento
              _buildDateField(),

              const SizedBox(height: 16),

              // Correo y Celular
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _correoController,
                      label: 'Correo electrónico*',
                      keyboardType: TextInputType.emailAddress,
                      required: true,
                      emailValidation: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _celularController,
                      label: 'Celular*',
                      keyboardType: TextInputType.phone,
                      required: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Sexo
              _buildDropdown(
                label: 'Sexo*',
                value: _sexoSeleccionado,
                items: const [
                  DropdownMenuItem(value: 'M', child: Text('Masculino')),
                  DropdownMenuItem(value: 'F', child: Text('Femenino')),
                  DropdownMenuItem(value: 'O', child: Text('Otro')),
                ],
                onChanged: (value) {
                  setState(() {
                    _sexoSeleccionado = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // CI
              _buildTextField(
                controller: _ciController,
                label: 'Número de C.I.*',
                keyboardType: TextInputType.number,
                required: true,
              ),

              const SizedBox(height: 16),

              // Expedición y Complemento
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildDropdown(
                      label: 'Expedición*',
                      value: _expedicionSeleccionada,
                      items: const [
                        DropdownMenuItem(value: 'LP', child: Text('La Paz')),
                        DropdownMenuItem(
                            value: 'CB', child: Text('Cochabamba')),
                        DropdownMenuItem(
                            value: 'SC', child: Text('Santa Cruz')),
                        DropdownMenuItem(value: 'OR', child: Text('Oruro')),
                        DropdownMenuItem(value: 'PT', child: Text('Potosí')),
                        DropdownMenuItem(value: 'TJ', child: Text('Tarija')),
                        DropdownMenuItem(
                            value: 'CH', child: Text('Chuquisaca')),
                        DropdownMenuItem(value: 'BE', child: Text('Beni')),
                        DropdownMenuItem(value: 'PD', child: Text('Pando')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _expedicionSeleccionada = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: _buildTextField(
                      controller: _complementoController,
                      label: 'Complemento',
                      required: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Razón Social y NIT (opcionales)
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _razonSocialController,
                      label: 'Razón social',
                      required: false,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _nitController,
                      label: 'NIT',
                      keyboardType: TextInputType.number,
                      required: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botones
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                            color: AppColors.primary, width: 2),
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _registrarPerfil,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Registrar perfil',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool required = false,
    bool emailValidation = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: required ? 'Escribe aquí...' : 'Opcional',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return 'Campo requerido';
        }
        if (emailValidation && value != null && value.isNotEmpty) {
          if (!value.contains('@') || !value.contains('.')) {
            return 'Correo inválido';
          }
        }
        return null;
      },
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _fechaNacimientoController,
      decoration: InputDecoration(
        labelText: 'Fecha de nacimiento*',
        hintText: 'dd/mm/aaaa',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today, color: AppColors.primary),
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate:
                  DateTime.now().subtract(const Duration(days: 365 * 18)),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primary,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              setState(() {
                _fechaNacimientoController.text =
                    '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
              });
            }
          },
        ),
      ),
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      hint: const Text('Seleccione...'),
      isExpanded: true,
      items: items,
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Campo requerido';
        }
        return null;
      },
    );
  }

  void _registrarPerfil() async {
    if (_formKey.currentState!.validate()) {
      // Construir el nombre completo del perfil
      final nombreCompleto =
          '${_nombresController.text.trim()} ${_apellidosController.text.trim()}';

      // Guardar el perfil en el servicio
      await _profileService.setProfileName(nombreCompleto);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Perfil "$nombreCompleto" registrado exitosamente'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
